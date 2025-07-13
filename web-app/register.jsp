<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - BC Student Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 500px;
            margin: 30px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: #007bff;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .success {
            color: green;
            font-size: 14px;
            margin-top: 5px;
            text-align: center;
            display: none;
        }

        .server-message {
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
            display: none;
        }

        .server-message.error {
            color: red;
        }

        .server-message.success {
            color: green;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }

        @media (max-width: 580px) {
            .container {
                margin: 20px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Student Registration</h2>

    <!-- Success/Error Messages -->
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");

        if (successMessage == null) successMessage = "";
        if (errorMessage == null) errorMessage = "";
    %>

    <% if (!successMessage.isEmpty()) { %>
    <div id="successMessage" class="server-message success">
        <%= successMessage %>
    </div>
    <% } %>

    <% if (!errorMessage.isEmpty()) { %>
    <div id="errorMessage" class="server-message error">
        <%= errorMessage %>
    </div>
    <% } %>

    <form id="registerForm" method="post" action="RegisterServlet">
        <div class="form-group">
            <label for="studentNumber">Student Number:</label>
            <input type="text" id="studentNumber" name="studentNumber" required>
            <div id="studentNumberError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="name">First Name:</label>
            <input type="text" id="name" name="name" required>
            <div id="nameError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="surname">Last Name:</label>
            <input type="text" id="surname" name="surname" required>
            <div id="surnameError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <div id="emailError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" required>
            <div id="phoneError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <div class="password-requirements">
                Password must be at least 8 characters with uppercase, lowercase, number, and special character
            </div>
            <div id="passwordError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <div id="confirmPasswordError" class="error"></div>
        </div>

        <button type="submit" class="btn">Register</button>
    </form>

    <div class="back-link">
        <a href="index.jsp">Back to Home</a> |
        <a href="login.jsp">Already have an account? Login</a>
    </div>
</div>

<script>
    // Form validation
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        let isValid = true;

        // Clear previous error messages
        document.querySelectorAll('.error').forEach(function(el) {
            el.style.display = 'none';
        });

        // Get form values
        const studentNumber = document.getElementById('studentNumber').value.trim();
        const name = document.getElementById('name').value.trim();
        const surname = document.getElementById('surname').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        // Student Number validation
        if (studentNumber.length < 3) {
            showError('studentNumberError', 'Student number must be at least 3 characters');
            isValid = false;
        }

        // Name validation
        if (name.length < 2) {
            showError('nameError', 'First name must be at least 2 characters');
            isValid = false;
        }

        // Surname validation
        if (surname.length < 2) {
            showError('surnameError', 'Last name must be at least 2 characters');
            isValid = false;
        }

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            showError('emailError', 'Please enter a valid email address');
            isValid = false;
        }

        // Phone validation (South African format)
        const phoneRegex = /^(\+27|0)[6-8][0-9]{8}$/;
        if (!phoneRegex.test(phone)) {
            showError('phoneError', 'Please enter a valid South African phone number (e.g., 0823456789)');
            isValid = false;
        }

        // Password validation
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        if (!passwordRegex.test(password)) {
            showError('passwordError', 'Password must be at least 8 characters with uppercase, lowercase, number, and special character');
            isValid = false;
        }

        // Confirm password validation
        if (password !== confirmPassword) {
            showError('confirmPasswordError', 'Passwords do not match');
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });

    function showError(elementId, message) {
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }

    // Show success/error messages from server
    window.onload = function() {
        const successMsg = document.getElementById('successMessage');
        const errorMsg = document.getElementById('errorMessage');

        if (successMsg && successMsg.textContent.trim()) {
            successMsg.style.display = 'block';
        }

        if (errorMsg && errorMsg.textContent.trim()) {
            errorMsg.style.display = 'block';
        }
    };
</script>
</body>
</html>