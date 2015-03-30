package security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DataSource;

/**
 * Class to be used with servlets for verifying configuration before page access.
 * Primary functions include checking the datasource's connection to the database
 * and verifying the accessing user is logged in and has correct privileges.
 * Handles page redirects when page access conditions are not met. Analagous
 * to a bouncer at a club. 
 * 
 * @author Brett Commandeur
 *
 */
public class Bouncer {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private ModuleAccess moduleAccess = null;
	
	/**
	 * Constructor to configure the page-specific bouncer.
	 * 
	 * @param request		The http request for the page.
	 * @param response		The http response of the page.
	 * @param moduleAccess	The container of access privileges for the page.
	 */
	public Bouncer(HttpServletRequest request, HttpServletResponse response, ModuleAccess moduleAccess) {
		this.request = request;
		this.response = response;
		this.moduleAccess = moduleAccess;
	}
	
	/**
	 * Primary page configuration checking function.This method cares 
	 * about whether the datasource is connected and that the user has 
	 * correct privileges to access the page. 
	 * 
	 * @return				True if page is ready and accessible.
	 * @throws IOException
	 */
	public boolean verifyPage() throws IOException {
		return ( verifyDataSource() && verifyUserAccess() );
	}
	
	/**
	 * Method to check whether the datasource is properly configured
	 * and is ready to access the database. Redirects to oracle login
	 * page is the datasource is not configured.
	 * 
	 * @return				True if datasource is ready for access.
	 * @throws IOException
	 */
	private boolean verifyDataSource() throws IOException {
		DataSource ds = new DataSource();
		HttpSession session = request.getSession();
		
		if (ds.isNotConfigured()) {
			session.setAttribute("returnPage", generateReturnUrl());
			session.setAttribute("error", "Could not connect to database.");
			response.sendRedirect("/RadiologyApp/oracle-login");
			return false;
		}
		
		return true;
	}
	
	/**
	 * Method for verifying the accessing user has correct privileges
	 * for the page. Relies on the provided ModuleAccess object which contains
	 * the usertypes allowed by the type of page it is. Handles redirects
	 * to the login page if access is not allowed.
	 * 
	 * @return
	 * @throws IOException
	 */
	private boolean verifyUserAccess() throws IOException {
		HttpSession session = request.getSession();
		
		if (session.getAttribute("usertype") == null) {
			// Redirect to login page while remembering this page.
			session.setAttribute("returnPage", generateReturnUrl());
			session.setAttribute("error", "Access denied. Please log in.");
			response.sendRedirect("/RadiologyApp/login");
			return false;
		}
		
		String usertype = session.getAttribute("usertype").toString().trim();
		if (!moduleAccess.allows(usertype)) {
			// Redirect to login page while remembering this page.
			session.setAttribute("returnPage", generateReturnUrl());
			session.setAttribute("error", "Access denied. Not enough privilege.");
			response.sendRedirect("/RadiologyApp/login");
			return false;
		}	
		
		return true;
	}
	
	/**
	 * Method for generating a return url for use with a redirect to a login page.
	 * After login, the login modules can use this url to return the page the user
	 * tried to access. 
	 * 
	 * @return		The url of the accessed page.
	 */
	private String generateReturnUrl() {
		// Referenced from http://stackoverflow.com/questions/4040094/getting-request-url-in-a-servlet
		// User BalusC
		StringBuffer requestURL = request.getRequestURL();
		if (request.getQueryString() != null) {
		    requestURL.append("?").append(request.getQueryString());
		}
		String completeURL = requestURL.toString();
		// End Reference
		
		return completeURL;
	}
}
