<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- Check for an error message -->
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">
            ${errorMessage}
        </div>
    </c:if>
<form id="userForm" action="register" method="post" >
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required oninput="validatePassword()"><br>
    <span id="passwordFeedback" style="color: red;"></span><br>

    <label for="phone">Phone:</label>
    <input type="tel" id="phone" name="phone" required oninput="validatePhone()"><br>
    <span id="phoneFeedback" style="color: red;"></span><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required oninput="validateEmail()"><br>
    <span id="emailFeedback" style="color: red;"></span><br>

    <button type="submit">Register</button>
</form>

<script>
function validatePassword() {
    const password = document.getElementById("password").value;
    const feedback = document.getElementById("passwordFeedback");
    const minLength = 8;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    if (password.length < minLength || !hasUpperCase || !hasSpecialChar) {
        feedback.textContent = "Password must be at least 8 characters long, contain at least one uppercase letter, and one special character.";
    } else {
        feedback.textContent = "";
    }
}

function validateEmail() {
    const email = document.getElementById("email").value;
    const feedback = document.getElementById("emailFeedback");
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Simple email regex

    if (!emailPattern.test(email)) {
        feedback.textContent = "Please enter a valid email address.";
    } else {
        feedback.textContent = "";
    }
}

function validatePhone() {
    const phone = document.getElementById("phone").value;
    const feedback = document.getElementById("phoneFeedback");
    const phonePattern = /^(?:\+\d{1,3}[- ]?)?\d{10}$/; // Allow country code or 10-digit number

    if (!phonePattern.test(phone)) {
        feedback.textContent = "Please enter a valid phone number (10 digits or with country code).";
    } else {
        feedback.textContent = "";
    }
}

function validateForm() {
    validatePassword(); // Check password when form is submitted
    validateEmail(); // Check email when form is submitted
    validatePhone(); // Check phone when form is submitted

    const passwordFeedback = document.getElementById("passwordFeedback").textContent;
    const emailFeedback = document.getElementById("emailFeedback").textContent;
    const phoneFeedback = document.getElementById("phoneFeedback").textContent;

    return !passwordFeedback && !emailFeedback && !phoneFeedback; // Allow form submission only if no feedback is present
}
</script>

</body>
</html>