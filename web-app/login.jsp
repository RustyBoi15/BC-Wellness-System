<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - BC Student Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 400px;
            margin: 80px auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
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

        .server-error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
            display: none;
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .remember-me input {
            width: auto;
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Student Login</h2>

    <!-- Server Error Message -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <div id="serverError" class="server-error">
        <%
            if (errorMessage != null) {
                out.print(errorMessage);
            }
        %>
    </div>

    <form id="loginForm" method="post" action="LoginServlet">
        <div class="form-group">
            <label for="username">Student Number or Email:</label>
            <input type="text" id="username" name="username" required>
            <div id="usernameError" class="error"></div>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <div id="passwordError" class="error"></div>
        </div>

        <div class="remember-me">
            <input type="checkbox" id="rememberMe" name="rememberMe">
            <label for="rememberMe">Remember me</label>
        </div>

        <button type="submit" class="btn">Login</button>
    </form>

    <div class="back-link">
        <a href="index.jsp">Back to Home</a> |
        <a href="register.jsp">Don't have an account? Register</a>
    </div>
</div>

<script>
    // Form validation
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        let isValid = true;

        // Clear previous error messages
        document.querySelectorAll('.error').forEach(el => el.style.display = 'none');

        // Get form values
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;

        // Username validation
        if (username.length < 3) {
            showError('usernameError', 'Please enter your student number or email');
            isValid = false;
        }

        // Password validation
        if (password.length < 1) {
            showError('passwordError', 'Please enter your password');
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

    // Show server error message if exists
    window.onload = function() {
        const serverError = document.getElementById('serverError');
        if (serverError.textContent.trim()) {
            serverError.style.display = 'block';
        }
    };
</script>
</body>
</html>