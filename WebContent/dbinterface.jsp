<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="db.*" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DBInterface</title>
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
	<h1>Database Interface</h1>
	<%  
		// Page Globals
		DataSource ds = new DataSource();
		boolean isPost = "POST".equals(request.getMethod());
	%>
	
	<!-- BEGIN PERSON TABLE INTERFACE -->
	<%
		boolean isPersonSubmit = (request.getParameter("person_submit") != null);
		if (isPost && isPersonSubmit) {
			Person person = new Person(request);
			if (person.isValid()) {
				ds.submitPerson(person);
			} else {
	%>
		<p>Could not submit person. Missing fields required.</p>
	<%
			}
		}
	%>
	
	<h1>Database Viewer</h1>
	<h2>PERSONS</h2>
	<table>
		<thead>
			<tr>
				<th>PERSON_ID</th>
				<th>FIRST_NAME</th>
				<th>LAST_NAME</th>
				<th>ADDRESS</th>
				<th>EMAIL</th>
				<th>PHONE</th>
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
	
    <form method="post">
    	<fieldset>
    	<legend>Add Person</legend>
		<label for="p_person_id">PERSON_ID: </label><br>
		<input type="number" id="p_person_id" name="p_person_id" value="" placeholder=""><br>
			<p>
				<label for="p_first_name">FIRST_NAME: </label><br>
				<input type="text" id="p_first_name" name="p_first_name" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_last_name">LAST_NAME: </label><br>
				<input type="text" id="p_last_name" name="p_last_name" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_address">ADDRESS: </label><br>
				<input type="text" id="p_address" name="p_address" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_email">EMAIL: </label><br>
				<input type="text" id="p_email" name="p_email" value="" placeholder=""><br>
			</p>
			<p>
				<label for="p_phone">PHONE: </label><br>
				<input type="text" id="p_phone" name="p_phone" value="" placeholder=""><br>
			</p>
			<p><input type="submit" name="person_submit" value="Submit"></p>
		</fieldset>
	</form>
	<!-- END PERSON TABLE INTERFACE -->
	
	<!-- BEGIN USER TABLE INTERFACE -->
	<%
		boolean isUserSubmit = (request.getParameter("user_submit") != null);
		if (isPost && isUserSubmit) {
			User user = new User(request);
			if (user.isValid()) {
				ds.submitUser(user);
			} else {
	%>
		<p>Could not submit user. Missing fields required.</p>
	<%
			}
		}
	%>
	
	<h2>USERS</h2>
	<table>
		<thead>
			<tr>
				<th>USER_NAME</th>
				<th>PASSWORD</th>
				<th>CLASS</th>
				<th>PERSON_ID</th>
				<th>DATE_REGISTERED</th>
			</tr>
		</thead>
		<tbody>
		<%
			List<User> userList = ds.getUserList();
			for (User user : userList) {
		%>
				<tr>
					<td><%= user.getUserName() %></td>
					<td><%= user.getPassword() %></td>
					<td><%= user.getUserClass() %></td>
					<td><%= user.getPersonId() %></td>
					<td><%= user.getDateRegistered() %></td>
				</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
    <form method="post">
    	<fieldset>
    		<legend>Add User</legend>
    		<p>
				<label for="u_user_name">USER_NAME: </label><br>
				<input type="text" id="u_user_name" name="u_user_name" value="" placeholder=""><br>
			<p>
				<label for="u_password">PASSWORD: </label><br>
				<input type="text" id="u_password" name="u_password" value="" placeholder=""><br>
			</p>
			<p>
				<label for="u_class">CLASS: </label><br>
				<input type="text" id="u_class" name="u_class" value="" placeholder=""><br>
			</p>
			<p>
				<label for="u_person_id">PERSON_ID: </label><br>
				<input type="text" id="u_person_id" name="u_person_id" value="" placeholder=""><br>
			</p>
			<p><input type="submit" name="user_submit" value="Submit"></p>
		</fieldset>
	</form>
	<!-- END USER TABLE INTERFACE -->
</body>
</html>