import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
   
/**
 * Demonstrates session management mechanisms built
 * into the Servlet API. 
 * From "Java Servlet Programming Bible"
 * Suresh Rajagopalan et al. John Wiley & Sons 2002.
 */
   
public class SessionInfo extends HttpServlet {
    /**
     * Handles HTTP GET request
     */
    public void doGet( HttpServletRequest request,
		       HttpServletResponse response )
	throws ServletException, IOException {
   
	// Set the content type to HTML
	response.setContentType( "text/html" );
   
	// Get the output stream from the response object
	PrintWriter out = response.getWriter();
   
	// Get the session (Create a new one if required)
	HttpSession session = request.getSession( true );
   
	// Return the session information to the client
	out.println( "<HTML>" );
	out.println( "<HEAD>" );
	out.println( "<TITLE>Session info servlet</TITLE>" );
	out.println( "</HEAD>" );
	out.println( "<BODY>" );
	out.println( "<H3>Session Information</H3>" );
	out.println( "New Session: " + session.isNew() );
	out.println( "<BR>Session ID: " + session.getId() );
	out.println( "<BR>Creation Time: " +
   
		     session.getCreationTime() );
	out.println( "<BR>Last Accessed Time: " +
		     session.getLastAccessedTime() );
	out.println( "<BR>Max. Inactive Interval: " +
		     session.getMaxInactiveInterval() );
   
	out.println( "<H3>Request Information</H3>" );
	out.println( "Session ID from Request: " + 
		     request.getRequestedSessionId() );
	out.println( "<BR>Session using cookie: " + 
		     request.isRequestedSessionIdFromCookie() );
	out.println( "<BR>Session using rewritten URL: " + 
		     request.isRequestedSessionIdFromURL() );
	out.println( "<BR>Sessin is VALID: " +
		     request.isRequestedSessionIdValid() );
          
	out.println( "</BODY>" );
	out.println( "</HTML>" );
   
	// Flush the output stream
	out.flush();
   
	// Close the output stream
	out.close();
    }
   
    /**
     * Handles HTTP POST request
     */
    public void doPost( HttpServletRequest request,
			HttpServletResponse response )
	throws ServletException, IOException {
	// Invoke doGet to process this request
	doGet( request, response );
    }
   
    /**
     * Returns a brief description about this servlet
     */
    public String getServletInfo() {
	return "Servlet that returns Session information";
    }
}

