package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

public class User implements Table {
	
	// TODO Test

	String userName = null;
	String password = null;
	String userClass = null;
	Integer personId = null;
	Date dateRegistered = null;
	boolean isValid = false;
	
	public User (HttpServletRequest request) {
		try {
			userName = request.getParameter("u_user_name");
			password = request.getParameter("u_password");
			userClass = request.getParameter("u_class");
			personId = Integer.parseInt(request.getParameter("u_person_id"));
			
			if (request.getParameter("u_date_registered") != null) {
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				dateRegistered = format.parse(request.getParameter("u_date_registered"));
			} else {
				dateRegistered = new Date();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}
	}
	
	public User (ResultSet rs) throws SQLException {
		userName = rs.getString("USER_NAME");
		password = rs.getString("PASSWORD");
		userClass = rs.getString("CLASS");
		personId = rs.getInt("PERSON_ID");
		dateRegistered = rs.getDate("DATE_REGISTERED");
	}
	
	@Override
	public boolean isValid() {
		if (userName != null 
				&& password != null
				&& userClass != null
				&& personId != null
				&& dateRegistered != null) {
			return true;
		}
		return isValid;
	}

	@Override
	public String generateInsertSql() {
		return "INSERT INTO USERS VALUES (?,?,?,?,?)";
	}
	
	@Override
	public String generateUpdateSql(){
		return "UPDATE users"
				+ " SET user_name = ?,"
					+ " password = ?,"
					+ " class = ?,"
					+ " person_id = ?,"
					+ " date_registered = ?"
				+ "WHERE user_name = ?";
	}

	public String getUserName() {
		return userName;
	}

	public String getPassword() {
		return password;
	}

	public String getUserClass() {
		return userClass;
	}

	public Integer getPersonId() {
		return personId;
	}

	public Date getDateRegistered() {
		return dateRegistered;
	}
}
