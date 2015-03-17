package db;

import java.util.Date;

public class RadiologyRecord implements Table {

	Integer recordId = null;
	Integer patientId = null;
	Integer doctor_id = null;
	Integer radiologistId = null;
	String testType = null;
	Date prescribingDate = null;
	Date testDate = null;
	String diagnosis = null;
	String description = null;
	Boolean isValid = null;
	
	@Override
	public boolean isValid() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String generateInsertSql() {
		// TODO Auto-generated method stub
		return null;
	}

}
