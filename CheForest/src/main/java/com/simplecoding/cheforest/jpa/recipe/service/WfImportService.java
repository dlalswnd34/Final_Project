package com.simplecoding.cheforest.jpa.recipe.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.simplecoding.cheforest.jpa.common.util.Translator;
import com.simplecoding.cheforest.jpa.recipe.entity.Recipe;
import com.simplecoding.cheforest.jpa.recipe.repository.RecipeRepository;
import com.simplecoding.cheforest.jpa.recipe.service.progress.ImportMonitor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.concurrent.atomic.AtomicBoolean;

@Slf4j
@Service
@RequiredArgsConstructor
public class WfImportService {

    private final RestTemplate restTemplate;
    private final ObjectMapper om = new ObjectMapper();
    private final RecipeRepository repo;
    private final Translator translator;
    private final ImportMonitor monitor;   // ✅ 진행률 모니터 추가

    private final AtomicBoolean running = new AtomicBoolean(false);

    @Transactional
    public String run() {
        final String TASK = "wf"; // ✅ 태스크 이름 (status URL = /admin/import/status/wf)
        if (!running.compareAndSet(false, true)) return "이미 실행 중입니다.";

        int saved = 0, skipped = 0, total = 0;
        try {
            monitor.start(TASK, 0);
            monitor.touch(TASK, "fetch", null);

            // 1️⃣ 1차 필터링 요청
            String[] filters = {
                    "https://www.themealdb.com/api/json/v1/1/filter.php?a=Japanese",
                    "https://www.themealdb.com/api/json/v1/1/filter.php?a=Chinese"
            };

            // 총 개수 계산
            for (String filterUrl : filters) {
                String fjson = restTemplate.getForObject(filterUrl, String.class);
                JsonNode meals = om.readTree(fjson).path("meals");
                if (meals.isArray()) total += meals.size();
            }
            monitor.start(TASK, total);

            // 2️⃣ 상세 정보 요청 + 번역 + DB 저장
            for (String filterUrl : filters) {
                String fjson = restTemplate.getForObject(filterUrl, String.class);
                JsonNode meals = om.readTree(fjson).path("meals");
                if (!meals.isArray()) continue;

                for (JsonNode m : meals) {
                    if (!running.get()) break;

                    String id = m.path("idMeal").asText();
                    String recipeId = "WF-" + id;
                    monitor.touch(TASK, "save", recipeId);
                    monitor.get(TASK).getProcessed().incrementAndGet();

                    if (repo.existsById(recipeId)) {
                        skipped++;
                        monitor.get(TASK).getSkipped().incrementAndGet();
                        continue;
                    }

                    // 상세 조회
                    String detailUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + id;
                    String djson = restTemplate.getForObject(detailUrl, String.class);
                    JsonNode meal = om.readTree(djson).path("meals").get(0);
                    if (meal == null) continue;

                    String titleEn = meal.path("strMeal").asText("");
                    String instructionEn = meal.path("strInstructions").asText("");
                    String categoryEn = meal.path("strCategory").asText("");
                    String area = meal.path("strArea").asText("");
                    String ingredientEn = joinRange(meal, "strIngredient", 1, 20);
                    String measureEn = joinRange(meal, "strMeasure", 1, 20);
                    String thumb = meal.path("strMealThumb").asText("");

                    // 번역 (진행 단계 반영)
                    monitor.touch(TASK, "translate", recipeId);
                    String titleKr = translator.translate(titleEn, "KO");
                    String instructionKr = translator.translate(instructionEn, "KO");
                    String categoryKr = translator.translate(categoryEn, "KO");
                    String ingredientKr = translator.translate(ingredientEn, "KO");
                    String measureKr = translator.translate(measureEn, "KO");

                    Recipe recipe = Recipe.builder()
                            .recipeId(recipeId)
                            .titleEn(titleEn).instructionEn(instructionEn).categoryEn(categoryEn)
                            .ingredientEn(ingredientEn).measureEn(measureEn)
                            .titleKr(titleKr).instructionKr(instructionKr).categoryKr(categoryKr)
                            .ingredientKr(ingredientKr).measureKr(measureKr)
                            .thumbnail(thumb)
                            .area(area)
                            .likeCount(0L)
                            .viewCount(0L)
                            .dustGood("N")
                            .build();

                    repo.save(recipe);
                    saved++;
                    monitor.get(TASK).getSaved().incrementAndGet();
                }
            }

            monitor.finish(TASK, null);
            log.info("✅ [{}] 완료: saved={}, skipped={}", TASK, saved, skipped);
            return String.format("🍱 WF(TheMealDB) 완료: saved=%d, skipped=%d", saved, skipped);

        } catch (Exception e) {
            log.error("❌ [{}] import 실패", TASK, e);
            monitor.finish(TASK, e.getMessage());
            return "실패: " + e.getMessage();
        } finally {
            running.set(false);
        }
    }

    public void stop() {
        running.set(false);
        monitor.finish("wf", "사용자 중단");
    }

    private String joinRange(JsonNode node, String prefix, int from, int to) {
        StringBuilder sb = new StringBuilder();
        for (int i = from; i <= to; i++) {
            String v = node.path(prefix + i).asText("");
            if (v != null && !v.isBlank() && !v.equalsIgnoreCase("null")) {
                if (!sb.isEmpty()) sb.append(",");
                sb.append(v.trim());
            }
        }
        return sb.toString();
    }
}
