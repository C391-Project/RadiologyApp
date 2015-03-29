<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, java.util.ArrayList, database.JDBC"%>
<%
//The purpose of this file is to view the 
//datacube we created in data-analysis.jsp

Connection conn = null;
		
Statement stmt = null;
ResultSet rset = null;
String patient = request.getParameter("PATIENTID").trim();
String testType = request.getParameter("TESTTYPE").trim();
String timeStyle = request.getParameter("TIME").trim();
String year = request.getParameter("YEAR").trim();

//TEST WE GET WHAT WE NEED
out.println(patient);
out.println(testType);
out.println(timeStyle);
out.println(year);
//END TEST

// Initialize these lists to store all of our results for displaying 
ArrayList patientNames = new ArrayList();
ArrayList testTypes = new ArrayList();
ArrayList weeks = new ArrayList();
ArrayList months = new ArrayList();
ArrayList years = new ArrayList();
ArrayList nums = new ArrayList();

//Connect to the database
conn = JDBC.connect();
//begin creating our sql statement
String sql = "SELECT ";

// Might need to add flags here 
if(!patient.equals("NONE")) {
	sql += "CONCAT(p.first_name, CONCAT(' ', p.last_name)) as name,";
}
if(!testType.equals("NONE")) {
	if(testType.equals("ALL")) {
		sql += "test_type.TEST_TYPE,";
	} else {
	sql += "imagenum.TEST_TYPE,";
	}
}




JDBC.closeConnection();
%>