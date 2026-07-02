package kr.co.sist.board;

import java.sql.SQLException;
import java.util.List;

public class BoardService {

	/**
	 * 게시글의 총 레코드
	 * 
	 * @return
	 */
	public int searchTotalCount() {
		int cnt = 0;

		BoardDAO bDAO = BoardDAO.getInstance();

		try {
			cnt = bDAO.selectTotalCount();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cnt;
	}

	public List<BoardDTO> searchBoard(RangeDTO rDTO){
		List<BoardDTO> listBoard = null;
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			listBoard = bDAO.selectBoard(rDTO);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return listBoard;
	}
	
	public boolean addBoard(BoardDTO bDTO) {
		boolean flag = false;
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			bDAO.insertBoard(bDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return flag;
	}
	
	public BoardDTO searchBoardDetail(int num){
		BoardDTO bDTO = null;
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			//글 번호에 해당하는 글을 읽고 
			bDTO = bDAO.selectBoardDetail(num);

			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return bDTO;
	}
	
	public void modifyCount(int num){
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			//글 번호에 해당하는 조회수 상승
			bDAO.updateCnt(num);
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean modifyBoard(BoardDTO bDTO) {
		boolean flag = false;
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			flag = bDAO.updateBoard(bDTO) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return flag;
	}//modifyBoard
	
	public boolean removeBoard(BoardDTO bDTO) {
		boolean flag = false;
		
		BoardDAO bDAO = BoardDAO.getInstance();
		
		try {
			flag = bDAO.deleteBoard(bDTO) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return flag;
	}//modifyBoard
	
	
}
