package servlets.usermanage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import security.Bouncer;
import servlets.UserManageServlet;
import database.DataSource;
import database.FamilyDoctor;
import database.JDBC;
import database.Person;

/**
 * Servlet implementation class FamilyDoctorsEdit
 */
public class FamilyDoctorsEdit extends UserManageServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FamilyDoctorsEdit() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
		
		Integer doctorId = Integer.parseInt(request.getParameter("d-id"));
		Integer patientId = Integer.parseInt(request.getParameter("p-id"));
		
		DataSource dataSource = new DataSource();
		FamilyDoctor fd = dataSource.getFamilyDoctorByIds(doctorId, patientId);
		
		request.setAttribute("family-doctor", fd);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/family-doctors-edit.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and DB Connection
		if (!verifyAccess(request, response)) return;
	}
			
			

}
