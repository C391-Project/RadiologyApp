	  <%@ page import="java.util.*" %> 
	  <HTML> 
	       <BODY> 
		   <%!  
		        Date theDate = new Date();  
		        Date getDate()  {
			System.out.println( "In getDate() method" );  
			return theDate;  
		         } 
		   %> 
		   Hello!  The time is now <%= getDate() %> 
		</BODY> 
	 </HTML> 
