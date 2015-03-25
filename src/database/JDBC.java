package database;
/**
 * Singleton for connecting to a database through JDBC
 * 
 * @author Maks (original)
 * @author Brett Commandeur (modified by)
 * @source https://github.com/MaksJS/jdbc-singleton/blob/master/JDBC.java
 **/

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC {
    
    private static Connection connection = null;
    private static String username = null;
    private static String password = null;
	private static Boolean connectingFromLab = null;
    private final static String REMOTE_URL = "jdbc:oracle:thin:@localhost:1525:CRS"; // Work from Home
    private final static String LAB_URL = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; // Lab Machines		
    private final static String DRIVER   = "oracle.jdbc.driver.OracleDriver";
	private static final int LOGIN_TIMEOUT = 3;
    
    /**
     * Method that loads the specified driver
     * 
     * @return void
     **/
    
    private static void loadDriver() {
        try {
            Class drvClass = Class.forName(DRIVER);
			DriverManager.registerDriver((Driver)drvClass.newInstance());
        }
        catch (Exception e) {
            errorHandler("Failed to load the driver " + DRIVER, e);
        }
    }

    /**
     * Method that loads the connection into the right property
     * 
     * @return void
     **/
    
    private static void loadConnection() {
    	if (username == null || password == null || connectingFromLab == null) {
    		errorHandler("Please configure username, password, connecting from lab", null);
    	} else {
    		String url = (connectingFromLab) ? LAB_URL : REMOTE_URL;
    		DriverManager.setLoginTimeout(LOGIN_TIMEOUT);
	        try {
	            connection = DriverManager.getConnection(url, username, password);
	        }
	        catch (SQLException e) {
	            errorHandler("Failed to connect to the database " + url, e);         
	        }
    	}
    }
    
    /**
     * Method that shows the errors thrown by the singleton
     * 
     * @param  {String}    Message
     * @option {Exception} e
     * @return  void
     **/
    
    private static void errorHandler(String message, Exception e) {
        System.out.println(message);  
        if (e != null) System.out.println(e.getMessage());   
    }
    
    /**
     * Method that sets the user and password for the connection
     * 
     * @param newUser
     * @param newPassword
     * @return void
     */
    public static void configure(String newUsername, String newPassword, boolean isConnectingFromLab) {
    	username = newUsername;
    	password = newPassword;
    	connectingFromLab  = isConnectingFromLab;
    }
    
    /***
     * Method that checks whether db info has been set.
     * 
     * @return	Whether the necessary db info is configured.
     */
    public static boolean isConfigured() {
    	return (username != null 
    			&& password != null
    			&& connectingFromLab != null);
    }
    
    /**
     * Static method that returns the instance for the singleton
     * 
     * @return {Connection} connection
     **/
    
    public static Connection connect() {
        if (connection == null) {
            loadDriver();
            loadConnection();
        }
        return connection;
    }
    
    /**
     * Static method that close the connection to the database
     * 
     * @return void
     **/
    
    public static void closeConnection() {
        if (connection == null) {
            errorHandler("No connection found", null);
        }
        else {
            try {
                connection.close();
                connection = null;
            }
            catch (SQLException e) {
                errorHandler("Failed to close the connection", e);
            }
        }
    }
    
    /**
     * Method to execute a given SQL update on the connection
     * 
     * @param sql
     * @return void
     **/

	public static boolean hasConnection() {
		boolean valid = false;
		if (connection != null) {
			valid = true;
		}
		return valid;
	}
}