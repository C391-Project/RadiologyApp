<html>
<head></head>
<body>
	Your info has been received:
	<br><br>
	<%
		String sName = 	request.getParameter("test");
		out.print(sName);
	%>
</body>
</html>