<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection , java.sql.DriverManager , java.sql.PreparedStatement , 
    java.sql.SQLException , jakarta.servlet.RequestDispatcher , java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU</title>
<link rel="stylesheet" type="text/css" href="Productsstyle.css">
<link href='https://fonts.googleapis.com/css?family=Amatic SC' rel='stylesheet'>
<script>
function calculateTotal() {
    let table = document.getElementById("productsTable");
    let rows = table.getElementsByTagName("tr");
    let total = 0;

    for (let i = 1; i < rows.length; i++) {
        let quantity = parseInt(rows[i].querySelector(".quantity").value);
        let price = parseFloat(rows[i].querySelector(".price").innerText);
        total += quantity * price;
    }

    document.getElementById("totalPrice").innerText = "Total Price: $" + total.toFixed(2);
}

function updateQuantity(row) {
    let checkbox = row.querySelector(".select-row");
    let quantityInput = row.querySelector(".quantity");

    if (checkbox.checked) {
        quantityInput.value = 1;
    } else {
        quantityInput.value = 0;
    }
    calculateTotal();
}

function incrementQuantity(input) {
    let quantityInput = input.previousElementSibling;
    quantityInput.value = parseInt(quantityInput.value) + 1;
    calculateTotal();
}

function decrementQuantity(input) {
	let quantityInput = input.nextElementSibling;
	if (parsInt(quantityInput.value) == 0){
		
	}
    if (parseInt(quantityInput.value) > 0) {
        quantityInput.value = parseInt(quantityInput.value) - 1;
        calculateTotal();
    }
}

function selectRow(row) {
    let checkbox = row.querySelector(".select-row");
    checkbox.checked = !checkbox.checked;
    updateQuantity(row);
}
</script>
</head>
<body>
    <div class="navbar"></div>
    <header>
        <div class="logo">
            <div class="logo-img">
            </div>
        </div>
        <div class="menu-div">
            <div class="menu-options"><a href="success.jsp">Home</a></div>
            <div class="menu-options"><a href="#">About</a></div>
            <div class="menu-options"><a href="#">Menu</a></div>
            <div class="menu-options"><a href="#">Events</a></div>
            <div class="menu-options"><a href="#">Chefs</a></div>
            <div class="menu-options"><a href="#">Drop down</a></div>
            <div class="menu-options"><a href="#">Contact</a></div>
            <button class="appointment-button">Book a Table</button>
        </div>
    </header><br><br><br><br>

<h1><center>Available Products</center></h1>

<% 
    String itemName, itemType, itemDescription, itemPrice;
%>

<form method="get" action="Products.jsp">
    <label for="itemType">Select Item Type:</label>
    
    <select name="itemType" id="itemType">
        <option value="all">All</option>
        <option value="starters">Starters</option>
        <option value="fastfood">FastFood</option>
        <option value="snacks">Snacks</option>
        <option value="breakfast">BreakFast</option>
        <option value="lunch">Lunch</option>
        <option value="dinner">Dinner</option>
        <option value="beverages">Beverages</option>
        
        <!-- Add more options as needed -->
    </select>
    <button type="submit">Filter</button>
</form>

<%
    String selectedItemType = request.getParameter("itemType");
    if (selectedItemType == null) {
        selectedItemType = "all";
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException ec) {
        ec.printStackTrace();
    }

    try {
        response.setContentType("text/html");
        Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/myrestaurant", "root", "root");
        PreparedStatement p1;
        if ("all".equals(selectedItemType)) {
            p1 = connection.prepareStatement("select * from items");
        } else {
            p1 = connection.prepareStatement("select * from items where item_type = ?");
            p1.setString(1, selectedItemType);
        }
        ResultSet re = p1.executeQuery();
        
        out.println("<html><body><h2><center><form action='OrderServlet' method='post'><table id='productsTable' border='4'><thead><tr><th>Select</th><th> Product Name </th><th> Product Type </th><th> Product Description</th><th> Product Price </th><th> Quantity </th></tr></thead>");
        while (re.next()) {
            itemName = re.getString("item_name");
            itemType = re.getString("item_type");
            itemDescription = re.getString("item_description");
            itemPrice = re.getString("item_price");
            out.println("<tr onclick='selectRow(this)'><td><input type='checkbox' class='select-row' onclick='updateQuantity(this.parentNode.parentNode)'></td><td>" + itemName + "</td><td>" + itemType + "</td><td>" + itemDescription + "</td><td class='price'>" + itemPrice + "</td><td><button type='button' onclick='decrementQuantity(this)'>-</button><input type='number' name='quantity' class='quantity' min='0' value='0' readonly><button type='button' onclick='incrementQuantity(this)'>+</button></td></tr>");
        }
        out.println("</table><p id='totalPrice'>Total Price: $0.00</p><br><br>");
        out.println("<label for='address'>Address:</label><br>");
        out.println("<textarea name='address' id='address' rows='4' cols='50' required></textarea><br><br>");
        out.println("<button type='submit'>Submit Order</button></form></center></h2></body></html>");
    } catch (SQLException ec) {
        ec.printStackTrace();
    }
%>
</body>
</html>
