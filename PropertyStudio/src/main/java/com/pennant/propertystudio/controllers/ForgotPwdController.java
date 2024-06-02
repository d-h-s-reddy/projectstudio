package com.pennant.propertystudio.controllers;

import java.net.http.HttpRequest;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pennant.propertystudio.service.ForgotPasswordService;
import com.pennant.propertystudio.utilities.SendMailing;

import jakarta.servlet.http.HttpSession;

@Controller
public class ForgotPwdController {

	@Autowired
	ForgotPasswordService forgotPasswordService;
	
	@PostMapping(value="/sendemail")
	@ResponseBody
	public ResponseEntity<String> sendemail(@RequestParam String email,HttpSession session){
		try {
			forgotPasswordService.sendMail(email,session);
			return ResponseEntity.ok("OTP sent successfully.");
		}catch(Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
	}
	
	@PostMapping(value="/otpverification")
	@ResponseBody
	public ResponseEntity<String> verifyotp(@RequestParam int otp,HttpSession session){
		boolean flag=forgotPasswordService.checkingotp(otp,session);
		if(flag==true) {
			return ResponseEntity.ok("Reset your password");
		}else {
			return ResponseEntity.status(500).body("invalid otp re-enter the otp ");
		}
		
	}
	
	@PostMapping(value="/resetpassword")
	public String resetpassword(@RequestParam String newpwd,HttpSession session) {
		try {
			forgotPasswordService.updatingpassword(newpwd, session);
			return "resetsuccess";
		}catch(Exception e) {
			return "error";
		}
	}
	
	@GetMapping(value="/s")
	public String testing() {
		return "resetsuccess";
   }
}
