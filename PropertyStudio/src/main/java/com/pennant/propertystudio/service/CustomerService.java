package com.pennant.propertystudio.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.pennant.propertystudio.models.Customer;
import com.pennant.propertystudio.repositories.CustomerRepository;

import jakarta.servlet.http.HttpSession;



@Service
public class CustomerService {

	@Autowired
    private CustomerRepository customerRepository;

	public Customer getCustomerProfile(HttpSession session) {
		long customerId=(long)session.getAttribute("customerId");
		Optional<Customer> customer=customerRepository.findById(customerId);
		return customer.get();
	}

	private Timestamp getCurrentTimestamp() {
        LocalDateTime localDateTime = LocalDateTime.now();
        return Timestamp.valueOf(localDateTime);
    }

	public void updateCustomerField(String fieldId, String value,HttpSession session) throws Exception{
		Long customerId=(Long)session.getAttribute("customerId");
		Optional<Customer> customer=customerRepository.findById(customerId);
		if(customer.isPresent()) {
			Customer c=customer.get();
			Timestamp timestamp=getCurrentTimestamp();
			if(fieldId.equals("mobileField")) {
				c.setMobile(value);
				
			}else if(fieldId.equals("addressField")) {
				c.setAddress(value);
			}else if(fieldId.equals("pincodeField")) {
				c.setPin(value);
			}else if(fieldId.equals("cityField")) {
				c.setCity(value);
			}
			c.setLastUpdatedDate(timestamp);
			customerRepository.save(c);
		}else {
			throw new Exception("cannot retrieve the data");
		}
		
		
		
	}

    
    
}