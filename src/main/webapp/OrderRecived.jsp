<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, 
    java.sql.SQLException, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Face</title>
    <link rel="stylesheet" href="OrderRecived.css">
    <link href='https://fonts.googleapis.com/css?family=Amatic SC' rel='stylesheet'>
</head>
<body>
    <div class="sidebar">
     <h2>Admin Dashboard</h2>
        <ul>
            <li><a href="Dashboard.jsp">Home</a></li>
            <li><a href="AllProducts.jsp">All Products</a></li>
            <li><a href="additems.jsp">Add Products</a></li>
            <li><a href="#">Orders</a></li>
            <li><a href="#">Staffs</a></li>
            <li><a href="#">Users</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Support</a></li>
        </ul>
    </div>
    <div class="content">
    <h1><center>Orders Received</center></h1>
    <%! 
        String username, address, item_name, quantity, price;
        private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant";
        private static final String DB_USER = "root";
        private static final String DB_PASSWORD = "root";
    %>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    
        try {
            response.setContentType("text/html");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement p1 = connection.prepareStatement("SELECT * FROM orders");
            ResultSet re = p1.executeQuery();
            
            out.println("<html><body><h2><center><table id='ordersTable' border='4'><thead><tr><th>User Name</th><th>Address</th><th>Product Name</th><th>Product Quantity</th><th>Price</th><th>Status</th></tr></thead><tbody>");
            while (re.next()) {
                username = re.getString("username");
                address = re.getString("address");
                item_name = re.getString("item_name");
                quantity = re.getString("quantity");
                price = re.getString("price");
                out.println("<tr><td>" + username + "</td><td>" + address + "</td><td>" + item_name + "</td><td>" + quantity + "</td><td>" + price + "</td><td></td></tr>");
            }
            out.println("</tbody></table></center></h2></body></html>");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    %>
    </div>
</body>
</html>
