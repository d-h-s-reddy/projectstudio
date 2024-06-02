package com.pennant.propertystudio.service;

import java.sql.Timestamp;
import java.lang.StackWalker.Option;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pennant.propertystudio.models.CustomerUser;
import com.pennant.propertystudio.repositories.CustomerUserRepository;
import com.pennant.propertystudio.utilities.IHashGenerator;

import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Service
public class LoginService {

	@Autowired
	CustomerUserRepository loginRepository;
	
	@Autowired
	private HttpSession httpSession; 
	
	@Autowired
	IHashGenerator hashcode;
	
	private Timestamp getCurrentTimestamp() {
        LocalDateTime localDateTime = LocalDateTime.now();
        return Timestamp.valueOf(localDateTime);
    }
	
	public boolean verify(String email,String password) {
		Optional<CustomerUser> l = loginRepository.findByEmail(email);
		if(l.isPresent()) {
			System.out.println("data obtained");
			CustomerUser customerUser=l.get();
			String hashpwd=hashcode.generateHash(password);
			if(hashpwd.equals(customerUser.getPassword())) {
				System.out.println("password is verified");
				 httpSession.setAttribute("customerId", customerUser.getId());
				 
				return true;
			}else {
				return false;
			}
		}else {
		   return false;
		}
	}
	

}
