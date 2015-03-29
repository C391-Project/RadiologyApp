package security;

import java.util.List;

public abstract class ModuleAccess {
	
	// User type constants
	protected static String RADIOLOGIST_USER_TYPE = "r";
	protected static String DOCTOR_USER_TYPE = "d";
	protected static String PATIENT_USER_TYPE = "p";
	protected static String ADMIN_USER_TYPE = "a";
	
	List<String> allowedUserTypes;

	public boolean allows(String type) {
		return allowedUserTypes.contains(type);
	}
}
