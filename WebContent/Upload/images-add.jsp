<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload Image</title>
	<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>
	<%@include file="includes/header.html" %>
	
    <form id="image-upload-form" enctype="multipart/form-data" action="/RadiologyApp/upload" method="post">
		<fieldset>
    		<legend>Upload Image</legend>
    		<p>
				<label for="i_record_id">Record ID: </label><br>
				<input type="number" id="i_record_id" name="i_record_id" value="" placeholder="">
			</p>
			<p>
				<label for="i_file">Image: </label><br>
				<input type="file" id="i_file" name="i_file" value="" placeholder="">
			</p>
			<p><input type="submit" name="image_submit" value="Submit"></p>
		</fieldset>
	</form>
</body>
</html>