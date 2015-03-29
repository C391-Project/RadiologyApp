package security;

import java.util.Arrays;

/**
 * Class used to contain and check the access information for a UserManage Module.
 * 
 * @author Brett Commandeur
 */
public class UserManageModuleAccess extends ModuleAccess { 
	
	/**
	 * Contstructor to set which users are allowed by this module type.
	 */
	public UserManageModuleAccess() {
		super();
		this.allowedUserTypes = Arrays.asList(ADMIN_USER_TYPE);
	}

}
