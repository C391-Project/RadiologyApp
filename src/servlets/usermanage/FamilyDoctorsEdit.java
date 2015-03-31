package servlets.usermanage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import servlets.UserManageServlet;
import database.DataSource;
import database.FamilyDoctor;

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
		
		// Get doctor id and patient id from the request
		Integer doctorId = Integer.parseInt(request.getParameter("d-id"));
		Integer patientId = Integer.parseInt(request.getParameter("p-id"));
		
		// Get the family doctor record from the database
		DataSource dataSource = new DataSource();
		FamilyDoctor fd = dataSource.getFamilyDoctorByIds(doctorId, patientId);
		
		// Render page with information from family doctor record
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
