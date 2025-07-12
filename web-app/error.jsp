<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - BC Student Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .error-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
        }

        .error-icon {
            font-size: 72px;
            color: #dc3545;
            margin-bottom: 20px;
        }

        .error-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .error-message {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .back-link {
            display: inline-block;
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .back-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">⚠️</div>
    <h1 class="error-title">Oops! Something went wrong</h1>
    <p class="error-message">
        We're sorry, but the page you're looking for cannot be found or there was an error processing your request.
    </p>
    <a href="index.jsp" class="back-link">Go to Home</a>
</div>
</body>
</html>