<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="../include/siteProperty.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String uUID = UUID.randomUUID().toString();
%>

원본 : <%= uUID %> <br>
-삭제 : <%= uUID.replaceAll("-", "") %>
<hr>
<%
String name = "테스트";
//한글이 <a href="test.jsp?name=${ name }" 제대로 전달이 되지 않는 상황이 발생할 수 있다.
String encode = URLEncoder.encode(name,"UTF-8");
String paramName = request.getParameter("name");
%>

원본 문자열 : <%= name %><br>
인코드된 문자열 : <%= encode %><br>
<a href="testUUID.jsp?name=<%= encode %>">요청</a><br>
<hr>
받아온 문자열 : <%= paramName %><br>
<%
String decode = URLDecoder.decode(paramName, "UTF-8");
String decode2 = new String(encode.getBytes("8859_1"),"UTF-8");
%>
디코드 문자열 : <%= decode %><br>
디코드 문자열 : <%= decode2 %><br>
