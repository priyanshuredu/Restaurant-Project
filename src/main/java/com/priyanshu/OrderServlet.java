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

@WebServlet("/orders")

public class OrderServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/myrestaurant";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "root";
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
        String action = request.getParameter("actionn");
	    
	    if("submitOrder".equals(action)){
	    	handlesubmitOrder(request,response);
	    } else if("bookTable".equals(action)) {
	    	handlebookTable(request,response);
	    }
	}   
	private void handlebookTable(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String date = request.getParameter("date");
		String event = request.getParameter("event");
		String guestnumber = request.getParameter("no_guests");
		String message = request.getParameter("message");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try(Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)){
				String sql = "INSERT INTO table_bookings(name, email, mobilenumber, date, event, guestnumber, message) value(?, ?, ?, ?, ?, ?, ?)";
				try(PreparedStatement statement = conn.prepareStatement(sql)){
					statement.setString(1, name);
					statement.setString(2, email);
					statement.setString(3, phone);
					statement.setString(4, date);
					statement.setString(5, event);
					statement.setString(6, guestnumber);
					statement.setString(7, message);
					
					int rowInserted = statement.executeUpdate();
					if(rowInserted > 0) {
						System.out.print("Your table booked successfully !!");
					}
					request.getRequestDispatcher("success.jsp?table_booked_successfully!").forward(request, response);
				}
			}
		}
		catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	private void handlesubmitOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub

		String[] orders = request.getParameterValues("order");
		String[] quantity = request.getParameterValues("quantity");
		String address = request.getParameter("address");
		
		if(orders == null || orders.length == 0)
		{
			response.sendRedirect("Products.jsp?no_product_selected");
			return;
		}
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			try(Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD))
			{
				String sql = "INSERT INTO orders (item_name, quantity, address) values(?, ?, ?)";
				try(PreparedStatement statement = conn.prepareStatement(sql))
				{
					for(int i=0; i < orders.length; i++)
					{
						statement.setString(1, orders[i]);
						statement.setString(2, quantity[i]);
						statement.setString(3, address);
						statement.addBatch();
					}
					statement.executeBatch();
				}
				response.sendRedirect("Products.jsp?Order_added_successfully");
			}
		}
		catch(ClassNotFoundException | SQLException e)
		{
			e.printStackTrace();
			response.sendRedirect("Products.jsp?error_DB_error");
		}
	}

}
