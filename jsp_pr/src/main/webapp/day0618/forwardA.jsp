<%@page import="java.util.ArrayList"%>
<%@page import="day0612.TestDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>

<% 
// 보여주는 일을 하지 않기 때문에 디자인 코드를 가질 필요가없다.
// 업무 로직만을 구현하여 사용한다.

String name = "홍길동";
List<TestDTO> list = new ArrayList<TestDTO>();
list.add(new TestDTO("홍길동",20));
list.add(new TestDTO("김길동",25));
list.add(new TestDTO("윤인성",45));
list.add(new TestDTO("정동진",39));

//0. 업무처리한 결과를 view 페이지로 전달하기 위해서 request내장객체에 속성을 사용한다.
request.setAttribute("name", name);
request.setAttribute("memberList", list);

//1. 이동할 페이지 설정
RequestDispatcher rd = request.getRequestDispatcher("forwardB.jsp");
//2. 페이지 이동 (이 페이지를 요청할 때 생성된 HttpServletRequest와 HttpServletResponse가 이동하는 페이지로 전달된다.)
rd.forward(request, response);
%>