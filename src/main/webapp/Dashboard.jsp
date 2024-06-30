<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" href="Dashboard.css">
<link href='https://fonts.googleapis.com/css?family=Amatic+SC' rel='stylesheet'>
</head>
<body>
    <div class="sidebar">
        <h2>Admin Dashboard</h2>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="AllProducts.jsp">All Products</a></li>
            <li><a href="additems.jsp">Add Products</a></li>
            <li><a href="OrderRecived.jsp">Orders</a></li>
            <li><a href="#">Staffs</a></li>
            <li><a href="#">Users</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Support</a></li>
        </ul>
    </div>
    <div class="content">
        <h1><center>Admin Dashboard</center></h1>
        
        <div class="cards">
            <div class="card">
                <h3>Total Orders</h3>
                <p>
                    <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/myrestaurant", "root", "root");
                            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total_orders FROM orders");
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                out.print(rs.getInt("total_orders"));
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </p>
            </div>
            <div class="card">
                <h3>Total Users</h3>
                <p>
                    <% 
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/myrestaurant", "root", "root");
                            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total_users FROM users");
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                out.print(rs.getInt("total_users"));
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </p>
            </div>
            <div class="card">
                <h3>Total Products</h3>
                <p>
                    <% 
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/myrestaurant", "root", "root");
                            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS total_products FROM items");
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                out.print(rs.getInt("total_products"));
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </p>
            </div>
            <!-- Add more cards as needed -->
        </div>
    </div>
</body>
</html>
