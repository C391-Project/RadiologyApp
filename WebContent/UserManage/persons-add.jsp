<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add Person</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
    <form action="/RadiologyApp/usermanage/persons" method="post">
    	<fieldset>
	    	<legend>Add Person</legend>
			<p>
				<label for="p_first_name">First Name: </label><br>
				<input type="text" id="p_first_name" name="p_first_name" value="" placeholder="">
			</p>
			<p>
				<label for="p_last_name">Last Name: </label><br>
				<input type="text" id="p_last_name" name="p_last_name" value="" placeholder="">
			</p>
			<p>
				<label for="p_address">Address: </label><br>
				<input type="text" id="p_address" name="p_address" value="" placeholder="">
			</p>
			<p>
				<label for="p_email">Email: </label><br>
				<input type="text" id="p_email" name="p_email" value="" placeholder="">
			</p>
			<p>
				<label for="p_phone">Phone: </label><br>
				<input type="text" id="p_phone" name="p_phone" value="" placeholder="">
			</p>
			<p><input type="submit" name="person_submit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>