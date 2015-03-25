<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add Family Doctor</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
    <form action="/RadiologyApp/usermanage/family-doctors" method="post">
    	<fieldset>
    		<legend>Add Family Doctor</legend>
    		<p>
				<label for="f_doctor_id">Doctor ID: </label><br>
				<input type="text" id="f_doctor_id" name="f_doctor_id" value="" placeholder="">
			</p>
			<p>
				<label for="f_patient_id">Patient ID: </label><br>
				<input type="text" id="f_patient_id" name="f_patient_id" value="" placeholder="">
			</p>
			<p><input type="submit" name="family_doctor_submit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>