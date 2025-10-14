package com.simplecoding.cheforest.jpa.support.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SupportController {

	@GetMapping("/event/test")
	public String showEventTest() {
		return "event/test";
	}

	@GetMapping("/support/guide")
	public String guidePage() {
		return "support/guide";
	}
}