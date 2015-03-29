<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, java.util.ArrayList, database.JDBC"%>
<%
	//The purpose of this file is to view the 
	//datacube we created in data-analysis.jsp

	Connection conn = null;
	final int FLAGWEEK = 1;
	final int FLAGMONTH = 2;
	final int FLAGYEAR = 3;
	final int FLAGPATIENTID=1;
	final int FLAGRECORD = 2;
	final int FLAGPATIENTANDRECORD = 3;
	int IDANDRECORDFLAG = 0;
	int TIMEFLAG = FLAGYEAR;
		
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
	//oh god please kill me
	String sql = "SELECT ";

	if(!patient.equals("NONE")) {
		IDANDRECORDFLAG = FLAGPATIENTID;
		sql = sql + "CONCAT(p.first_name, CONCAT(' ', p.last_name)) as name,";
	}
	if(!testType.equals("NONE")) {
		if (IDANDRECORDFLAG == FLAGPATIENTID) {
			IDANDRECORDFLAG = FLAGPATIENTANDRECORD;
		} else {
			IDANDRECORDFLAG = FLAGRECORD;
		}
		if(testType.equals("ALL")){
			sql += "TEST_TYPE.TEST_TYPE,";
		}else{
		sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE,";
		}
	}
	if(timeStyle.equals("WEEK")){
		TIMEFLAG = FLAGWEEK;
		sql += "TIME_ID.WEEK AS week,";
	}
	else if(timeStyle.equals("MONTH")){
		TIMEFLAG = FLAGMONTH;
		sql += "TIME_ID.MONTH AS month,";
	}
	sql += "TIME_ID.YEAR AS year," + "SUM(PATIENT_NUM_IMAGE_TABLE.NUM) ";
	sql += "FROM PATIENT_NUM_IMAGE_TABLE,TIME_ID";
	if(!patient.equals("NONE")) {
		sql += ",PERSONS p,PATIENT p2 ";
	}
	if(!testType.equals("NONE")) {
		if(testType.equals("ALL")){
			sql += ",TEST_TYPE";
		}
	}
	sql += " WHERE ";
	if(!patient.equals("NONE")){
		sql += "p.person_id = p2.PATIENT_ID AND p2.PATIENT_ID = PATIENT_NUM_IMAGE_TABLE.PATIENT_ID AND ";
		if(!patient.equals("ALL")){
			sql += "p2.PATIENT_ID = " + patient + " AND ";
		}
	}
	if(!testType.equals("NONE")){
		if(testType.equals("ALL")){
			sql += "TEST_TYPE.TEST_TYPE = PATIENT_NUM_IMAGE_TABLE.TEST_TYPE AND ";
		}else{
			sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE = '" + testType + "' AND ";
		}
	}
	if(!year.equals("ALL")){
		sql += "TIME_ID.YEAR =" + year + " AND ";
	}
	sql += "TIME_ID.TIME_ID =PATIENT_NUM_IMAGE_TABLE.TIME_ID ";
	sql += "GROUP BY ";
	if(!patient.equals("NONE")) {
		sql += "CONCAT(p.first_name, CONCAT(' ', p.last_name)),";
	}
	if(!testType.equals("NONE")) {
		if(testType.equals("ALL")){
			sql += "TEST_TYPE.TEST_TYPE,";
		}else{
			sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE,";
		}
	}
	if(timeStyle.equals("WEEK")){
		sql = sql + "week,";
	}
	else if(timeStyle.equals("MONTH")){
		sql = sql + " month,";
	}
	sql = sql + "year ORDER BY ";
	if(TIMEFLAG == FLAGWEEK){
		sql = sql + "year,week ";
	}else if(TIMEFLAG == FLAGMONTH){
		sql = sql + "year,month ";
	}else{
		sql = sql + "year ";
	}
	
	
out.println("<div class=\"container\">");
out.println("<h1>Results</h1>");
out.println("<table class=\"table table-bordered\">");
out.println("<tr class=\"active\">");
try {
	stmt = conn.createStatement();
	out.println(sql);
	rset = stmt.executeQuery(sql);
	if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGWEEK){
		out.println("<th>Patient</th>");
		out.println("<th>Week</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println(rset.getString(1));
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	} else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGWEEK){
		out.println("<th>Test Type</th>");
		out.println("<th>Week</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGWEEK){
		out.println("<th>Patient</th>");
		out.println("<th>Test Type</th>");
		out.println("<th>Week</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(5)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGMONTH){
		out.println("<th>Patient</th>");
		out.println("<th>Month</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	} else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGMONTH){
		out.println("<th>Test Type</th>");
		out.println("<th>Month</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	} else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGMONTH){
		out.println("<th>Patient</th>");
		out.println("<th>Test Type</th>");
		out.println("<th>Month</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(5)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGYEAR){
		out.println("<th>Patient</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGYEAR){
		out.println("<th>Test Type</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGYEAR){
		out.println("<th>Patient</th>");
		out.println("<th>Test Type</th>");
		out.println("<th>Year</th>");
		out.println("<th>Number of Image</th>");
		while(rset!=null&&rset.next()){
			out.println("<tr>");
			out.println("<td>");
			out.println((rset.getString(1)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(2)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(3)).trim());
			out.println("</td>");
			out.println("<td>");
			out.println((rset.getString(4)).trim());
			out.println("</td>");
			out.println("</tr>");
		}
	}
	out.println("</table>");
	out.println("</div>");
} catch (Exception ex) {
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
JDBC.closeConnection();
%>
</body>
</html>