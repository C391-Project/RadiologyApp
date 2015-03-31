<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search</title>
<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
</head>
<body>

</body>
</html>

<% String pageName = "search"; %>
<div class="container">
	<form name="searchForm" method="post" role="form">
	<h1>Search</h1>
	<input type="text" name="KEYWORDS" size="100" placeholder="Keywords...">
	<BR>
		From: <input type="text" name="FROM" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
		To: <input type="text" name="TO" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
	<BR>
		Ordered by: <select name="ORDER">
		<option value="newest">Newest</option>
		<option value="oldest">Oldest</option>
		<option value="rank">Rank</option>
	</select>
	<BR>
		<button type="submit" name="Submit">Fetch</button>
	</form>
</div>

<%@ page import="java.sql.*,database.JDBC"%>
<%

String driverName = "oracle.jdbc.driver.OracleDriver";
String dbhomestring="jdbc:oracle:thin:@localhost:1525:CRS"; //working from home
String dblabstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; //working form school
String dbstring="jdbc:oracle:thin:@localhost:1525:CRS";
dbstring=dblabstring;

try{
    //load and register the driver
	Class drvClass = Class.forName(driverName); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
}
catch(Exception ex){
    out.println("<hr>" + ex.getMessage() + "<hr>");

}

	String userType = (String) session.getAttribute("usertype"); 
	
	//When submit is hit get all of its fields 

	
	int ID = (Integer) session.getAttribute("person_id");
	if (request.getParameter("Submit") != null) {
		String keywords[] = (request.getParameter("KEYWORDS")).trim().split("\\s+");
		String dateFrom = (request.getParameter("FROM")).trim();
		String dateTo = (request.getParameter("TO")).trim();
		String orderBy = (request.getParameter("ORDER")).trim();
		//establish the connection to the underlying database
		Connection conn = null;
		conn = JDBC.connect();		
%>
<% //TODO //DATABASECONNECT %>
<%
	//select the names of patient,doctor and radiologist, the date and the images with the keywords and date we input.
	//the user's class will be checked and only the legal result will be displayed
	Statement stmt = null;
	ResultSet rset = null;
	//I think this will work I have no idea. I wrote it and tested it with SQLplus in mind
	//but I have not tested it on here yet
	String sql = "SELECT r.record_id, r.patient_id, r.doctor_id, r.radiologist_id, image_id, CONCAT(p1.first_name, CONCAT(' ', p1.last_name)) AS patient_name," +
	" CONCAT(p2.first_name, CONCAT(' ', p2.last_name)) AS doctor_name," +
	" CONCAT(p3.first_name, CONCAT(' ', p3.last_name)) AS radiologist_name," +
	" test_type, TO_DATE(prescribing_date, 'DD-MM-YY') AS prescribing_date, TO_DATE(test_date, 'DD-MM-YY') AS test_date, diagnosis, description" +
	" FROM radiology_record r LEFT OUTER JOIN pacs_images i ON r.record_id = i.record_id, persons p1, persons p2, persons p3" +
	" WHERE p1.person_id = r.patient_id AND p2.person_id = r.doctor_id AND p3.person_id = r.radiologist_id";
	
	//TODO GET THE USER INFORMATION FROM THE db AND PARSE ALL OF THAT STUFF
	if (userType.equals("r")) { sql += " AND r.radiologist_id = '" + ID + "'";}
	else if (userType.equals("d")) {sql += " AND r.doctor_id = '" + ID + "'"; }
	else if (userType.equals("p")) {sql += " AND r.patient_id = '" + ID + "'";}
	
	if (!keywords[0].isEmpty()) {
		sql += " AND (CONTAINS(p1.first_name, '" + keywords[0];
		for (int i = 1; i < keywords.length; i++) { sql += " AND " + keywords[i]; }
		sql += "', 1) > 0 OR CONTAINS(p1.last_name, '" + keywords[0];
		for (int i = 1; i < keywords.length; i++) { sql += " AND " + keywords[i]; }
		sql += "', 2) > 0 OR CONTAINS(r.diagnosis, '" + keywords[0];
		for (int i = 1; i < keywords.length; i++) { sql += " AND " + keywords[i]; }
		sql += "', 3) > 0 OR CONTAINS(r.description, '" + keywords[0];
		for (int i = 1; i < keywords.length; i++)	{ sql += " AND " + keywords[i]; }
		sql += "', 4) > 0)";
	}
	sql += " ORDER BY";
	if (orderBy.equals("newest")) { sql += " test_date, record_id DESC"; }
	else if (orderBy.equals("oldest")) { sql += " test_date, record_id ASC";}
	//Ranking specification on 
	else if (keywords.length > 0) { sql += " (6*(SCORE(1)+SCORE(2)) + 3*SCORE(3) + SCORE(4)), record_id DESC"; }
	else
	//last little bit to the SQL
	sql += " record_id DESC";
	
	//Try to execute the stament
	try {
		stmt = conn.createStatement();
		//out.print(sql);
		rset = stmt.executeQuery(sql);
		int recordID;
		int imageID;
		String patientName;
		String doctorName;
		
		// Generate Table Header
		out.println("<table>");
		out.println("<thead>");
		out.println("<tr>");
		out.println("<th>");
		out.println("Record ID");
		out.println("</th>");
		out.println("<th>");
		out.println("Patient Name (ID)");
		out.println("</th>");
		out.println("<th>");
		out.println("Doctor Name (ID)");
		out.println("</th>");
		out.println("<th>");
		out.println("Radiologist Name (ID)");
		out.println("</th>");
		out.println("<th>");
		out.println("Test Type");
		out.println("</th>");
		out.println("<th>");
		out.println("Prescribing Date");
		out.println("</th>");
		out.println("<th>");
		out.println("Test Date");
		out.println("</th>");
		out.println("<th>");
		out.println("Diagnosis");
		out.println("</th>");
		out.println("<th>");
		out.println("Description");
		out.println("</th>");
		out.println("<th>");
		out.println("Image");
		out.println("</th>");
		out.println("</tr>");
		out.println("</thead>");
		
		while (rset.next())
		{
			//out.println("hello");
			/* recordID = rset.getInt("record_id");
			imageID = rset.getInt("image_id");
			patientName = rset.getString(3).trim();
			out.println("test_Patientname:");
			out.println(patientName);
			doctorName = rset.getString(4).trim();
			out.println("   test_doctorname:");
			out.println(doctorName);
			out.println("   test_recordID:");
			out.println(recordID);
			out.println(imageID); */
			
			%> 
				<tr>
					<td><%= rset.getInt("record_id") %></td>
					<td><%= rset.getString("patient_name") %> (<%= rset.getInt("patient_id") %>)</td>
					<td><%= rset.getString("doctor_name") %> (<%= rset.getInt("doctor_id") %>)</td>
					<td><%= rset.getString("radiologist_name") %> (<%= rset.getInt("radiologist_id") %>)</td>
					<td><%= rset.getString("test_type") %></td>
					<td><%= rset.getDate("prescribing_date") %></td>
					<td><%= rset.getDate("test_date") %></td>
					<td><%= rset.getString("diagnosis") %></td>
					<td><%= rset.getString("description") %></td>
					<td>
					<%
						int imageId = rset.getInt("image_id");
						if (imageId != 0) {
					%>
						<a href="/RadiologyApp/images/fullsize?id=<%= rset.getInt("image_id") %>">
							<img src="/RadiologyApp/images/thumbnail?id=<%= rset.getInt("image_id") %>">
						</a>
					<%
						}
					%>
					</td>
				</tr>
			<%
		}
	} catch (Exception ex) {
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	//Close the connection
	JDBC.closeConnection();

}
%>

	</FORM>
	<FORM NAME='ReturnForm' ACTION='index.jsp' METHOD='get'>
	<INPUT TYPE='submit' NAME='return' VALUE='Return'>
	</FORM>

</body>
</html>
