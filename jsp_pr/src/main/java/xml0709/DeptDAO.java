package xml0709;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.GetConnection;

public class DeptDAO {
	private static DeptDAO dDAO;
	private DeptDAO() { }//DeptDAO
	
	public static DeptDAO getInstance() {
		if(dDAO == null) {
			dDAO = new DeptDAO();
		}
		return dDAO;
	}// getInstance
	
	public List<DeptDTO> selectAllDept() throws SQLException{
		List<DeptDTO> list = new ArrayList<DeptDTO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			String selectAlldept = "select deptno, dname, loc from dept";
			con = gc.getConn("dbcp");
			
			pstmt= con.prepareStatement(selectAlldept);
			
			rs = pstmt.executeQuery();
			
			DeptDTO dDTO = null;
			while (rs.next()) {
				dDTO = new DeptDTO(rs.getInt("deptno"),rs.getString("dname"), rs.getString("loc"));
				list.add(dDTO);
			}//end while
			
		}finally {
			gc.dbClose(rs, pstmt, con);
		}// end try finally
		
		return list;
	}// selectAllDept
	
}// class
