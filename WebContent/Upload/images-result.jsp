<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload Result</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	<h2>Image Upload Result</h2>
		<p>
			<a href="/RadiologyApp/upload/images/add?record_id=<%= request.getAttribute("id")%>">Attach another Image to Record <%= request.getAttribute("record_id") %></a>
		</p>
	<p> 
		Full Size:<br>
		<img src="/RadiologyApp/images/fullsize?id=<%= request.getAttribute("id") %>" alt="">
	</p>
	<p>
		Regular Size:<br>
		<img src="/RadiologyApp/images/regular?id=<%= request.getAttribute("id") %>" alt="" width="500">
	</p>
	<p>
		Thumbnail Size:<br>
		<img src="/RadiologyApp/images/thumbnail?id=<%= request.getAttribute("id") %>" alt="" width="125">
	</p>
</body>
</html>