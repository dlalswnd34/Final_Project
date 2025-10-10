package com.simplecoding.cheforest.jpa.guide;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GuideController {

    @GetMapping("/support/guide")
    public String guidePage() {
        return "support/guide";
    }
}
