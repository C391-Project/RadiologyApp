package servlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import security.Bouncer;
import security.ModuleAccess;
import security.UploadModuleAccess;
import security.UserManageModuleAccess;

public abstract class UploadServlet extends HttpServlet {
	
	protected ModuleAccess moduleAccess;
	
	public UploadServlet () {
		this.moduleAccess = new UploadModuleAccess();
	}
	
	protected boolean verifyAccess(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Bouncer bouncer = new Bouncer(request, response, this.moduleAccess);
		return bouncer.verifyPage();
	}
}
