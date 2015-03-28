<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, database.*"%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload Result</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	<%
		RadiologyRecord record = (RadiologyRecord) request.getAttribute("record");
		if (record != null) {
	%>
		<h2>Record Upload Result</h2>
		<p>
			<a href="/RadiologyApp/upload/images/add?record_id=<%= record.getRecordId()%>">Attach an Image</a>
		</p>
		<table>
			<thead>
				<tr>
					<th>Record ID</th>
					<th>Patient ID</th>
					<th>Doctor ID</th>
					<th>Radiologist ID</th>
					<th>Test Type</th>
					<th>Prescribing Date</th>
					<th>Test Date</th>
					<th>Diagnosis</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%= record.getRecordId() %></td>
					<td><%= record.getPatientId() %></td>
					<td><%= record.getDoctorId() %></td>
					<td><%= record.getRadiologistId() %></td>
					<td><%= record.getTestType() %></td>
					<td><%= record.getPrescribingDate() %></td>
					<td><%= record.getTestDate() %></td>
					<td><%= record.getDiagnosis() %></td>
					<td><%= record.getDescription() %></td>
				</tr>
			</tbody>
		</table>
	<% 
		} 
	%>
</body>
</html>