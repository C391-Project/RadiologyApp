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
import database.DataSource;
import database.FamilyDoctor;
import database.JDBC;
import database.Person;

/**
 * Servlet implementation class FamilyDoctor
 */
public class FamilyDoctors extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource dataSource = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FamilyDoctors() {
        super();
        this.dataSource = new DataSource();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check Security and Verify Database
		Bouncer sm = new Bouncer(request, response);
		if (!sm.verifyPage()) return;
		
		
		List<FamilyDoctor> fdList = dataSource.getFamilyDoctorList();
		request.setAttribute("fdList", fdList);
		RequestDispatcher view = request.getRequestDispatcher("/UserManage/family-doctors.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Check Security and Database Connection
		Bouncer sm = new Bouncer(request, response);
		if (!sm.verifyPage()) return;
		
		HttpSession session = request.getSession();
		
		// Add Family Doctor
		boolean isFamilyDoctorSubmit = (request.getParameter("family_doctor_submit") != null);
		if (isFamilyDoctorSubmit) {
			FamilyDoctor fdToSubmit = new FamilyDoctor(request);
			if (fdToSubmit.isValid()) {
				dataSource.submitFamilyDoctor(fdToSubmit);
			} else {
				session.setAttribute("error", "Family Doctor Information Not Valid");
			}
		}
		
		// Edit Family Doctor
		boolean isFamilyDoctorEdit = (request.getParameter("family_doctor_edit") != null);
		if (isFamilyDoctorEdit) {
			Integer originalDoctorId = Integer.parseInt(request.getParameter("f_original_doctor_id"));
			Integer originalPatientId = Integer.parseInt(request.getParameter("f_original_patient_id"));
			FamilyDoctor fdToEdit = new FamilyDoctor(request);
			if (fdToEdit.isValid()) {
				dataSource.updateFamilyDoctor(originalDoctorId, originalPatientId, fdToEdit);
			} else {
				session.setAttribute("error", "Family Doctor Information Not Valid");
			}
		}
		
		// Delete Family Doctor
		boolean isFamilyDoctorDelete = (request.getParameter("family_doctor_delete") != null);
		if (isFamilyDoctorDelete) {
			Integer doctorId = Integer.parseInt(request.getParameter("f_doctor_id"));
			Integer patientId = Integer.parseInt(request.getParameter("f_patient_id"));
			dataSource.deleteFamilyDoctor(doctorId, patientId);
		}
		
		// Submit a GET request to this servlet to view results.
		response.sendRedirect("/RadiologyApp/usermanage/family-doctors");
	}
			
			

}
