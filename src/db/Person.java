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
	
	public Person (HttpServletRequest request) {
		try {
			personId = Integer.parseInt(request.getParameter("p_person_id"));
			firstName = request.getParameter("p_first_name");
			lastName = request.getParameter("p_last_name");
			address = request.getParameter("p_address");
			email = request.getParameter("p_email");
			phone = request.getParameter("p_phone");
		} catch (NullPointerException e) {
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
				&& phone != null 
				&& email != null) {
			return true;
		}
		return isValid;
	}
	
	@Override
	public String generateInsertSql() {
		return "INSERT INTO PERSONS VALUES (?,?,?,?,?,?)";
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
