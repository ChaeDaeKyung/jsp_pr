<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="최초 요청되는 JSP : GET방식으로 요청"
    isErrorPage="true"%>
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
		.bold {
			font-weight: bold;
		}
	</style>
	<script type="text/javascript">
	//jQuery
	$(function(){
		$("#btn4").click(function(){
			
		});
	});//ready
	
	</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			
		</div>
		<div id="container">
			<div>
				요청방식 <span class="bold"><%= request.getMethod() %></span>
			</div>
			<div id="get">
				<h2>GET방식 요청</h2>
				<ul>
					<li>링크 : <a href="requsetB.jsp">요청</a></li>
					<li>location 객체 : <button class="btn btn-outline btn-sm" id="btn">location요청</button></li>
					<li>form 태그<form action="requestB.jsp" method="GET" id="getFrm" enctype="application/x-www-form-urlencoded">
							<button class="btn btn-outline btn-sm" id="btn2">요청</button>
						</form>
					</li>
				</ul>	
			</div>
			<div id="post">
				<h2>POST방식 요청</h2>
				form 태그<form action="requestB.jsp" method="GET" id="postFrm" onsubmit="return false;">
							<button class="btn btn-outline btn-sm" id="btn3">요청</button>
						</form>
			</div>
		</div>
		<div id="footer">
		
		</div>
	</div>
</body>
</html>