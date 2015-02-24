import java.util.*;
import java.sql.*;

public class practise_update {

public static void main(String args[]) {

       String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       String m_driverName = "oracle.jdbc.driver.OracleDriver";

       String m_userName = "username";
       String m_password = "passwd";

       Connection m_con;
       String createString;
       String queryString;
       String insertString1;
       String insertString2;
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
	      rset.updateString(1,"TRIADBURY");
	      rset.updateInt(2,1000);
	      rset.updateDouble(3,9.00);
	      rset.updateInt(4,999);
	      rset.updateInt(5 ,66);

	      rset.updateRow(); /******** Keyword ***********/

              ResultSet rset1 = stmt.executeQuery(queryString);



	      while(rset1.next())
 	      {
     		System.out.println(rset1.getString(1) + "   " +
          	rset1.getInt(2) + "   " +
          	rset1.getDouble(3) + "   " +
          	rset1.getInt(4) + "  " +
          	rset1.getInt(5));
 	      }

              stmt.close();
              m_con.close();

       } catch(SQLException ex) {

              System.err.println("SQLException: " +
              ex.getMessage());

       }

}
}


