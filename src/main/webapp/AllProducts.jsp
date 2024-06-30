<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.Connection , java.sql.DriverManager , java.sql.PreparedStatement , 
	java.sql.SQLException , jakarta.servlet.RequestDispatcher , java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Face</title>
<link rel="stylesheet" href="AllProducts.css">
<link href='https://fonts.googleapis.com/css?family=Amatic SC' rel='stylesheet'>
</head>
<body>
      <div class="sidebar">
      
     <h2>Admin Dashboard</h2>
        <ul>
            <li><a href="Dashboard.jsp">Home</a></li>
            <li><a href="#">All Products</a></li>
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
    <h1><center>All Products</center></h1>
     <%! 
     String itemName, itemType, itemDescription, itemPrice;
     private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant";
     private static final String DB_USER = "root";
     private static final String DB_PASSWORD = "root";
       %>
       <%
          try{
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	try{
        		response.setContentType("text/html");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement statement = conn.prepareStatement("select * from items");
    			ResultSet re= statement.executeQuery();
    		out.println("<html><body><h2><center><table border='4'><thead><tr><th> Product Name </th><th> Product Type </th><th> Description </th><th> Price </th></tr></thead>");
    			while(re.next()){
    				itemName = re.getString("item_name");
    				itemType = re.getString("item_type");
    				itemDescription = re.getString("item_description");
    				itemPrice = re.getString("item_price");
    			out.println("<tr><td>"+ itemName +"</td><td>"+ itemType +"</td><td>"+ itemDescription +"</td><td>"+ itemPrice +"</td></tr>");
    			}
        	}
        	catch(SQLException e){
        		e.printStackTrace();
        	}
          }
       catch(ClassNotFoundException e){
    	   e.printStackTrace();
       }
       %>
    </div>
</body>
</html>