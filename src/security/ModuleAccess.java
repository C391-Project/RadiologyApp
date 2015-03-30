package security;

import java.util.List;

public abstract class ModuleAccess {
	
	// User type constants
	protected static String RADIOLOGIST_USER_TYPE = "r";
	protected static String DOCTOR_USER_TYPE = "d";
	protected static String PATIENT_USER_TYPE = "p";
	protected static String ADMIN_USER_TYPE = "a";
	
	// To be set by subclass.
	List<String> allowedUserTypes;

	/**
	 * Method to implemented by subclasses for determining
	 * if the accessing usertype matches the usertypes allowed by this
	 * this type of module.
	 * 
	 * @param type		The accessing user type
	 * @return			True if the accessing user type is allowed by the module type.
	 */
	
	public boolean allows(String type) {
		return allowedUserTypes.contains(type);
	}
}
