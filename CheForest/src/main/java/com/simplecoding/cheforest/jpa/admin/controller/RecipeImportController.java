package com.simplecoding.cheforest.jpa.admin.controller;

import com.simplecoding.cheforest.jpa.recipe.service.DataKoImportService;
import com.simplecoding.cheforest.jpa.recipe.service.SpoonacularImportService;
import com.simplecoding.cheforest.jpa.recipe.service.WfImportService;
import com.simplecoding.cheforest.jpa.recipe.service.progress.ImportMonitor;
import com.simplecoding.cheforest.jpa.recipe.service.progress.ImportProgress;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class RecipeImportController {

    private final SpoonacularImportService spoonacular;
    private final WfImportService wf;
    private final DataKoImportService datako;
    private final ImportMonitor monitor;

    @PostMapping("/admin/import/spoonacular/run")
    public String runSpoonacular() { return spoonacular.run(); }

    @PostMapping("/admin/import/wf/run")
    public String runWf() { return wf.run(); }

    @PostMapping("/admin/import/datako/run")
    public String runDataKo() { return datako.run(); }

    @PostMapping("/admin/import/stop")
    public String stopAll() {
        spoonacular.stop();
        wf.stop();
        datako.stop();
        monitor.stopAll(); // ✅ 상태 반영

        return "중지 요청 완료";
    }

    @GetMapping("/admin/import/status/{task}")
    public Map<String, Object> getStatus(@PathVariable String task) {
        ImportProgress p = monitor.get(task);
        Map<String, Object> result = new LinkedHashMap<>();

        if (p == null) {
            result.put("status", "대기중");
            result.put("percent", 0);
            return result;
        }

        result.put("task", p.getTask());
        result.put("running", p.isRunning());
        result.put("processed", p.getProcessed().get());
        result.put("saved", p.getSaved().get());
        result.put("skipped", p.getSkipped().get());
        result.put("total", p.getTotal());
        result.put("percent", p.getPercent());
        result.put("stage", p.getStage());
        result.put("lastId", p.getLastId());
        result.put("error", p.getError());
        result.put("updatedAt", p.getUpdatedAt());

        return result;
    }
}
