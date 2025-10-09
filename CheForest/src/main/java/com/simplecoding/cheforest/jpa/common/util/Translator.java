package com.simplecoding.cheforest.jpa.common.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Slf4j
@Component
public class Translator {

    @Autowired
    private RestTemplate restTemplate;

    @Value("${deepl.api.url}")
    private String apiUrl;

    @Value("${deepl.api.key}")
    private String apiKey;

    // ✅ 요청 생성 공통 함수
    private HttpEntity<MultiValueMap<String, String>> buildRequest(String text, String lang) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Authorization", "DeepL-Auth-Key " + apiKey);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("text", text);
        params.add("target_lang", lang);

        return new HttpEntity<>(params, headers);
    }

    // ✅ 안전한 단일 번역 (재시도 + 딜레이)
    public String translate(String text, String lang) {
        if (text == null || text.isBlank()) return "";

        int maxRetry = 3; // 3회 재시도
        for (int attempt = 1; attempt <= maxRetry; attempt++) {
            try {
                HttpEntity<?> request = buildRequest(text, lang);
                ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, request, Map.class);

                List<Map<String, String>> translations =
                        (List<Map<String, String>>) response.getBody().get("translations");

                if (translations == null || translations.isEmpty()) {
                    log.warn("⚠ 번역 실패 (응답 없음) [{}회차]: {}", attempt, response.getBody());
                    continue; // 재시도
                }

                // 성공 시 결과 반환
                String result = translations.get(0).get("text");
                // DeepL Free API는 초당 1~2회만 허용 → 0.8초 딜레이
                TimeUnit.MILLISECONDS.sleep(800);
                return result;

            } catch (Exception e) {
                log.warn("❌ 번역 오류 [{}회차]: {}", attempt, e.getMessage());
                try {
                    // 재시도 전 대기
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException ignored) {}
            }
        }

        // 3회 실패 시 원문 반환
        log.error("❌ 번역 완전 실패: 원문 그대로 반환 ({})", text);
        return text;
    }

    // ✅ 다중 번역 (안정화 + fallback)
    public List<String> translateBulk(List<String> texts, String lang) {
        if (texts == null || texts.isEmpty()) return List.of();

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            headers.set("Authorization", "DeepL-Auth-Key " + apiKey);

            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            for (String text : texts) params.add("text", text);
            params.add("target_lang", lang);

            HttpEntity<?> request = new HttpEntity<>(params, headers);
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, request, Map.class);

            List<Map<String, String>> translations =
                    (List<Map<String, String>>) response.getBody().get("translations");

            if (translations == null || translations.size() != texts.size()) {
                log.warn("⚠ 일부 누락 감지: 요청 {}, 응답 {}",
                        texts.size(), translations != null ? translations.size() : 0);
                // 개별 번역 fallback
                return texts.stream()
                        .map(t -> translate(t, lang))
                        .collect(Collectors.toList());
            }

            // ✅ 정상 응답
            List<String> results = translations.stream()
                    .map(map -> map.get("text"))
                    .collect(Collectors.toList());

            // 요청 후 딜레이 (API rate limit 회피)
            TimeUnit.MILLISECONDS.sleep(800);
            return results;

        } catch (Exception e) {
            log.error("❌ 다중 번역 실패, 개별 fallback 실행: {}", e.getMessage());
            return texts.stream()
                    .map(t -> translate(t, lang))
                    .collect(Collectors.toList());
        }
    }
}
