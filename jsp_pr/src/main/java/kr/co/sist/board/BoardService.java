package kr.co.sist.board;

import java.sql.SQLException;
import java.util.List;

public class BoardService {
	private int totalCount;
	private int pageScale;
	/**
	 * 게시글의 총 레코드
	 * 
	 * @return
	 */
	public int searchTotalCount(RangeDTO rDTO) {
		int cnt = 0;

		BoardDAO bDAO = BoardDAO.getInstance();

		try {
			cnt = bDAO.selectTotalCount(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		totalCount = cnt;
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
	
	public int pageScale() {
		pageScale=10;
		return pageScale;
	}
	
	/**
	 * 총 페이지 수
	 * @param totalCount 총 게시글 수
	 * @param pageScale 한화면에 보여길 게시글의 수
	 * @return
	 */
	public int totalPage(int totalCount,int pageScale) {
		int totalPage=(int)Math.ceil((double)totalCount/pageScale);
		return totalPage;
	}
	
	public int currentPage(String tempPage) {
		int currentPage = 1;
		if(tempPage != null) {
			currentPage = Integer.parseInt(tempPage);
		}// end if
		return currentPage;
	}
	
	/**
	 * 조회할 글의 시작번호
	 * @param currentPage 현재페이지
	 * @param pageScale 한화면에 보여질 게시글의 수
	 * @return 구해진 시작번호
	 */
	public int startNum(int currentPage, int pageScale) {
		int startNum= currentPage * pageScale-pageScale+1;
		return startNum;
	}
	
	/**
	 * 조회할 글의 끝번호
	 * @param startNum 글의 시작번호
	 * @param pageScale 한화면에 보여질 게시글의 수
	 * @return 구해진 끝 번호
	 */
	public int endNum(int startNum, int pageScale) {
		int endNum=startNum+pageScale-1;
		return endNum;
	}
	
}
