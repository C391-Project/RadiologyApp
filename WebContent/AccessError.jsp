
<html>
<head>
<meta charset="UTF-8">
<title>Access Error</title>
</head>
<body>
	<h1>Access Denied</h1>
	<%
	//Warning page, built to display the access prilivege warning and redirect to the loginpage
	
	out.println("<h3>Access denied, redirecting to login page...</h3>");
	response.setHeader("Refresh", "2; URL=login.jsp");	
		
	%>
</body>
</html>