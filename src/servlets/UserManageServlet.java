package servlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import security.Bouncer;
import security.ModuleAccess;
import security.UserManageModuleAccess;

public abstract class UserManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected ModuleAccess moduleAccess;
	
	public UserManageServlet () {
		this.moduleAccess = new UserManageModuleAccess();
	}
	
	protected boolean verifyAccess(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Bouncer bouncer = new Bouncer(request, response, this.moduleAccess);
		return bouncer.verifyPage();
	}
}
