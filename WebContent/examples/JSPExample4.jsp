	<HTML> 
  	  <BODY> 
          <%  
               // This scriptlet declares and initializes "date"  
               java.util.Date date = new java.util.Date(); 
          %> 
          Hello!  The time is now 
          <%  
              // This scriptlet generates HTML output  
              out.println( String.valueOf( date )); 
          %> 
      </BODY> 
    </HTML> 
