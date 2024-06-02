package com.pennant.propertystudio.models;

import java.sql.Timestamp;
import java.util.Date;



import jakarta.persistence.*;

@Entity
@Table(name = "prs_customers")
public class Customer {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cust_id")
	private Long id;

	@Column(name = "cust_firstname", nullable = false, length = 50)
	private String firstname;

	@Column(name = "cust_lastname", nullable = false, length = 50)
	private String lastname;

	@Column(name = "cust_email", nullable = false, length = 100)
	private String email;

	@Column(name = "cust_mobile", length = 11)
	private String mobile;

	@Column(name = "cust_address", length = 255)
	private String address;

	@Column(name = "cust_location", length = 50)
	private String location;

	@Column(name = "cust_pin", length = 6)
	private String pin;

	@Column(name = "cust_city", length = 50)
	private String city;

	@Column(name = "cust_luudate")
	@Temporal(TemporalType.TIMESTAMP)
	private Timestamp lastUpdatedDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	

	public Timestamp getLastUpdatedDate() {
		return lastUpdatedDate;
	}

	public void setLastUpdatedDate(Timestamp lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", firstname=" + firstname + ", lastname=" + lastname + ", email=" + email
				+ ", mobile=" + mobile + ", address=" + address + ", location=" + location + ", pin=" + pin + ", city="
				+ city + ", lastUpdatedDate=" + lastUpdatedDate + "]";
	}
}