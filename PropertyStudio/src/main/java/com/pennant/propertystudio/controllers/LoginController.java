package com.pennant.propertystudio.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pennant.propertystudio.service.LoginService;

@Controller

public class LoginController {

	
	@Autowired
	LoginService ls;
	
	@GetMapping(value="/login")
	public String login() {
		return "login";
	}
	
	@PostMapping(value="/verify")
	public String verify(@RequestParam String email,@RequestParam String password) {
		boolean flag=ls.verify(email, password);
		if(flag==true) {
			System.out.println("redirected to controller");
			return "profile";
		}else {
			return "error";
		}
		
	}
	
	
	@GetMapping(value="/forgotpassword")
	public String forgotpwd() {
		System.out.println("hi");
		return "forgotpassword";
	}
	

}
