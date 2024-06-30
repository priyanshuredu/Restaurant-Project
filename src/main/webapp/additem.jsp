<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Face</title>
    <link rel="stylesheet" href="additem.css">
    <link href='https://fonts.googleapis.com/css?family=Amatic SC' rel='stylesheet'>
</head>
<body>
<div class="sidebar">
     <h2>Admin Dashboard</h2>
        <ul>
            <li><a href="Dashboard.jsp">Home</a></li>
            <li><a href="AllProducts.jsp">All Products</a></li>
            <li><a href="#">Add Products</a></li>
            <li><a href="OrderRecived.jsp">Orders</a></li>
            <li><a href="#">Staffs</a></li>
            <li><a href="#">Users</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Support</a></li>
        </ul>
    </div>
    <div class="content">
    <div class="form-container">
        <h2>Add a New Product</h2>
        <form action="addProduct" method="post">
            <input type="text" name="itemName" placeholder="Name" required>
            <select name="itemType" id="itemType">
                     <option value="stareters">Starters</option>
                     <option value="fastfood">FastFood</option>
                     <option value="snacks">Snacks</option>
                     <option value="breakfast">BreakFast</option>
                     <option value="lunch">Lunch</option>
                     <option value="dinner">Dinner</option>
                     <option value="beverages">Beverages</option>
            <textarea name="itemDescription" rows="5" cols="15" placeholder="Description of Product"></textarea>
            <input type="number" name="itemPrice" placeholder="Price" required>
            <button type="submit" name="Action" value="addProduct">Submit</button>
        </form>
    </div>
    </div>
    
</body>
</html>
