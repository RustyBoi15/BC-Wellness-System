package com.bcwellness.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/bc_wellness";
    private static final String DB_USERNAME = "postgres"; // Change to your DB username
    private static final String DB_PASSWORD = "password"; // Change to your DB password

    // Validation patterns
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^(\\+27|0)[6-8][0-9]{8}$");
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentNumber = request.getParameter("studentNumber");
        String firstName = request.getParameter("name");
        String lastName = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Server-side validation
        if (!validateInput(studentNumber, firstName, lastName, email, phone, password, confirmPassword, request)) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Load PostgreSQL driver
            Class.forName("org.postgresql.Driver");

            // Connect to database
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {

                // Check if student number or email already exists
                String checkSql = "SELECT student_number FROM students WHERE student_number = ? OR email = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, studentNumber);
                    checkStmt.setString(2, email);

                    if (checkStmt.executeQuery().next()) {
                        request.setAttribute("errorMessage", "Student number or email already exists");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                        return;
                    }
                }

                // Insert new student
                String insertSql = "INSERT INTO students (student_number, first_name, last_name, email, phone, password_hash, created_at) " +
                        "VALUES (?, ?, ?, ?, ?, ?, NOW())";

                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, studentNumber);
                    insertStmt.setString(2, firstName);
                    insertStmt.setString(3, lastName);
                    insertStmt.setString(4, email);
                    insertStmt.setString(5, phone);
                    insertStmt.setString(6, hashPassword(password));

                    int rowsAffected = insertStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        request.setAttribute("successMessage", "Registration successful! You can now login.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Registration failed. Please try again.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Password encryption error");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean validateInput(String studentNumber, String firstName, String lastName,
                                  String email, String phone, String password, String confirmPassword,
                                  HttpServletRequest request) {

        boolean isValid = true;

        // Student number validation
        if (studentNumber == null || studentNumber.trim().length() < 3) {
            request.setAttribute("errorMessage", "Student number must be at least 3 characters");
            isValid = false;
        }

        // Name validation
        if (firstName == null || firstName.trim().length() < 2) {
            request.setAttribute("errorMessage", "First name must be at least 2 characters");
            isValid = false;
        }

        if (lastName == null || lastName.trim().length() < 2) {
            request.setAttribute("errorMessage", "Last name must be at least 2 characters");
            isValid = false;
        }

        // Email validation
        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("errorMessage", "Please enter a valid email address");
            isValid = false;
        }

        // Phone validation
        if (phone == null || !PHONE_PATTERN.matcher(phone).matches()) {
            request.setAttribute("errorMessage", "Please enter a valid South African phone number");
            isValid = false;
        }

        // Password validation
        if (password == null || !PASSWORD_PATTERN.matcher(password).matches()) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters with uppercase, lowercase, number, and special character");
            isValid = false;
        }

        // Confirm password validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            isValid = false;
        }

        return isValid;
    }

    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();

        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }

        return hexString.toString();
    }
}