<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload Radiology Record</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
    <form id="image-upload-form" action="/RadiologyApp/upload/records" method="post">
		<fieldset>
    		<legend>Upload Radiology Record</legend>
    		<p>
				<label for="r_patient_id">Patient ID: </label><br>
				<input type="text" id="r_patient_id" name="r_patient_id" value="" placeholder="">
			</p>
			<p>
				<label for="r_doctor_id">Doctor ID: </label><br>
				<input type="text" id="r_doctor_id" name="r_doctor_id" value="" placeholder="">
			</p>
			<p>
				<label for="r_radiologist_id">Radiologist ID: </label><br>
				<input type="text" id="r_radiologist_id" name="r_radiologist_id" value="" placeholder="">
			</p>
			<p>
				<label for="r_test_type">Test Type: </label><br>
				<input type="text" id="r_test_type" name="r_test_type" value="" placeholder="">
			</p>
			<p>
				<label for="r_prescribing_date">Prescribing Date: </label><br>
				<input type="date" id="r_prescribing_date" name="r_prescribing_date" value="" placeholder="YYYY-MM-DD">
			</p>
			<p>
				<label for="r_test_date">Test Date: </label><br>
				<input type="date" id="r_test_date" name="r_test_date" value="" placeholder="YYYY-MM-DD">
			</p>
			<p>
				<label for="r_diagnosis">Diagnosis: </label><br>
				<input type="text" id="r_diagnosis" name="r_diagnosis" value="" placeholder="">
			</p>
			<p>
				<label for="r_description">Description: </label><br>
				<input type="text" id="r_description" name="r_description" value="" placeholder="">
			</p>
			<p><input type="submit" name="record_submit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>