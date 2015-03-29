package security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DataSource;

public class Bouncer {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	
	public Bouncer(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	public boolean verifyPage() throws IOException {
		return ( verifyDataSource() && verifyUserAccess() );
	}
	
	public boolean verifyDataSource() throws IOException {
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
	
	public boolean verifyUserAccess() throws IOException {
		//Should use security module.
		
		HttpSession session = request.getSession();
		if(session.getAttribute("usertype")==null)
		{
			session.setAttribute("returnPage", generateReturnUrl());
			session.setAttribute("error", "Please login first.");
			response.sendRedirect("login.jsp");
			return false;
		}
		String usertype = session.getAttribute("usertype").toString().trim();
		
		//only allow admin to access
		if(!usertype.equals("a"))
		{
			session.setAttribute("returnPage", generateReturnUrl());
			session.setAttribute("error", "Access denied. Not enought privilege.");
			response.sendRedirect("login.jsp");
			return false;
		}
		
		
		return true;
	}
	
	public String generateReturnUrl() {
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
