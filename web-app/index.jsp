<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BC Student Wellness Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            text-align: center;
            max-width: 500px;
            width: 90%;
        }

        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: bold;
        }

        h1 {
            color: #333;
            margin-bottom: 0.5rem;
            font-size: 2.2rem;
        }

        .subtitle {
            color: #666;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }

        .buttons {
            display: flex;
            gap: 1rem;
            flex-direction: column;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .features {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }

        .features h3 {
            color: #333;
            margin-bottom: 1rem;
        }

        .feature-list {
            color: #666;
            text-align: left;
            list-style: none;
        }

        .feature-list li {
            padding: 0.5rem 0;
            position: relative;
            padding-left: 1.5rem;
        }

        .feature-list li:before {
            content: "✓";
            color: #667eea;
            font-weight: bold;
            position: absolute;
            left: 0;
        }

        @media (min-width: 768px) {
            .buttons {
                flex-direction: row;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logo">BC</div>
    <h1>Welcome to BC Wellness</h1>
    <p class="subtitle">Your gateway to mental health and wellness support</p>

    <div class="buttons">
        <a href="login.jsp" class="btn btn-primary">Login</a>
        <a href="register.jsp" class="btn btn-secondary">Register</a>
    </div>

    <div class="features">
        <h3>What We Offer</h3>
        <ul class="feature-list">
            <li>Schedule counseling appointments</li>
            <li>Access to qualified counselors</li>
            <li>Share feedback and experiences</li>
            <li>Secure and confidential platform</li>
        </ul>
    </div>
</div>
</body>
</html>