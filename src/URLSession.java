import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
   
/**
 * Demonstrates session management mechanisms
 * built into the Servlet API. A session is established
 * with the client and user is prompted to enter his/her name.
 * User's name along with the number of times he/she visited
 * the site is stored in the session. This sample uses
 * rewritten URLs for storing session information.
 *
 * NOTE: Cookie support must be turned off in the browser.
 * Refer to your browser documentation on how to turn off
 * cookies
 * From "Java Servlet Programming Bible"
 * Suresh Rajagopalan et al. John Wiley & Sons 2002.
 *
 */
   
public class URLSession extends HttpServlet {
    /**
     * Handles HTTP GET request
     */
    public void doGet( HttpServletRequest request, 
		       HttpServletResponse response )
	throws ServletException, IOException {
   
	String name = null;
	Integer hitCount = null;
   
	// Set the content type to HTML
	response.setContentType( "text/html" );
   
	// Get the output stream from the response object
	PrintWriter out = response.getWriter();
   
	// Get the session (Create a new one if required)
	HttpSession session = request.getSession( true );
   
	name = request.getParameter( "name" );
   
	// If session is new, this is the first request
	if( session.isNew() ) {
	    // Request information from user
	    out.println( "<HTML>" );
	    out.println( "<HEAD>" );
	    out.println( "<TITLE>User information</TITLE>" );
	    out.println( "</HEAD>" );
	    out.println( "<BODY>" );
	    out.println( "<FORM NAME=userform METHOD=post" +
                    " ACTION=" + 
			 response.encodeURL( "URLSession" ) + ">" );
	    out.print  ( "<BR>Please enter your name: " );
	    out.println( "<INPUT TYPE=text NAME=name>" );
	    out.println( "<BR><BR><INPUT TYPE=submit>" );
	    out.println( "</BODY>" );
	    out.println( "</HTML>" );
	} else {
	    // User has submitted the form
	    // Name will be available in the request,
	    // store it in the session
	    if( name != null ) {
		session.setAttribute( "name", name );
		// This is the first request
		hitCount = new Integer( 1 );
	    } else {
		name = (String) session.getAttribute( "name" );
		hitCount = (Integer) 
		    session.getAttribute( "hitCount" );
	    }
	    session.setAttribute( "hitCount", 
				  new Integer( hitCount.intValue() + 1 ) );
   
	    // Return the session information to the client
	    out.println( "<HTML>" );
	    out.println( "<HEAD>" );
	    out.println( "<TITLE>Hello " + name + "!</TITLE>" );
   
	    out.println( "</HEAD>" );
	    out.println( "<BODY>" );
	    out.println( "<H2>Hello " + name + "!</H2>" );
	    out.println( "You have requested this page " +
			 hitCount.intValue() + " time(s)!" );
	    out.println( "<BR><A HREF='" +
			 response.encodeURL( "URLSession" ) + 
			 "'>Click here to continue</A>" );
	    out.println( "</BODY>" );
	    out.println( "</HTML>" );
	}
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
	return "Servlet that stores user's name in the Session";
    }
}

