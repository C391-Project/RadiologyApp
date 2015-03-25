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
	
	<% Person person = (Person) request.getAttribute("person"); %>
	
    <form action="/RadiologyApp/usermanage/persons" method="post">
    	<fieldset>
    		<legend>Edit Person</legend>
    		<p>
				Person Id: <%= person.getPersonId() %><br>
				<input type="hidden" name="p_person_id" value="<%= person.getPersonId() %>">
			</p>
			<p>
				<label for="p_first_name">First Name: </label><br>
				<input type="text" id="p_first_name" name="p_first_name" value="<%= person.getFirstName() %>" placeholder="">
			</p>
			<p>
				<label for="p_last_name">Last Name: </label><br>
				<input type="text" id="p_last_name" name="p_last_name" value="<%= person.getLastName() %>" placeholder="">
			</p>
			<p>
				<label for="p_address">Address: </label><br>
				<input type="text" id="p_address" name="p_address" value="<%= person.getAddress() %>" placeholder="">
			</p>
			<p>
				<label for="p_email">Email: </label><br>
				<input type="text" id="p_email" name="p_email" value="<%= person.getEmail() %>" placeholder="">
			</p>
			<p>
				<label for="p_phone">Phone: </label><br>
				<input type="text" id="p_phone" name="p_phone" value="<%= person.getPhone() %>" placeholder="">
			</p>
			<p><input type="submit" name="person_edit" value="Update"></p>
		</fieldset>
	</form>
	<form action="/RadiologyApp/usermanage/persons" method="post">
		<fieldset>
    		<legend>Delete Person</legend>
    		<input type="hidden" name="p_person_id" value="<%= person.getPersonId() %>">
			<p><input type="submit" name="person_delete" value="Delete Person <%= person.getPersonId() %>"></p>
		</fieldset>
	</form>
</body>
</html>