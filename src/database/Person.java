package database;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

/**
 * Class for storing and working with information from a single row of the 
 * persons table of the database.
 * 
 * @author Brett Commandeur
 *
 */
public class Person implements TableRow {
	
	// Database columns
	Integer personId = null;
	String firstName = null;
	String lastName = null;
	String address = null;
	String email = null;
	String phone = null;
	
	boolean isValid = false;
	
	/**
	 * Constructor for generating a submittable person object from the request 
	 * of the add person form. 
	 * 
	 * @param personId	The personId of the person row to create.
	 * @param request	The request from the add person form.
	 */
	public Person (Integer personId, HttpServletRequest request) {
		try {
			this.personId = personId;
			this.firstName = request.getParameter("p_first_name");
			this.lastName = request.getParameter("p_last_name");
			this.address = request.getParameter("p_address");
			this.email = request.getParameter("p_email");
			this.phone = request.getParameter("p_phone");
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}
	}
	
	/**
	 * Constructor for generating a displayable person object from the 
	 * result set of the database query on the person table.
	 * 
	 * @param rs				The result set from which to retrieve the person information.
	 * @throws SQLException
	 */
	public Person (ResultSet rs) throws SQLException {
		personId = rs.getInt("PERSON_ID");
		firstName = rs.getString("FIRST_NAME");
		lastName = rs.getString("LAST_NAME");
		address = rs.getString("ADDRESS");
		email = rs.getString("EMAIL");
		phone = rs.getString("PHONE");
	}

	/**
	 * Checker of whether the object is ready for submission.
	 * 
	 * @return True if all required fields have information.
	 */
	@Override
	public boolean isValid() {
		if (personId != null 
				&& firstName != null
				&& lastName != null 
				&& address != null
				&& email != null 
				&& phone != null) {
			return true;
		}
		return isValid;
	}
	
	/** 
	 * Method for generating an SQL insert statement for the persons table. 
	 * 
	 * @return	String containing the insert statement.
	 */
	@Override
	public String generateInsertSql() {
		return "INSERT INTO persons VALUES (?,?,?,?,?,?)";
	}
	
	/**
	 * Method for generating an SQL update statement for the persons table.
	 * 
	 * @return  String containing the update statement.
	 */
	public String generateUpdateSql() {
		return "UPDATE persons"
				+ " SET first_name = ?,"
					+ " last_name = ?,"
					+ " address = ?,"
					+ " email = ?,"
					+ " phone = ?"
				+ "WHERE person_id = ?";
	}
	
	// Getter methods
	
	public int getPersonId() {
		return personId;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getAddress() {
		return address;
	}

	public String getEmail() {
		return email;
	}

	public String getPhone() {
		return phone;
	}
}
