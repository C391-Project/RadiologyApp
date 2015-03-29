<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, java.util.ArrayList, database.JDBC"%>
<%
	//The purpose of this file is to view the 
	//datacube we created in data-analysis.jsp

	Connection conn = null;
	final int FLAGWEEK = 1;
	final int FLAGMONTH = 2;
		
	Statement stmt = null;
	ResultSet rset = null;
	String patient = request.getParameter("PATIENTID").trim();
	String testType = request.getParameter("TESTTYPE").trim();
	String timeStyle = request.getParameter("TIME").trim();
	String year = request.getParameter("YEAR").trim();

	//TEST WE GET WHAT WE NEED
	//TODO DELETE THIS WHEN THE FILE WORKS 
	out.println(patient);
	out.println(testType);
	out.println(timeStyle);
	out.println(year);
	//END TEST

	String NUM = "PATIENT_NUM_IMAGE2";
	String TIM = "TIME_ID";
	String PER = "PERSONS";
	String PAT = "PATIENT_ID";
	String TES = "TEST_TYPE";
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
		sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE,";
		}
	}
	int timeFlag = 0; 
	if(timeStyle.equals("WEEK")){
		timeFlag = FLAGWEEK;
		sql += "week,";
	} else if(timeStyle.equals("MONTH")) {
		timeFlag = FLAGMONTH;
		sql += " month,";
	}
	sql += "year ORDER BY ";
	if(timeFlag == 1){
		sql += "year,week ";
	}else if(timeFlag == 2){
		sql += "year,month ";
	}else{
		sql += "year ";
	}
//out.println("<hr>"+sql+"<hr>");
out.println("<div class=\"container\">");
out.println("<h1>Results</h1>");
out.println("<table class=\"table table-bordered\">");
out.println("<tr class=\"active\">");




JDBC.closeConnection();
%>