<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle Login | RadiologyApp</title>
</head>
<body>
	<% 
	if (session.getAttribute("error") != null) {
	%>
		<p style="color: red"><%= session.getAttribute("error") %></p>
	<%
		session.setAttribute("error", null);
	} else {
	%>
		<h1>Welcome to RadiologyApp</h1>
	<%
	}
	%>
	<h2>Oracle Login</h2>
	<p>Please login to the oracle account you wish to access:</p>
	<form method="post" action="/RadiologyApp/oracle-login">
		<p><input type="text" name="username" value="" placeholder="Username"></p>
		<p><input type="password" name="password" value="" placeholder="Password"></p>
		<p><input type="checkbox" name="labconnection" value="yes">Connecting From Lab</p>
		<p class="submit"><input type="submit" name="commit" value="Login"></p>
	</form>
</body>
</html>