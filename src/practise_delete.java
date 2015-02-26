import java.util.*;
import java.sql.*;

public class practise_delete {

public static void main(String args[]) {

       String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       String m_driverName = "oracle.jdbc.driver.OracleDriver";

       String m_userName = "username";
       String m_password = "*****";

       Connection m_con;
       String createString;
       String queryString;
       String dropString;

	queryString = "select T_NAME, SUP_ID, PRICE, SALES, TOTAL  from  TOFFEES";
       Statement stmt;

       try
       {

              Class drvClass = Class.forName(m_driverName);
              DriverManager.registerDriver((Driver)
              drvClass.newInstance());

       } catch(Exception e)
       {

              System.err.print("ClassNotFoundException: ");
              System.err.println(e.getMessage());

       }

       try
       {

              m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);

              stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              ResultSet rset = stmt.executeQuery(queryString);


	      rset.absolute(1);
	      rset.deleteRow(); /* Keyword ***********/
              stmt.close();
              m_con.close();

       } catch(SQLException ex) {

              System.err.println("SQLException: " +
              ex.getMessage());

       }

}
}


