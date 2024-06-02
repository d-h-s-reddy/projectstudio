package com.pennant.propertystudio.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pennant.propertystudio.models.CustomerUser;
import com.pennant.propertystudio.repositories.CustomerUserRepository;
import com.pennant.propertystudio.utilities.IHashGenerator;
import com.pennant.propertystudio.utilities.SendMailing;

import jakarta.servlet.http.HttpSession;

@Service
public class ForgotPasswordService {
	
	@Autowired
	SendMailing sendMailing;
	
	@Autowired
	IHashGenerator hashcode;
	
	@Autowired
	CustomerUserRepository customerUserRepository;
	
	private Timestamp getCurrentTimestamp() {
        LocalDateTime localDateTime = LocalDateTime.now();
        return Timestamp.valueOf(localDateTime);
    }
	
	public void sendMail(String email,HttpSession session)throws Exception {
		try {
			Random random = new Random();
	        int randomnumber = 100000 + random.nextInt(900000);
	        String otp=randomnumber+"";
			session.setAttribute("otp",randomnumber);
			session.setAttribute("email", email);
			Optional<CustomerUser> customer=customerUserRepository.findByEmail(email);
			if(customer.isPresent()) {
		       sendMailing.sendOtpVerifcation(email, "Reset Your password", otp);
			}else {
				throw new Exception("Your email is not registered Please, Re-enter email");
			}
		}catch(Exception e) {
		  throw e;
		}
		
	}

	public boolean checkingotp(int otp, HttpSession session) {
		int sessionotp=(int)session.getAttribute("otp");
		if(otp==sessionotp) {
			return true;
		}else {
		return false;
		}
	}
	
	public void updatingpassword(String newpwd,HttpSession session)throws Exception {
		String email=(String)session.getAttribute("email");
		Optional<CustomerUser> customer=customerUserRepository.findByEmail(email);
		if(customer.isPresent()) {
			CustomerUser customerUser=customer.get();
			String password=hashcode.generateHash(newpwd);
			customerUser.setPassword(password);
			Timestamp timestamp=getCurrentTimestamp();
			customerUser.setLastUpdatedDate(timestamp);
			customerUserRepository.save(customerUser);
			int index=email.indexOf('@');
			sendMailing.passwordUpdate(email, "Password Updated Successfully", email.substring(0,index));
		}else {
			throw new Exception("cann't update the password");
		}
	}

}
