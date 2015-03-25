<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add User</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
    <form action="/RadiologyApp/usermanage/users" method="post">
    	<fieldset>
    		<legend>Add User</legend>
    		<p>
				<label for="u_user_name">Username: </label><br>
				<input type="text" id="u_user_name" name="u_user_name" value="" placeholder="">
			</p>
			<p>
				<label for="u_password">Password: </label><br>
				<input type="text" id="u_password" name="u_password" value="" placeholder="">
			</p>
			<p>
				<label for="u_class">Class: </label><br>
				<input type="text" id="u_class" name="u_class" value="" placeholder="">
			</p>
			<p>
				<label for="u_person_id">Person ID: </label><br>
				<input type="text" id="u_person_id" name="u_person_id" value="" placeholder="">
			</p>
			<p><input type="submit" name="user_submit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>