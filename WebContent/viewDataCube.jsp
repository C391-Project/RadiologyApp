<% String pageName = "dataanalysis"; %>
<%@ page import="java.sql.*, java.util.ArrayList, database.JDBC"%>
<%!
%><form name="Back" action="data-analysis.jsp" method="post" role="form">
<link href="/RadiologyApp/includes/style.css" rel="stylesheet">
<%
	//The purpose of this file is to view the 
	//datacube we created in data-analysis.jsp

	//Variable declaration and static flag values
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
	//Get these from the previous page
	String patient = request.getParameter("PATIENTID").trim();
	String testType = request.getParameter("TESTTYPE").trim();
	String timeStyle = request.getParameter("TIME").trim();
	String year = request.getParameter("YEAR").trim();

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
		//Need to update our flags depending on what the user chose
		if (IDANDRECORDFLAG == FLAGPATIENTID) {
			IDANDRECORDFLAG = FLAGPATIENTANDRECORD;
		} else { IDANDRECORDFLAG = FLAGRECORD; }
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
		if(testType.equals("ALL")){	sql += ",TEST_TYPE";}
	}
	
	sql += " WHERE ";
	
	//If the user selected a patient add it to our sql querry 
	if(!patient.equals("NONE")){
		sql += "p.person_id = p2.PATIENT_ID AND p2.PATIENT_ID = PATIENT_NUM_IMAGE_TABLE.PATIENT_ID AND ";
		if(!patient.equals("ALL")){	sql += "p2.PATIENT_ID = " + patient + " AND "; }
	}
	//similarly for test type
	if(!testType.equals("NONE")){
		if(testType.equals("ALL")){	sql += "TEST_TYPE.TEST_TYPE = PATIENT_NUM_IMAGE_TABLE.TEST_TYPE AND ";
		}else{	sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE = '" + testType + "' AND "; }
	}
	//add the year to te query 
	if(!year.equals("ALL")){ sql += "TIME_ID.YEAR =" + year + " AND ";	}
	
	sql += "TIME_ID.TIME_ID =PATIENT_NUM_IMAGE_TABLE.TIME_ID ";
	sql += "GROUP BY ";
	
	//More SQL based on the parameters the user chose
	if(!patient.equals("NONE")) { sql += "CONCAT(p.first_name, CONCAT(' ', p.last_name)),";	}
	if(!testType.equals("NONE")) {
		if(testType.equals("ALL")){	sql += "TEST_TYPE.TEST_TYPE,";
		}else{	sql += "PATIENT_NUM_IMAGE_TABLE.TEST_TYPE,"; }
	}
	if(timeStyle.equals("WEEK")){ sql = sql + "week,"; }
	else if(timeStyle.equals("MONTH")){ sql = sql + " month,";	}
	
	sql = sql + "year ORDER BY ";
	
	if(TIMEFLAG == FLAGWEEK){ sql = sql + "year,week ";
	} else if (TIMEFLAG == FLAGMONTH){ sql = sql + "year,month "; 
	} else{ sql = sql + "year "; }
	
%>
<h2 id="results">RESULTS</h2>
<%

//Do the SQL statement and then print out the results
try {
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
	if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGWEEK){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Week</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next()) {
			%>
				<tr>
			<%
			String name = rset.getString(1);
			String Week = rset.getString(2);
			String Year = rset.getString(3);
			String Num = rset.getString(4);
			if (name.equals(null) || Week.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %></td>
				<td><%= Week %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	} else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGWEEK) {
		%>
		<table>
		<thead>
			<tr>
				<th>Test Type</th>
				<th>Week</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!= null && rset.next() ) {
			%>
				<tr>
			<%
			String testtype = rset.getString(1);
			String Week = rset.getString(2);
			String Year = rset.getString(3);
			String Num = rset.getString(4);
			if (testtype.equals(null) || Week.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= testtype %></td>
				<td><%= Week %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%

		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGWEEK){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Test Type</th>
				<th>Week</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ){
			String name = rset.getString(1);
			String testtype = rset.getString(2);
			String Week = rset.getString(3);
			String Year = rset.getString(4);
			String Num = rset.getString(5);
			
			if (name.equals(null) || testtype.equals(null) || Week.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %></td>
				<td><%= testtype %></td>
				<td><%= Week %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGMONTH){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Month</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ) {
			String name = rset.getString(1);
			String Month = rset.getString(2);
			String Year = rset.getString(3);
			String Num = rset.getString(4);
			
			if (name.equals(null) ||  Month.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %></td>
				<td><%= Month %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	} else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGMONTH){
		%>
		<table>
		<thead>
			<tr>
				<th>Test Type</th>
				<th>Month</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ){
			while(rset!=null && rset.next() ) {
				String testtype = rset.getString(1);
				String Month = rset.getString(2);
				String Year = rset.getString(3);
				String Num = rset.getString(4);
				
				if (testtype.equals(null) ||  Month.equals(null) || Year.equals(null) || Num.equals(null)) {
					break; 
				}
				%>
					<td><%= testtype %></td>
					<td><%= Month %></td>
					<td><%= Year %></td>
					<td><%= Num %></td>
					</tr>
					
				<%
			}
		}
	} else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGMONTH){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Test Type</th>
				<th>Month</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ){
			String name = rset.getString(1);
			String testtype = rset.getString(2);
			String Month = rset.getString(3);
			String Year = rset.getString(4);
			String Num = rset.getString(5);
			
			if (name.equals(null) || testtype.equals(null) ||  Month.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %></td>
				<td><%= testtype %></td>
				<td><%= Month %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTID && TIMEFLAG == FLAGYEAR){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ){
			String name = rset.getString(1);
			String Year = rset.getString(2);
			String Num = rset.getString(3);
			
			if (name.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	}else if(IDANDRECORDFLAG == FLAGRECORD && TIMEFLAG == FLAGYEAR){
		%>
		<table>
		<thead>
			<tr>
				<th>Test Type</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next() ){
			String testtype = rset.getString(1);
			String Year = rset.getString(2);
			String Num = rset.getString(3);
			
			if (testtype.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= testtype %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	}else if(IDANDRECORDFLAG == FLAGPATIENTANDRECORD && TIMEFLAG == FLAGYEAR){
		%>
		<table>
		<thead>
			<tr>
				<th>Patient</th>
				<th>Test Type</th>
				<th>Year</th>
				<th>Number of Images</th>
			</tr>
		</thead>
		<tbody>
		<%
		while(rset!=null && rset.next()) {
			String name = rset.getString(1);
			String testtype = rset.getString(2);
			String Year = rset.getString(3);
			String Num = rset.getString(4);
			
			if (name.equals(null) || testtype.equals(null) || Year.equals(null) || Num.equals(null)) {
				break; 
			}
			%>
				<td><%= name %> </td>
				<td><%= testtype %></td>
				<td><%= Year %></td>
				<td><%= Num %></td>
				</tr>
				
			<%
		}
	}	
} catch (Exception ex) {
	//out.println("<hr>" + ex.getMessage() + "<hr>");
}
JDBC.closeConnection();
%>
</tbody>
</table>
<br>
<br>
<button type="Go Back" name="Back">GO BACK</button>
</body>
</html>