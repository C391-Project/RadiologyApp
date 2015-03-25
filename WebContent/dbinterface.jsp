<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="database.*" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Persons - View</title>
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
	
	String usertype=null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null)
	{
		for(Cookie cookie : cookies)
		{
    		if(cookie.getName().equals("usertype")) 
    			usertype = cookie.getValue();
		}
	}
	
	//user power contronl, only admin can get access to this page
			
			//response.sendRedirect("login.html");
		if(usertype.equals("Admin"))
		{
			out.println("<h3>Login successful!</h3>");
		}
		else
		{
			response.sendRedirect("AccessError.jsp");	
		}
		
		
	%>
	
	
	

	<%  
		// Page Globals
		DataSource ds = new DataSource();
		boolean isPost = "POST".equals(request.getMethod());
		if (ds.isNotConfigured()) {
			//redirect to oracle login page and remember this page.
			session.setAttribute("returnPage", "dbinterface.jsp");
			response.sendRedirect("oracle-login");
		}
	%>
	<!-- BEGIN BODY HTML -->
	<header id="top">
		<h1>User Management</h1>
		<nav>
			<ul>
				<li><a href="">Persons</a></li>
				<li><a href="">Users</a></li>
				<li><a href="">Family Doctor</a></li>
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
	
	<h2 id="users">USERS</h2>
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
				<input type="text" id="u_user_name" name="u_user_name" value="" placeholder="">
			</p>
			<p>
				<label for="u_password">PASSWORD: </label><br>
				<input type="text" id="u_password" name="u_password" value="" placeholder="">
			</p>
			<p>
				<label for="u_class">CLASS: </label><br>
				<input type="text" id="u_class" name="u_class" value="" placeholder="">
			</p>
			<p>
				<label for="u_person_id">PERSON_ID: </label><br>
				<input type="text" id="u_person_id" name="u_person_id" value="" placeholder="">
			</p>
			<p><input type="submit" name="user_submit" value="Submit"></p>
		</fieldset>
	</form>
	<!-- END USER TABLE INTERFACE -->
	
	<!-- BEGIN FAMILY_DOCTOR TABLE INTERFACE -->
	<%
		boolean isFamilyDoctorSubmit = (request.getParameter("family_doctor_submit") != null);
		if (isPost && isFamilyDoctorSubmit) {
			FamilyDoctor fd = new FamilyDoctor(request);
			if (fd.isValid()) {
				ds.submitFamilyDoctor(fd);
			} else {
	%>
		<p>Could not submit family doctor. Missing fields required.</p>
	<%
			}
		}
	%>
	
	<h2 id="family-doctor">FAMILY_DOCTOR</h2>
	<table>
		<thead>
			<tr>
				<th>DOCTOR_ID</th>
				<th>PATIENT_ID</th>
			</tr>
		</thead>
		<tbody>
		<%
			List<FamilyDoctor> fdList = ds.getFamilyDoctorList();
			for (FamilyDoctor fd : fdList) {
		%>
				<tr>
					<td><%= fd.getDoctorId() %></td>
					<td><%= fd.getPatientId() %></td>
				</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
    <form method="post">
    	<fieldset>
    		<legend>Add Family Doctor</legend>
    		<p>
				<label for="f_doctor_id">DOCTOR_ID: </label><br>
				<input type="text" id="f_doctor_id" name="f_doctor_id" value="" placeholder="">
			</p>
			<p>
				<label for="f_patient_id">PATIENT_ID: </label><br>
				<input type="text" id="f_patient_id" name="f_patient_id" value="" placeholder="">
			</p>
			<p><input type="submit" name="family_doctor_submit" value="Submit"></p>
		</fieldset>
	</form>
	<!-- END FAMILY_DOCTOR TABLE INTERFACE -->
	
</body>
</html>