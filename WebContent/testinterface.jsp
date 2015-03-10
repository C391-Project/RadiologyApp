<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="db.JDBC" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DBInterface</title>
</head>
<body>
	<%
		Connection connection = JDBC.connect();
		String sql;
		boolean isPost = "POST".equals(request.getMethod());
		
		if (isPost) {
			String newName = request.getParameter("name");
			String newAddress = request.getParameter("address");
				
			if (newName != null && newAddress != null && JDBC.hasConnection()) {
				sql = "INSERT INTO PEOPLE VALUES ('" + newName + "', '" + newAddress + "')";
				JDBC.executeUpdate(sql);
			}
		}
	%>
	
	<h1>DBInterface</h1>
	<h2>Result of People Query</h2>
	
	<%
		sql = "SELECT * FROM PEOPLE";
		if (JDBC.hasConnection()) {
			Statement stmt = null;
	    	ResultSet rs = null;
	    	try {
	    		stmt = connection.createStatement();
	    		rs = stmt.executeQuery(sql);
	    		while (rs.next()) {
	    	        String name = rs.getString("NAME");
	    	        String address = rs.getString("ADDRESS");
	    		%> 
	    			<p>Name: <%= name %> | Address: <%= address %></p>
	    		<% }
	    	} catch (SQLException e) {
	    		e.printStackTrace();
	    	} finally {
	    		if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
	    		}
	    	}
		}
		
		JDBC.closeConnection(); 
	%>
	
    <h2>Add Person</h2>
    <form method="post" action="/RadiologyApp/dbinterface.jsp">
		<p><input type="text" name="name" value="" placeholder="Name"></p>
		<p><input type="text" name="address" value="" placeholder="Address"></p>
		<p class="submit"><input type="submit" name="commit" value="Submit"></p>
	</form>
	
</body>
</html>