package com.src.model;

import java.sql.Timestamp;

import com.src.annotations.Column;
import com.src.annotations.Id;
import com.src.annotations.Table;

@Table(name="ZinkUSERS")
public class User {
	 @Id
	    @Column(name = "USER_ID", nullable = false, length = 30, unique = true)
	    private String userId;

	    @Column(name = "USERNAME", nullable = false, length = 50)
	    private String username;

	    @Column(name = "EMAIL", nullable = false, length = 100, unique = true)
	    private String email;

	    @Column(name = "PASSWORD", nullable = false, length = 100)
	    private String password;

	    @Column(name = "PHONE", length = 15)
	    private String phone;

	    @Column(name = "ADDRESS", length = 250)
	    private String address;

	    @Column(name = "CITY", length = 50)
	    private String city;

	    @Column(name = "STATE", length = 50)
	    private String state;

	    @Column(name = "PINCODE", length = 10)
	    private String pincode;

	    @Column(name = "WALLET_BALANCE", defaultValue = "0")
	    private long walletBalance;

	    @Column(name = "CREATED_AT")
	    private Timestamp createdAt;

	    @Column(name = "UPDATED_AT")
	    private Timestamp updatedAt;

		@Override
		public String toString() {
			return "User [userId=" + userId + ", username=" + username + ", email=" + email + ", password=" + password
					+ ", phone=" + phone + ", address=" + address + ", city=" + city + ", state=" + state + ", pincode="
					+ pincode + ", walletBalance=" + walletBalance + ", createdAt=" + createdAt + ", updatedAt="
					+ updatedAt + "]";
		}

		public String getUserId() {
			return userId;
		}

		public void setUserId(String userId) {
			this.userId = userId;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}

		public String getCity() {
			return city;
		}

		public void setCity(String city) {
			this.city = city;
		}

		public String getState() {
			return state;
		}

		public void setState(String state) {
			this.state = state;
		}

		public String getPincode() {
			return pincode;
		}

		public void setPincode(String pincode) {
			this.pincode = pincode;
		}

		public double getWalletBalance() {
			return walletBalance;
		}

		public void setWalletBalance(long walletBalance) {
			this.walletBalance = walletBalance;
		}

		public Timestamp getCreatedAt() {
			return createdAt;
		}

		public void setCreatedAt(Timestamp createdAt) {
			this.createdAt = createdAt;
		}

		public Timestamp getUpdatedAt() {
			return updatedAt;
		}

		public void setUpdatedAt(Timestamp updatedAt) {
			this.updatedAt = updatedAt;
		}
		
		
	    
	    
}
