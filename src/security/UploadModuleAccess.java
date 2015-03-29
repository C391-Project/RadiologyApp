package security;

import java.util.Arrays;

/**
 * Class used to contain and check the access information for an Upload Module.
 * 
 * @author Brett Commandeur
 */
public class UploadModuleAccess extends ModuleAccess { 
	
	/**
	 * Contstructor to set which users are allowed by this module type.
	 */
	public UploadModuleAccess() {
		super();
		this.allowedUserTypes = Arrays.asList(RADIOLOGIST_USER_TYPE);
	}

}
