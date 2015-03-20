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
	<%  
		// Page Globals
		DataSource ds = new DataSource();
		boolean isPost = "POST".equals(request.getMethod());
		if (ds.isNotConfigured()) {
			//redirect to oracle login page and remember this page.
			session.setAttribute("returnPage", request.getAttribute("javax.servlet.forward.request_uri"));
			response.sendRedirect("oracle-login.html");
		}
	%>
	<!-- BEGIN BODY HTML -->
	<header id="top">
		<h1>Database Interface</h1>
		<nav>
			<ul>
				<li><a href="#persons">PERSONS</a></li>
				<li><a href="#users">USERS</a></li>
				<li><a href="#family-doctor">FAMILY_DOCTOR</a></li>
			</ul>
		</nav>
	</header>
	
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
	
	<h2 id="persons">PERSONS</h2>
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
		<input type="number" id="p_person_id" name="p_person_id" value="" placeholder="">
			<p>
				<label for="p_first_name">FIRST_NAME: </label><br>
				<input type="text" id="p_first_name" name="p_first_name" value="" placeholder="">
			</p>
			<p>
				<label for="p_last_name">LAST_NAME: </label><br>
				<input type="text" id="p_last_name" name="p_last_name" value="" placeholder="">
			</p>
			<p>
				<label for="p_address">ADDRESS: </label><br>
				<input type="text" id="p_address" name="p_address" value="" placeholder="">
			</p>
			<p>
				<label for="p_email">EMAIL: </label><br>
				<input type="text" id="p_email" name="p_email" value="" placeholder="">
			</p>
			<p>
				<label for="p_phone">PHONE: </label><br>
				<input type="text" id="p_phone" name="p_phone" value="" placeholder="">
			</p>
			<p><input type="submit" name="person_submit" value="Submit"></p>
		</fieldset>
	</form>
	<!-- END PERSON TABLE INTERFACE -->
</body>
</html>