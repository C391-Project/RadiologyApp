<HTML>
<HEAD>
<TITLE>User Login</TITLE>
</HEAD>

<BODY>

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
	
<h1>User Login</h1>
	<form method="post" action="LoginServlet">
		<p><input type="text" name="USERID" value="" placeholder="Username"></p>
		<p><input type="password" name="PASSWD" value="" placeholder="Password"></p>
		<p><input type="checkbox" name="labconnection" value="yes">Connecting From Lab</p>
		<p class="submit"><input type="submit" name="Submit" value="Login"></p>
	</form>
<hr>
</BODY>
</HTML>
