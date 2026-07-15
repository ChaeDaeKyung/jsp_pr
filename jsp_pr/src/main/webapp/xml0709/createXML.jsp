<%@page import="xml0709.DeptService"%>
<%@ page language="java" contentType="application/xml; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
DeptService ds = new DeptService();
ds.consolePrint();
ds.webBrowserPrint(out);
ds.createFile("C:/Users/user/git/jsp_pr/jsp_pr/src/main/webapp/xml0709/depts2.xml");
%>