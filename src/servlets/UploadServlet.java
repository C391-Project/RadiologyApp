package servlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import security.Bouncer;
import security.ModuleAccess;
import security.UploadModuleAccess;

public abstract class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// Container for user access privilege information.
	protected ModuleAccess moduleAccess;
	
	/**
	 * Constructor method.
	 */
	public UploadServlet () {
		// Set the servet's access priveleges. 
		this.moduleAccess = new UploadModuleAccess();
	}
	
	/**
	 * Method to be used at the beginning of each get/post method. Relies
	 * on the Bouncer class of the security module to verify the page's 
	 * database connection and user access priveleges. 
	 * 
	 * @param request		The http request of the accessed page.
	 * @param response		The http response of the accessed page.
	 * @return				True if page is ready for access.
	 * @throws IOException
	 */
	protected boolean verifyAccess(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Bouncer bouncer = new Bouncer(request, response, this.moduleAccess);
		return bouncer.verifyPage();
	}
}
