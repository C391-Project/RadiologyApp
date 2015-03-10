<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="db.JDBC" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DBInterface</title>
<style>
	body {
	  font: normal medium/1.4 sans-serif;
	}
	table {
	  border-collapse: collapse;
	  width: 100%;
	}
	th, td {
	  padding: 0.25rem;
	  text-align: left;
	  border: 1px solid #ccc;
	}
	tbody tr:nth-child(odd) {
	  background: #eee;
	}
</style>
</head>
<body>
	<%
	// TODO extract all sql stuff into JDBC, JDBC will return objects to work with in the page.
		Connection connection = JDBC.connect();
		String sql;
		boolean isPost = "POST".equals(request.getMethod());
		
		if (isPost && request.getParameter("person_submit") != null) {
			String newPersonId = request.getParameter("p_person_id");
			String newFirstName = request.getParameter("p_first_name");
			String newLastName = request.getParameter("p_last_name");
			String newAddress = request.getParameter("p_address");
			String newEmail = request.getParameter("p_email");
			String newPhone = request.getParameter("p_phone");
				
			if (newPersonId != null 
					&& newFirstName != null
					&& newLastName != null
					&& newAddress != null
					&& newPhone != null
					&& newEmail != null
					&& JDBC.hasConnection()) {
				sql = "INSERT INTO PERSONS VALUES ('" 
					+ newPersonId + "', '"
					+ newFirstName + "', '"
					+ newLastName + "', '"
					+ newAddress + "', '"
					+ newEmail + "', '"
					+ newPhone + "')";
				JDBC.executeUpdate(sql);
			}
		}
	%>
	
	<h1>Database Viewer</h1>
	<h2>PERSONS</h2>
	<table>
		<thead>
			<tr>
				<th>PERSON_ID</th>
				<th>FIRST_NAME</th>
				<th>LAST_NAME</th>
				<th>ADDRESS</th>
				<th>EMAIL</th>
				<th>PHONE</th>
			</tr>
		</thead>
		<tbody>
		<% // BEGIN PERSON TABLE GENERATOR
			sql = "SELECT * FROM PERSONS";
			if (JDBC.hasConnection()) {
				Statement stmt = null;
		    	ResultSet rs = null;
		    	try {
		    		stmt = connection.createStatement();
		    		rs = stmt.executeQuery(sql);
		    		while (rs.next()) {
		    		// PRINT TABLE RESULTS %> 
		    			<tr>
		    				<td><%= rs.getInt("PERSON_ID") %></td>
		    				<td><%= rs.getString("FIRST_NAME") %></td>
		    				<td><%= rs.getString("LAST_NAME") %></td>
		    				<td><%= rs.getString("ADDRESS") %></td>
		    				<td><%= rs.getString("EMAIL") %></td>
		    				<td><%= rs.getString("PHONE") %></td>
		    			</tr>
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
		// END PERSON TABLE TABLE GENERATOR %>
		</tbody>
	</table>
	
    <form method="post">
    	<fieldset>
    	<legend>Add Person</legend>
		<label for="p_person_id">PERSON_ID: </label><br>
		<input type="number" id="p_person_id" name="p_person_id" value="" placeholder=""><br>
			<p>
				<label for="p_first_name">FIRST_NAME: </label><br>
				<input type="text" id="p_first_name" name="p_first_name" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_last_name">LAST_NAME: </label><br>
				<input type="text" id="p_last_name" name="p_last_name" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_address">ADDRESS: </label><br>
				<input type="text" id="p_address" name="p_address" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_email">EMAIL: </label><br>
				<input type="text" id="p_email" name="p_email" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_phone">PHONE: </label><br>
				<input type="text" id="p_phone" name="p_phone" value="" placeholder=""><br>
			</p>
			<p><input type="submit" name="person_submit" value="Submit"></p>
		</fieldset>
	</form>
	<%
		JDBC.closeConnection(); 
	%>
</body>
</html>