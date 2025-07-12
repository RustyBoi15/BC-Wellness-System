package com.bcwellness.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/bc_wellness";
    private static final String DB_USERNAME = "postgres"; // Change to your DB username
    private static final String DB_PASSWORD = "password"; // Change to your DB password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        try {
            // Load PostgreSQL driver
            Class.forName("org.postgresql.Driver");

            // Connect to database
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {

                // Check if user exists with username or email
                String sql = "SELECT student_number, first_name, last_name, email, password_hash " +
                        "FROM students WHERE student_number = ? OR email = ?";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, username);
                    stmt.setString(2, username);

                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String storedPasswordHash = rs.getString("password_hash");
                        String inputPasswordHash = hashPassword(password);

                        if (storedPasswordHash.equals(inputPasswordHash)) {
                            // Login successful
                            HttpSession session = request.getSession();
                            session.setAttribute("studentNumber", rs.getString("student_number"));
                            session.setAttribute("studentName", rs.getString("first_name") + " " + rs.getString("last_name"));
                            session.setAttribute("studentEmail", rs.getString("email"));

                            // Set session timeout (30 minutes)
                            session.setMaxInactiveInterval(30 * 60);

                            // Handle remember me functionality
                            if ("on".equals(rememberMe)) {
                                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
                            }

                            response.sendRedirect("dashboard.jsp");
                        } else {
                            // Invalid password
                            request.setAttribute("errorMessage", "Invalid username or password");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        }
                    } else {
                        // User not found
                        request.setAttribute("errorMessage", "Invalid username or password");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database connection error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Password encryption error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
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