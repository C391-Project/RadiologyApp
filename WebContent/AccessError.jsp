
<html>
<head>
<meta charset="UTF-8">
<title>Access Error</title>
</head>
<body>
	<h1>Access Denied</h1>
	<%

	out.println("<h3>Access denied, redirecting to login page...</h3>");
	response.setHeader("Refresh", "3; URL=login.html");	
	
			
	%>
</body>
</html>