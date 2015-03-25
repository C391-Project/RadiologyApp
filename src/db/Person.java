package db;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class Person implements Table {
	
	// Done
	
	Integer personId = null;
	String firstName = null;
	String lastName = null;
	String address = null;
	String email = null;
	String phone = null;
	boolean isValid = false;
	
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
	
	public Person (ResultSet rs) throws SQLException {
		personId = rs.getInt("PERSON_ID");
		firstName = rs.getString("FIRST_NAME");
		lastName = rs.getString("LAST_NAME");
		address = rs.getString("ADDRESS");
		email = rs.getString("EMAIL");
		phone = rs.getString("PHONE");
	}

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
	
	@Override
	public String generateInsertSql() {
		return "INSERT INTO persons VALUES (?,?,?,?,?,?)";
	}
	
	public String generateUpdateSql() {
		return "UPDATE persons"
				+ " SET first_name = ?,"
					+ " last_name = ?,"
					+ " address = ?,"
					+ " email = ?,"
					+ " phone = ?"
				+ "WHERE person_id = ?";
	}
	
	public String generateDeleteSql() {
		return "DELETE FROM persons"
				+ "WHERE person_id = ?";
	}
	
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
