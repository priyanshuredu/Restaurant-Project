package com.priyanshu;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/submit")

public class JSPlogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Configure your database connection details
    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } 
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("Signup.jsp?error=password_mismatch");
            return;
        }

        try {
            // Register MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check if the user already exists
                String checkUserSql = "SELECT email FROM userdata WHERE email = ?";
                try (PreparedStatement checkUserStmt = conn.prepareStatement(checkUserSql)) {
                    checkUserStmt.setString(1, email);
                    try (ResultSet rs = checkUserStmt.executeQuery()) {
                        if (rs.next()) {
                            response.sendRedirect("Signup.jsp?error=user_exists");
                            return;
                        }
                    }
                }

                // Insert the new user into the database
                String sql = "INSERT INTO userdata (username, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, username);
                    statement.setString(2, email);
                    statement.setString(3, password);

                    int rowsInserted = statement.executeUpdate();
                    if (rowsInserted > 0) {
                        System.out.println("A new user was inserted successfully!");
                    }

                    // Forward to another page (e.g., success.jsp)
                    request.setAttribute("username", username);
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(); // Print detailed exception to server logs

            // Redirect to signup page with DB error message
            response.sendRedirect("Signup.jsp?error=db&message=" + ex.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Register MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check if the user exists and the password matches
                String sql = "SELECT username FROM userdata WHERE email = ? AND password = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, email);
                    statement.setString(2, password);
                    
                    // Check if the email and password match the admin's credentials
                    if ("admin@gmail.com".equals(email) && "123454321".equals(password)) {
                        response.sendRedirect("Dashboard.jsp");
                        return;
                    }

                    try (ResultSet rs = statement.executeQuery()) {
                        if (rs.next()) {
                            // User exists and password matches
                            request.setAttribute("username", rs.getString("username"));
                            request.getRequestDispatcher("success.jsp").forward(request, response);
                        } else {
                            // User does not exist or password does not match
                            response.sendRedirect("Signup.jsp?error=invalid_login");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(); // Print detailed exception to server logs

            // Redirect to login page with DB error message
            response.sendRedirect("Signup.jsp?error=db&message=" + ex.getMessage());
        }
    }

}