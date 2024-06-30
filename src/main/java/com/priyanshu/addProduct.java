package com.priyanshu;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addProduct")

public class addProduct extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1515463953255451296L;
	private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "root";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String action = request.getParameter("Action");
		
		if("addProduct".equals(action)) {
			handleaddProduct(request,response);
		}
	}

	private void handleaddProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		String itemName = request.getParameter("itemName");
		String itemType = request.getParameter("itemType");
		String itemDescription = request.getParameter("itemDescription");
	    String itemPrice = request.getParameter("itemPrice");
	    
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	try(Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)){
	    		String sql = "INSERT INTO items(item_name, item_type, item_description, item_price) value(?, ?, ?, ?)";
	    		try(PreparedStatement statement = conn.prepareStatement(sql)){
	    			statement.setString(1, itemName);
	    			statement.setString(2, itemType);
	    			statement.setString(3, itemDescription);
	    			statement.setString(4, itemPrice);
	    			
	    			int rowInserted = statement.executeUpdate();
	    			if(rowInserted > 0) {
	    				System.out.print("Product Added Successfully!!");
	    			}
	    			response.sendRedirect("additem.jsp?Product_added_successfully");
	    			
	    		}
	    	}
	    }
	    catch( ClassNotFoundException | SQLException e) {
	    	e.printStackTrace();
	    }
	}

}
