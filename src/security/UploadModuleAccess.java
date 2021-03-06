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
		// Upload modules allow radiologists only.
		this.allowedUserTypes = Arrays.asList(RADIOLOGIST_USER_TYPE, ADMIN_USER_TYPE);
	}

}
