package com.expensetracker.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDao {

	private Connection connection;

	public RegisterDao() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");

		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/EXPENSE", "root", "password");
	}

	public boolean addUser(String username, String password, String phone, String email) throws SQLException {
		if (isEmailExist(email) || isPhoneExist(phone)) {
			return false;
		}

		String hashedPassword = hashPassword(password); // Hash the password
		String query = "INSERT INTO USER(Username, Phone, Email_address, Password) VALUES(?,?,?,?)";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, username);
			ps.setString(2, phone);
			ps.setString(3, email);
			ps.setString(4, hashedPassword);
			ps.executeUpdate();
		}
		return true;
	}

	private boolean isPhoneExist(String phone) throws SQLException {
		String query = "SELECT COUNT(*) FROM USER WHERE Phone = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}
		}
		return false;
	}

	private boolean isEmailExist(String email) throws SQLException {
		String query = "SELECT COUNT(*) FROM USER WHERE Email_address = ?";
		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}
		}
		return false;
	}

	private String hashPassword(String password) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashedBytes = md.digest(password.getBytes());
			StringBuilder sb = new StringBuilder();
			for (byte b : hashedBytes) {
				sb.append(String.format("%02x", b));
			}
			return sb.toString(); // Return the hashed password as a hex string
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Error hashing password", e);
		}
	}
}
