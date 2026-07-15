package xml0709;

import java.io.FileOutputStream;
import java.io.IOException;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

public class CreateXML {
	public static void main(String[] args) {
		//JDOM Parser를 사용한 XML문서 생성.
		//1. XML문서를 저장할 수 있는 문서를 객체를 생성.
		Document xmlDoc = new Document();//<?xml version="1.0" encoding="UTF-8"?>
		//2. 최상위 부모노드 
		Element rootNode = new Element("messages");// <messages></messages> 이 생성
		//3. XML문서 객체에 부모노드를 추가
		xmlDoc.addContent(rootNode);
		//4. 자식노드 생성.
		Element messageNode = new Element("message");
		Element messageNode2 = new Element("message");
		//5. 자식노드에 값 할당
		messageNode.setText("안녕하세요");
		messageNode2.setText("안녕히가세요");
		//6. 부모노드에 자식노드 추가
		rootNode.addContent(messageNode);
		rootNode.addContent(messageNode2);
		//7.생성된 XML문서 객체를 출력.
		//XMLOutputter xOut = new XMLOutputter(Format.getRawFormat());//한줄로 출력
		//XMLOutputter xOut = new XMLOutputter(Format.getCompactFormat());//한줄로 출력
		XMLOutputter xOut = new XMLOutputter(Format.getPrettyFormat());
		try {
			xOut.output(xmlDoc, System.out);
			FileOutputStream fos = new FileOutputStream("C:/Users/user/git/jsp_pr/jsp_pr/src/main/webapp/xml0709/hello2.xml");
			xOut.output(xmlDoc, fos);
			
			if(fos != null) {
				fos.close();
			}// end if
		} catch (IOException e) {
			e.printStackTrace();
		}
	}// main
}//class
