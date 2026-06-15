<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="day0612.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="day0612.TestService"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="scriptlet사용"%>
<%
	//method 내 정의하는 java 코드 작성
	String name="홍길동";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= name %>님 안녕하세요</title>
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
		.age { 
			font-weight: bold;	
		}
		.age2 { 
			font-weight: bold;
			color: #F00;	
		}
	</style>
	<script type="text/javascript">
	//jQuery
	$(function(){
		//alert("document 레디");
	});//ready
	
	</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			
		</div>
		<div id="container">
			<%
				//_jspService() 안쪽에 코드 생성.
				int age=25;//지역변수
				String css="age";
				if(new Random().nextBoolean() ){
					css="age2";
				}
			%>
			<div>
			나이는 <span class="<%= css %>"><%= age %></span>살 입니다.
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>나이</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<%
						TestService ts = new TestService();
						List<TestDTO> list = ts.searchMember();
						TestDTO tDTO = null;
						for(int i=0; i<list.size();i++){
							tDTO = list.get(i);
					%>
					<tr>
						<td><%= i+1 %></td>
						<td><%= tDTO.getName() %></td>
						<td><%= tDTO.getAge() %></td>
						<td><button class="btn btn-warning btn-sm">삭제</button></td>
					</tr>
					<%
						}//end for
					%>
					<%
						int total = 0;
						for(int i = 1; i < 101; i++){
							total += i;
						}// end for
					%>
				</tbody>
			</table>
			1에서 100까지의 합은 : <%= total %> 이다.
			<!-- 올해를 기준으로 이전 2년 이후 2년을 옵션으로 보여주는 select -->
			<%
				LocalDate ld = LocalDate.now();
				int year = ld.getYear() + 6;
				int month = ld.getMonthValue();
				int day = ld.getDayOfMonth();
			%>
			<select>
				<% for(int i = 0; i < 5; i++){ %>
				<option<%= 2026 == year ? " selected='selected'" : "" %> value="<%= year %>"><%= year %></option>
				<% year -= 2; 
					}// end for %>
				<%-- <option value="<%= year %>"><%= year-2 %></option>
				<option selected="<%= 2026 == year ? "selected" : "" %>" value="<%= year %>"><%= year %></option>
				<option value="<%= year %>"><%= year+2 %></option> --%>
			</select>
			<select>
				<% for(int i = 1; i < 13; i++){ %>
				<option<%= month == i ? " selected='selected'" : "" %>><%= i %></option>
				<% }// end for %>
			</select>
			<select>
				<% for(int i = 1; i < ld.lengthOfMonth()+1; i++){ %>
				<option<%= day == i ? " selected='selected'" : "" %>><%= i %></option>
				<% }// end for %>
			</select>
			
			<!-- 0점~10점까지 선택 할수 있는 radio 11개 생성 -->
			<% for(int i = 0; i < 11; i++){ %>
			<input type="radio" <%= i == 5 ? "checked='checked'":"" %> name="score" value="<%= i %>"><%= i %>
			<%}//end for %>
			<div>
				<!-- 아래 이미지를 4개중에 하나가 보이게  -->
				<% 
				int ran = new Random().nextInt(4);
				switch(ran){
				case 0:%><img src="../common/images/default_img2.png"><% break; 
				case 1:%><img src="../common/images/dice_1.png"><% break; 
				case 2:%><img src="../common/images/dice_2.png"><% break; 
				case 3:%><img src="../common/images/dice_3.png">	
				<% }// end switch %>
				
				<%-- <% // method 안에 method 정의가 불가능하기때문에 에러 발생 
				public void test(){
					
				}
				%> --%>
			</div>
			
			<script type="text/javascript">
			
				<%-- alert(<%= month %>); --%>
			</script>
			
		</div>
		<div id="footer">
		
		</div>
	</div>
</body>
</html>