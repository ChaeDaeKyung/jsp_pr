package xml0709;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

/**
 * 조회한 결과로 XML 생성
 */
public class DeptService {
	
	private Document searchAllDept(){
		//XML 문서 객체 생성
		Document xmlDoc = new Document();
		//최상위 부모노드 생성
		Element deptsNode = new Element("depts");
		//부모 노드를 xml 문서객체에 추가
		xmlDoc.addContent(deptsNode);
		//반복되는 자식 노드 생성
		Element deptNode = null;
		Element deptnoNode = null;
		Element dnameNode = null;
		Element locNode = null;
		
		DeptDAO dDAO = DeptDAO.getInstance();
		List<DeptDTO> list = null;
		try {
			//데이터의 부가적인 정보 생성
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEEE kk:mm:ss");
			Element pubDateNode = new Element("pubDate");
			pubDateNode.setText(sdf.format(new Date()));
			deptsNode.addContent(pubDateNode);
			
			Element resultNode = new Element("result");
			resultNode.setText(String.valueOf(false));
			
			list = dDAO.selectAllDept();
			
			resultNode.setText(String.valueOf(true));
			deptsNode.addContent(resultNode);
			
			//데이터 생성
			for(DeptDTO dDTO : list) {
				deptNode = new Element("dept");
				deptnoNode = new Element("deptno");
				dnameNode = new Element("dname");
				locNode = new Element("loc");
				
				//자식 노드에 값 설정
				deptnoNode.setText(String.valueOf(dDTO.getDeptno()));
				dnameNode.setText(dDTO.getDname());
				locNode.setText(dDTO.getLoc());
				
				//부모노드인 deptNode에 자식노드를 추가
				deptNode.addContent(deptnoNode);
				deptNode.addContent(dnameNode);
				deptNode.addContent(locNode);
				
				//최상위 deptsNode에 자식노드인 deptNode 추가
				deptsNode.addContent(deptNode);
			}//end for
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return xmlDoc;
	}//searchAllDept
	
	/**
	 * 콘솔에 값 뿌려주기
	 * @throws IOException
	 */
	public void consolePrint() throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		xOut.output(searchAllDept(),System.out);
	}//consolePrint
	
	/**
	 * xml파일 생성
	 * @param path
	 * @throws IOException
	 */
	public void createFile(String path) throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		FileOutputStream fos = new FileOutputStream(path);
		xOut.output(searchAllDept(), fos);
		if(fos != null) {
			fos.close();
		}// end if
	}//createFile
	
	/**
	 * 브라우저에 출력
	 * @param out
	 * @throws IOException
	 */
	public void webBrowserPrint(JspWriter out) throws IOException {
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		xOut.output(searchAllDept(), out);
	}//webBrowserPrint
	
}// class
