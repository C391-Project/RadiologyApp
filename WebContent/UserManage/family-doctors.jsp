<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Family Doctors</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>

	<%@include file="includes/header.html" %>
	
	<h2 id="persons">Family Doctors</h2>
	<p>
		<a href="/RadiologyApp/usermanage/family-doctors/add">Add Family Doctor</a>
	</p>
	<table> <!-- Display Family Doctor Table -->
		<thead>
			<tr>
				<th>Doctor ID</th>
				<th>Patient ID</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
		<%
		// Retrieve the famiily doctor table from the database
		List<FamilyDoctor> fdList = (List<FamilyDoctor>) request.getAttribute("fdList");
		for (FamilyDoctor fd : fdList) {
		%>
			<tr>
				<td><%= fd.getDoctorId() %></td>
				<td><%= fd.getPatientId() %></td>
				<td><a href="/RadiologyApp/usermanage/family-doctors/edit?d-id=<%= fd.getDoctorId()%>&p-id=<%= fd.getPatientId()%>">Edit</a></td>
			</tr>
		<%
		}
		%>
		</tbody>
	</table> <!-- End Family Doctor Table -->
</body>
</html>