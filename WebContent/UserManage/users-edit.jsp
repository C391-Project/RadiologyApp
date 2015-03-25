<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Person</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
	<% User user = (User) request.getAttribute("user"); %>
	
    <form action="/RadiologyApp/usermanage/users" method="post">
    	<fieldset>
    		<legend>Edit User <%= user.getUserName() %></legend>
    		<input type="hidden" name="u_original_user_name" value="<%= user.getUserName() %>">
    		<p>
				<label for="u_user_name">Username: </label><br>
				<input type="text" id="u_user_name" name="u_user_name" value="<%= user.getUserName() %>" placeholder="">
			</p>
			<p>
				<label for="u_password">Password: </label><br>
				<input type="text" id="u_password" name="u_password" value="<%= user.getPassword() %>" placeholder="">
			</p>
			<p>
				<label for="u_class">Class: </label><br>
				<input type="text" id="u_class" name="u_class" value="<%= user.getUserClass() %>" placeholder="">
			</p>
			<p>
				<label for="u_person_id">Person ID: </label><br>
				<input type="text" id="u_person_id" name="u_person_id" value="<%= user.getPersonId() %>" placeholder="">
			</p>
			<p>
				<label for="u_date_registered">Date Registered: </label><br>
				<input type="text" id="u_date_registered" name="u_date_registered" value="<%= user.getDateRegistered() %>" placeholder="yyyy-mm-dd">
			</p>
			<p><input type="submit" name="user_edit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>