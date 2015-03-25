<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="database.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Persons</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>

	<%@include file="includes/header.html" %>
	
	<h2 id="persons">Persons</h2>
	<p>
		<a href="/RadiologyApp/usermanage/persons/add">Add Person</a>
	</p>
	<table>
		<thead>
			<tr>
				<th>Person Id</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Address</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
		<%
		List<Person> personList = (List<Person>) request.getAttribute("personList");
		for (Person person : personList) {
		%>
			<tr>
				<td><%= person.getPersonId() %></td>
				<td><%= person.getFirstName() %></td>
				<td><%= person.getLastName() %></td>
				<td><%= person.getAddress() %></td>
				<td><%= person.getEmail() %></td>
				<td><%= person.getPhone() %></td>
				<td><a href="/RadiologyApp/usermanage/persons/edit?id=<%= person.getPersonId()%>">Edit</a></td>
			</tr>
		<%
		}
		%>
		</tbody>
	</table>
</body>
</html>