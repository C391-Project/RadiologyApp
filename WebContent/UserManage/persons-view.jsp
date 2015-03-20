<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Persons-View</title>
<style>
	body {
	  font: normal medium/1.4 sans-serif;
	}
	table {
	  border-collapse: collapse;
	  width: 100%;
	}
	th, td {
	  padding: 0.25rem;
	  text-align: left;
	  border: 1px solid #ccc;
	}
	tbody tr:nth-child(odd) {
	  background: #eee;
	}
</style>
</head>
<body>

	<%@include file="header.jsp" %>
	
	<h2 id="persons">Persons</h2>
	<table>
		<thead>
			<tr>
				<th>Person Id</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Address</th>
				<th>Email</th>
				<th>Phone</th>
			</tr>
		</thead>
		<tbody>
		<%
			List<Person> personList = ds.getPersonList();
			for (Person person : personList) {
		%>
				<tr>
					<td><%= person.getPersonId() %></td>
					<td><%= person.getFirstName() %></td>
					<td><%= person.getLastName() %></td>
					<td><%= person.getAddress() %></td>
					<td><%= person.getEmail() %></td>
					<td><%= person.getPhone() %></td>
				</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
</body>
</html>