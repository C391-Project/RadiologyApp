package utilities;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DataSource;

public class StateManager {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	
	public StateManager(HttpServletRequest request, HttpServletResponse response) {
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
			response.sendRedirect("oracle-login");
			return false;
		}
		
		return true;
	}
	
	public boolean verifyUserAccess() {
		//Should use security module.
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
