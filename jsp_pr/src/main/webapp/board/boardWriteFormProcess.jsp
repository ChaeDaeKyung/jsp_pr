<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="kr.co.sist.util.BoardUtil"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="kr.co.sist.util.HangulUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.sist.board.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="../include/siteProperty.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ include file="../include/loginCheck.jsp" %> --%>
<% 
String sessionId="test3"; 
String sessionName="테스트";

pageContext.setAttribute("userId", sessionId);
pageContext.setAttribute("userName", sessionName);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
if("GET".equals(request.getMethod())){
	return;
}// end if

request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bDTO" class="kr.co.sist.board.BoardDTO" scope="page"/>
<jsp:setProperty property="id" name="bDTO" value="${ userId }"/>
<jsp:setProperty property="ip" name="bDTO" value="<%= request.getRemoteAddr() %>"/>
<%
//request로는 post로 넘어오는 web parameter를 받을수 없다.
File saveDir = new File("C:/Users/user/git/jsp_pr/jsp_pr/src/main/webapp/upload");
//최대 업로드 파일의 제약 크기
int uploadMaxSize = 1024*1024*50;
//실제 업로드되어서 사용될 파일 크기
int maxSize = 1024*1024*10;
MultipartRequest mr = new MultipartRequest(request,saveDir.getAbsolutePath(),uploadMaxSize,"UTF-8",new DefaultFileRenamePolicy());

String fileName = mr.getFilesystemName("upfile");
System.out.println(fileName);
File uploadFile = new File(saveDir.getParent()+File.separator+fileName);
System.out.println(saveDir.getParent()+File.separator+fileName);
System.out.println(uploadFile);
//System.out.println(uploadFile.+"크기");

System.out.println(uploadMaxSize+"/"+ (maxSize <= uploadFile.length()));

if(uploadFile.length() > maxSize){//파일의 크기가 uploadMaxSize보다 크다면 지운다.
	uploadFile.delete();
	out.println("파일은 최대 10Mb까지만 업로드 가능합니다." + uploadFile.length());
}else{
	//서버에서 실행되는 파일이 업로드 되지 않도록 처리.
	if(mr.getContentType("upfile")!=null && !mr.getContentType("upfile").contains("image") ){
		//의도하지 않은 파일이 업로드 되었을때. : 해킹 파일
		//서비스가 되지 않는 디렉토리로 이동
		System.out.println("악의적인 의도의 파일");
		File hackDir = new File("c:/dev/hack");
		//hackDir.getAbsoluteFile()+File.separator+uploadFile.getName()
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try{
			//악의적인 목적의 파일에 스트림을 연결
			
			fis = new FileInputStream(uploadFile.getAbsoluteFile());
			//악의적인 목적의 파일을 웹서비스가 되지 않는 디렉토리로 이동.
			fos = new FileOutputStream(hackDir.getAbsoluteFile()+File.separator+uploadFile.getName());
			byte[] readData = new byte[512];//한번에 읽어들일 데이터의 크기
			int readSize = 0;
			while((readSize=fis.read(readData)) != -1){//데이터를 EOF까지 읽어들인다.
				fos.write(readData,0,readSize);
			}// end while
			fos.flush();
			//파일 이동후 올라온 파일을 삭제
			
		}finally{
			if(fis != null){
				fis.close();
			}
			if(fos!=null){
				fos.close();
			}
			uploadFile.delete();
		}
		//uploadFile.delete();
	}// end if
	
	if(mr.getContentType("upfile")!=null){
		String[] ext={"jpg","jpeg","gif","png","bmp"};
		boolean fileFlag = false;
		String compareExt = uploadFile.getName().substring(uploadFile.getName().lastIndexOf(".")+1);
		
		for(int i =0 ; i < ext.length; i++){
			if(fileFlag = ext[i].equals(compareExt.toLowerCase())){
				break;
			}
		}
		
		bDTO.setUpfile(BoardUtil.uUIDFile(uploadFile));
		System.out.println(uploadFile.getParent()+File.separator+bDTO.getUpfile()+"바뀌냐?");
		uploadFile.renameTo(new File(uploadFile.getParent()+File.separator+bDTO.getUpfile()));
		System.out.println(uploadFile+"바뀌냐?");
	}
	
/* 
java.util.URLDecoder를 사용
bDTO.setTitle(URLDecoder.decode(URLEncoder.encode(mr.getParameter("title"),"8859_1"),"UTF-8"));
bDTO.setContent(URLDecoder.decode(URLEncoder.encode(mr.getParameter("content"),"8859_1"),"UTF-8"));
 */
bDTO.setTitle(mr.getParameter("title"));
bDTO.setContent(mr.getParameter("content"));
out.println(bDTO);
BoardService bs = new BoardService();
pageContext.setAttribute("result", bs.addBoard(bDTO));

%>

<script type="text/javascript">
	<c:choose>
		<c:when test="${result}">
			alert("작성하신 글이 저장되었습니다.");
			location.href="boardList.jsp";
		</c:when>
		<c:otherwise>
			alert("글 저장중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.");
			history.back();
		</c:otherwise>
	</c:choose>
</script>

<%
}//end else if
%>