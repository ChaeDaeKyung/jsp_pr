<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSPTemplate</title>
<link rel="shortcut icon" href="http://192.168.10.79/jsp_prj/common/images/favicon.ico"/>

<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js" integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y" crossorigin="anonymous"></script>

<!-- jQuery google API -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<style type="text/css">
		#wrap { width: 1000px; height: 900px; margin: 0px auto; }
		/* header : 사이트 로고, navigation bar */
		#header { height: 200px; } 
		/* 사용자에게 제공할 서비스 */
		#container { height: 600px; }
		/* 기업정보, 고객사 정보, 개인정보 보호 정책 */ 
		#footer { height: 100px; }
	</style>
	<script type="text/javascript">
	//jQuery
	$(function(){
		
	});//ready
	
	</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			
		</div>
		<div id="container">
			<ul>
				<li>요청 방식 : <%= request.getMethod() %></li>
				<li>요청URL : <%= request.getRequestURL() %></li>
				<!-- querystring은 get방식에만 존재하고, post방식에는 querystring이 존재하지 않는다. -->
				<li>요청 queryString : <%= request.getQueryString() %></li>
				<li>요청 protocol : <%= request.getProtocol() %></li>
				<li>요청 server 명 : <%= request.getServerName() %></li>
				<li>요청 server port 명 : <%= request.getServerPort() %></li>
				<li>요청 URI : <%= request.getRequestURI() %></li>
				<li>요청 servlet 명 : <%= request.getServletPath() %></li>
				<li>요청 parameter : <%= request.getParameter("name") %></li>
				<%--<li>요청 parameter : <%= request.getParameter("age") %></li>
				 <li>요청 parameter : <%= request.getParameterValues("age")[0] %></li>
				<li>요청 parameter : <%= request.getParameterValues("age")[1] %></li> --%>
				
				<li>접속자의 port : <%= request.getRemotePort() %></li>
				<li>접속자의 user : <%= request.getRemoteUser() %></li>
				<li>접속자의 host : <%= request.getRemoteHost() %></li>
				
			</ul>
			<div>
				<a href="http://localhost/jsp_pr/day0616/useRequest.jsp?name=kim&age=20&age=21">요청</a>
				<form action="http://localhost/jsp_pr/day0616/useRequest.jsp" method="post">
					<input type="hidden" name="name" value="park">
					<input type="hidden" name="age" value="24">
					<input type="hidden" name="age" value="25">
					<button class="btn btn-success btn-sm">요청 post</button>
				</form>
			</div>
			<div>
				<h2>요청 Header의 값들</h2>
				<%
				Enumeration<String> en = request.getHeaderNames();
				String headerName = "";
				out.println("<ul>");
				while((headerName=en.nextElement()) != null){
					out.println("<li>");
					out.println(headerName + " / " + request.getHeader(headerName));
					out.println("</li>");
				}// end while
					out.println("</ul>");
				%>
			</div>
		</div>
		<div id="footer">
		
		</div>
	</div>
</body>
</html>