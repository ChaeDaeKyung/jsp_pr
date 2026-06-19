package day0612;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GetConn {

	public Connection getCon() throws SQLException {
		Connection con = null;
		try {
			//1. JNDI사용 객체 생성.
			Context ctx=new InitialContext();
			//2. tomcat에 DBCP에서 dataSource를 얻는다.
			DataSource ds=(DataSource) ctx.lookup("java:comp/env/jdbc/dbcp");
			//3. DataSource에서 connection을 얻는다.
			con=ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}//end try catch
		
		
		
		return con;
	}// end getCon
	
}// class
