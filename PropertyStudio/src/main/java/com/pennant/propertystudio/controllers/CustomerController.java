package com.pennant.propertystudio.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HttpSessionMutexListener;

import com.pennant.propertystudio.models.Customer;
import com.pennant.propertystudio.service.CustomerService;


import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerController {

	@Autowired
	private CustomerService customerService;

	@GetMapping("/profile")
	public String showProfilePage(Model model,HttpSession session) {
		System.out.println("getting it");
		Customer customer = customerService.getCustomerProfile(session);
		model.addAttribute("customer", customer);
		System.out.println("c:" + customer);
		return "profile";
	}

	@PostMapping("/update")
	@ResponseBody
	public ResponseEntity<String> updateCustomerField(@RequestParam String fieldId, @RequestParam String value,HttpSession session) {
		try {
			customerService.updateCustomerField(fieldId, value,session);
			return ResponseEntity.ok("The field has been updated");
		} catch (Exception e) {
			return ResponseEntity.status(500).body(e.getMessage());
		}
	}
}
