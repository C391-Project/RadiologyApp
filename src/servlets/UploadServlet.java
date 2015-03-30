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
	
	protected ModuleAccess moduleAccess;
	
	public UploadServlet () {
		this.moduleAccess = new UploadModuleAccess();
	}
	
	protected boolean verifyAccess(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Bouncer bouncer = new Bouncer(request, response, this.moduleAccess);
		return bouncer.verifyPage();
	}
}
