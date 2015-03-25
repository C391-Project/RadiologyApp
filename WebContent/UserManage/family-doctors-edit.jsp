<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Edit Family Doctor</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
	<% FamilyDoctor fd = (FamilyDoctor) request.getAttribute("family-doctor"); %>
	
    <form action="/RadiologyApp/usermanage/family-doctors" method="post">
    	<fieldset>
    		<legend>Edit Family Doctor</legend>
    		<input type="hidden" name="f_original_doctor_id" value="<%= fd.getDoctorId() %>">
    		<input type="hidden" name="f_original_patient_id" value="<%= fd.getPatientId() %>">
    		<p>
				<label for="f_doctor_id">Doctor ID: </label><br>
				<input type="text" id="f_doctor_id" name="f_doctor_id" value="<%= fd.getDoctorId() %>" placeholder="">
			</p>
			<p>
				<label for="f_patient_id">Patient ID: </label><br>
				<input type="text" id="f_patient_id" name="f_patient_id" value="<%= fd.getPatientId() %>" placeholder="">
			</p>
			<p><input type="submit" name="family_doctor_edit" value="Update"></p>
		</fieldset>
	</form>
	<form action="/RadiologyApp/usermanage/family-doctors" method="post">
		<fieldset>
    		<legend>Delete Family Doctor</legend>
    		<input type="hidden" name="f_doctor_id" value="<%= fd.getDoctorId() %>">
    		<input type="hidden" name="f_patient_id" value="<%= fd.getPatientId() %>">
			<p><input type="submit" name="family_doctor_delete" value="Delete This Family Doctor"></p>
		</fieldset>
	</form>
</body>
</html>