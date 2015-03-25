package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class FamilyDoctor implements Table {

	Integer doctorId = null;
	Integer patientId = null;
	Boolean isValid = null;
	
	public FamilyDoctor (HttpServletRequest request) {
		try {
			doctorId = Integer.parseInt(request.getParameter("f_doctor_id"));
			patientId = Integer.parseInt(request.getParameter("f_patient_id"));
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}
	}
	
	public FamilyDoctor (ResultSet rs) throws SQLException {
		doctorId = rs.getInt("DOCTOR_ID");
		patientId = rs.getInt("PATIENT_ID");
	}
	
	
	@Override
	public boolean isValid() {
		if (doctorId != null 
				&& patientId != null) {
			return true;
		}
		return isValid;
	}

	@Override
	public String generateInsertSql() {
		return "INSERT INTO FAMILY_DOCTOR VALUES (?,?)";
	}

	public Integer getDoctorId() {
		return doctorId;
	}

	public Integer getPatientId() {
		return patientId;
	}

	//TEMP DELETE THIS
	@Override
	public String generateUpdateSql() {
		// TODO Auto-generated method stub
		return null;
	}

}
