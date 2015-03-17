package db;

public class FamilyDoctor implements Table {

	Integer doctorId = null;
	Integer patientId = null;
	Boolean isValid = null;
	//Done
	
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
