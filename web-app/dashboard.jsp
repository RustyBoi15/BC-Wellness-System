<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    if (session.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String studentName = (String) session.getAttribute("studentName");
    String studentNumber = (String) session.getAttribute("studentNumber");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - BC Student Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .header {
            background-color: #007bff;
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .welcome-card {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .welcome-title {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .welcome-subtitle {
            color: #666;
            font-size: 16px;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .service-card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        .service-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .service-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .service-description {
            color: #666;
            margin-bottom: 20px;
        }

        .service-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }

        .service-btn:hover {
            background-color: #0056b3;
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo">BC Student Wellness</div>
        <div class="user-info">
            <span>Welcome, <%= studentName %></span>
            <span>(ID: <%= studentNumber %>)</span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="welcome-card">
        <h1 class="welcome-title">Welcome, <%= studentName %>!</h1>
        <p class="welcome-subtitle">Your wellness journey starts here. Access all your wellness services from this dashboard.</p>
    </div>

    <div class="quick-stats">
        <div class="stat-card">
            <div class="stat-number">3</div>
            <div class="stat-label">Upcoming Appointments</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">12</div>
            <div class="stat-label">Available Counselors</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">5</div>
            <div class="stat-label">Services Accessed</div>
        </div>
    </div>

    <div class="services-grid">
        <div class="service-card">
            <div class="service-icon">📅</div>
            <h3 class="service-title">Book Appointment</h3>
            <p class="service-description">Schedule a session with our professional counselors at your convenience.</p>
            <a href="#" class="service-btn">Book Now</a>
        </div>

        <div class="service-card">
            <div class="service-icon">👥</div>
            <h3 class="service-title">View Counselors</h3>
            <p class="service-description">Browse our team of qualified counselors and their specializations.</p>
            <a href="#" class="service-btn">View Counselors</a>
        </div>

        <div class="service-card">
            <div class="service-icon">⏰</div>
            <h3 class="service-title">My Appointments</h3>
            <p class="service-description">View, reschedule, or cancel your upcoming appointments.</p>
            <a href="#" class="service-btn">View Appointments</a>
        </div>

        <div class="service-card">
            <div class="service-icon">💬</div>
            <h3 class="service-title">Feedback</h3>
            <p class="service-description">Share your experience and help us improve our services.</p>
            <a href="#" class="service-btn">Give Feedback</a>
        </div>

        <div class="service-card">
            <div class="service-icon">📊</div>
            <h3 class="service-title">Wellness Report</h3>
            <p class="service-description">Track your wellness progress and view your activity history.</p>
            <a href="#" class="service-btn">View Report</a>
        </div>

        <div class="service-card">
            <div class="service-icon">🆘</div>
            <h3 class="service-title">Emergency Support</h3>
            <p class="service-description">Access immediate help and crisis support resources.</p>
            <a href="#" class="service-btn">Get Help</a>
        </div>
    </div>
</div>

<script>
    // Confirm logout
    document.querySelector('.logout-btn').addEventListener('click', function(e) {
        if (!confirm('Are you sure you want to logout?')) {
            e.preventDefault();
        }
    });

    // Service card interactions
    document.querySelectorAll('.service-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            alert('This feature will be available in the desktop application (Milestone 2)');
        });
    });
</script>
</body>
</html>