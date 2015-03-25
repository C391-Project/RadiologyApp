<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Users</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>

	<%@include file="includes/header.html" %>
	
	<h2 id="users">Users</h2>
	<p>
		<a href="/RadiologyApp/usermanage/users/add">Add User</a>
	</p>
	<table>
		<thead>
			<tr>
				<th>Username</th>
				<th>Password</th>
				<th>Class</th>
				<th>Person ID</th>
				<th>Date Registered</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
		<%
		List<User> userList = (List<User>) request.getAttribute("userList");
		for (User user : userList) {
		%>
			<tr>
				<td><%= user.getUserName() %></td>
				<td><%= user.getPassword() %></td>
				<td><%= user.getUserClass() %></td>
				<td><%= user.getPersonId() %></td>
				<td><%= user.getDateRegistered() %></td>
				<td><a href="/RadiologyApp/usermanage/users/edit?username=<%= user.getUserName()%>">Edit</a></td>
			</tr>
		<%
		}
		%>
		</tbody>
	</table>
</body>
</html>