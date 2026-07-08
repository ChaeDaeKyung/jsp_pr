package kr.co.sist.board;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.GetConnection;

public class BoardDAO {
	private static BoardDAO bDAO;

	private BoardDAO() {
	}

	public static BoardDAO getInstance() {
		if (bDAO == null) {
			bDAO = new BoardDAO();
		}

		return bDAO;
	}

	public int selectTotalCount(RangeDTO rDTO) throws SQLException {
		int totalCount = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		GetConnection gc = GetConnection.getInstance();

		try {
			con = gc.getConn("dbcp");

			StringBuilder selectSql = new StringBuilder();
			selectSql //
					.append("	select count(*) cnt	")
					.append("	from board			");
			if(rDTO.getKeyword()!= null && !rDTO.getKeyword().isEmpty()) {
				//검색 키워드가 있을 때 쿼리문이 변경d(ynamic Query에 생성기준)
				//selectSql.append("	where ").append(rDTO.getKeyword()).append(" like '%'||?||'%'");
				selectSql.append("	where instr('").append(rDTO.getKeyword()).append("', ?) != 0");
			}
			
			pstmt = con.prepareStatement(selectSql.toString());
			if(rDTO.getKeyword()!= null && !rDTO.getKeyword().isEmpty()) {
				pstmt.setString(1,rDTO.getKeyword());
				
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("cnt");
			}

		} finally {
			gc.dbClose(rs, pstmt, con);
		}

		return totalCount;
	}
	
	public List<BoardDTO> selectBoard(RangeDTO rDTO) throws SQLException {
		
		List<BoardDTO> boardList = new ArrayList<BoardDTO>(); 
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder selectBoard = new StringBuilder();
			selectBoard //
					/*
					 * .append("	select b.*	") // .append("	from (select rownum rn, a.*	")
					 * .append("			from (select * from board	")
					 * .append("					order by input_date desc) a) b	")
					 * .append("	where rn between ? and ?	");
					 */
			
			.append("	select num, id, title, input_date, cnt, upfile		")
			.append("	from (select NUM, ID, TITLE, INPUT_DATE, CNT,upfile, row_number() over(order by input_date desc ) rnum		")
			.append("		from board 		");
			
			if(rDTO.getKeyword()!= null && !rDTO.getKeyword().isEmpty()) {
				selectBoard
					.append("	where instr(		")
					.append(rDTO.getField())
					.append(", ?) != 0		");
				
			}
			
			selectBoard.append("	) where rnum between ? and ?		");
			
			pstmt = con.prepareStatement(selectBoard.toString());
			//System.out.println(selectBoard);
			int bindInd = 0;
			if(rDTO.getKeyword()!= null && !rDTO.getKeyword().isEmpty()) {
				pstmt.setString(++bindInd, rDTO.getKeyword());
			} 
			pstmt.setInt(++bindInd, rDTO.getStartNum());
			pstmt.setInt(++bindInd, rDTO.getEndNum());
			
			rs = pstmt.executeQuery();
			
			BoardDTO bDTO = null;
			while (rs.next()) {
				bDTO = new BoardDTO();
				
				bDTO.setNum(rs.getInt("num"));
				bDTO.setId(rs.getString("id"));
				bDTO.setTitle(rs.getString("title"));
				bDTO.setInputDate(rs.getDate("input_date"));
				bDTO.setCnt(rs.getInt("cnt"));
				bDTO.setUpfile(rs.getString("upfile"));
				boardList.add(bDTO);
			}// end while
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		}
		
		return boardList;
	}
	
	public void insertBoard(BoardDTO bDTO) throws SQLException {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder insertBoard = new StringBuilder();
			boolean flag = bDTO.getUpfile() != null;
			insertBoard //
			.append("	insert into board( num, id, title, content, ip");
			if(flag) {
				insertBoard
				.append("	, upfile		");
			}
			insertBoard
			.append("	)		");
			
			insertBoard
			.append("	values	( seq_board.nextval,?,?,?,?");
			if(flag) {
				insertBoard
				.append(",?");
			}
			insertBoard
			.append(")");
			pstmt = con.prepareStatement(insertBoard.toString());
			
			pstmt.setString(1, bDTO.getId());
			pstmt.setString(2, bDTO.getTitle());
			pstmt.setString(3, bDTO.getContent());
			pstmt.setString(4, bDTO.getIp());
			
			if(flag) {
				pstmt.setString(5, bDTO.getUpfile());
			}
			
			pstmt.executeUpdate();

		} finally {
			gc.dbClose(null, pstmt, con);
		}// try catch
	}//insertBoard
	
public BoardDTO selectBoardDetail(int num) throws SQLException {
		
		BoardDTO bDTO = null; 
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder selectBoard = new StringBuilder();
			selectBoard //
					/*
					 * .append("	select b.*	") // .append("	from (select rownum rn, a.*	")
					 * .append("			from (select * from board	")
					 * .append("					order by input_date desc) a) b	")
					 * .append("	where rn between ? and ?	");
					 */
			
			.append("	select id, title, content,ip,input_date, cnt		")
			.append("	from board 		")
			.append("	where num = ?		");
			
			pstmt = con.prepareStatement(selectBoard.toString());
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bDTO = new BoardDTO();
				
				bDTO.setNum(num);
				bDTO.setId(rs.getString("id"));
				bDTO.setTitle(rs.getString("title"));
				bDTO.setIp(rs.getString("ip"));
				bDTO.setInputDate(rs.getDate("input_date"));
				bDTO.setCnt(rs.getInt("cnt"));
				
				Clob clob = rs.getClob("content");
				StringBuilder content = new StringBuilder(); 
				if(clob != null) {
					//Reader reader = clob.getCharacterStream();
					BufferedReader br = new BufferedReader(clob.getCharacterStream());
					try {
						String temp="";
						while((temp=br.readLine()) != null) {
							content.append(temp).append("\n");
						}
						if(br!=null) {
							br.close();
						}
					} catch(IOException ie) {
						ie.printStackTrace();
					}// end try catch
					
				}// end if
				bDTO.setContent(content.toString());
			}// end while
			
		} finally {
			gc.dbClose(rs, pstmt, con);
		}
		
		return bDTO;
	}
	

	public void updateCnt(int num) throws SQLException {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder insertBoard = new StringBuilder();
			
			insertBoard //
			.append("	update board		")
			.append("	set	cnt = cnt + 1		")
			.append("	where num=?		");
			
			pstmt = con.prepareStatement(insertBoard.toString());
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
	
		} finally {
			gc.dbClose(null, pstmt, con);
		}// try catch
		
	}//insertBoard
		
	public int updateBoard(BoardDTO bDTO) throws SQLException {
		int cnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder updateBoard = new StringBuilder();
			
			updateBoard //
			.append("	update board							")
			.append("	set title =? , content = ?, ip = ? 		")
			.append("	where num = ? and id = ? 				");
			
			pstmt = con.prepareStatement(updateBoard.toString());
			
			pstmt.setString(1, bDTO.getTitle());
			pstmt.setString(2, bDTO.getContent());
			pstmt.setString(3, bDTO.getIp());
			pstmt.setInt(4, bDTO.getNum());
			pstmt.setString(5, bDTO.getId());
			
			cnt = pstmt.executeUpdate();

		} finally {
			gc.dbClose(null, pstmt, con);
		}// try catch
		
		return cnt;
	}//updateBoard
	
	public int deleteBoard(BoardDTO bDTO) throws SQLException {
		int cnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		GetConnection gc = GetConnection.getInstance();
		
		try {
			con = gc.getConn("dbcp");
			
			StringBuilder deleteBoard = new StringBuilder();
			
			deleteBoard //
			.append("	delete from board		")
			.append("	where num = ? and id = ? 		");
			
			pstmt = con.prepareStatement(deleteBoard.toString());
			
			pstmt.setInt(1, bDTO.getNum());
			pstmt.setString(2, bDTO.getId());
			
			cnt = pstmt.executeUpdate();

		} finally {
			gc.dbClose(null, pstmt, con);
		}// try catch
		
		return cnt;
	}//updateBoard
}
