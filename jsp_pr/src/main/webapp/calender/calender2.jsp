<%@page import="java.util.Calendar"%>
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
		a {
			text-decoration: none;
			color: #333;
		}
		a:hover {
			text-decoration: underline;
			color: #1E4183;
		}
		/* 달력 디자인 */
		.calTitle {
			font-weight: bold;
			font-size: 30px;
		}
		#calHeader {
			font-size: 20px; 
			text-align: center;
			margin-bottom: 20px;
		}
		#calTab, th, td {
			border: 1px solid #E5E5E5;
			margin: 0px auto;
		}
		#calTab > thead > tr > th {
			text-align: center;
			color: #909090;
		}
		#calTab > tbody > tr > td{
			width: 120px;
			height:80px; 
			text-align: right;
			vertical-align: top;
		}
		.sunTitle {
			width: 120px;
			height:30px; 
			background-color: #E72203;
			color: #FFF;
			font-weight: bold;
		}
		.satTitle {
			width: 120px;
			height:30px; 
			background-color: #5379E1;
			color: #FFF;
			font-weight: bold;
		}
		.weekTitle {
			width: 120px;
			height:30px; 
		}
		.sunTextColor{
			color:#E72203;
			font-weight: bold;
		}
		.weekTextColor{
			color:#909090;
		}
		.satTextColor{
			color:#5379E1;
			font-weight: bold;
		}
		
		.toDayCss{
			border: 1px solid #6C86C4;
			background-color: #EFF5FA;
		}
		.dayCss{
			border: 1px solid #E5E5E5;
		}
	</style>
	<script type="text/javascript">
	//jQuery
	$(function(){
		
	});//ready
	
	function moveCal(month, year){
		// 입력된 값을 히든에 설정하고 form에 submit 수행
		$("#month").val(month);
		$("#year").val(year);
		#("#calFrm")[0].submit();
	}// moveCal
	
	</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			
		</div>
		<div id="container">
			<div id="calWarp">
				<% 
				Calendar cal=Calendar.getInstance();
				//오늘의 요일을 표현하기 위해서 오늘정보를 저장 후 비교
				StringBuilder toDay = new StringBuilder();
				toDay.append(cal.get(Calendar.YEAR)).append(cal.get(Calendar.MONTH)+1);
				
				int nowYear=0;
				int nowMonth=0;
				
				//년도
				String year=request.getParameter("year");
				if(year != null){
					cal.set(Calendar.YEAR, Integer.parseInt(year));
				}// end if
				nowYear = cal.get(Calendar.YEAR);
				
				// 월은 0월부터 시작
				String month = request.getParameter("month");
				
				if(month != null){// 웹 파라미터가 존재하면 
					cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
				}// end if
				nowMonth = cal.get(Calendar.MONTH)+1;
				
				int nowDay=cal.get(Calendar.DAY_OF_MONTH);
				
				//log(toDay.toString());
				StringBuilder selectDay=new StringBuilder();
				selectDay.append(nowYear).append(nowMonth);
				//log(selectDay.toString());
				
				//log(String.valueOf(toDay.toString().equals(selectDay.toString())));
				boolean toDayFlag = toDay.toString().equals(selectDay.toString());
				%>
				<form action="calender2.jsp" method="post" id="calFrm">
					<input type="hidden" name="year" id="year">
					<input type="hidden" name="month" id="month">
				</form>
				<div id="calHeader">
					<a href="#void" onclick="moveCal(<%=(nowMonth-1)==0 ? 12 : nowMonth-1 %>,<%= (nowMonth-1)==0 ? nowYear-1 : nowYear %>)" title="이전 월">&lt;&lt;</a>
					<a href="calender2.jsp" title="오늘"><span class="calTitle"><%= nowYear %>.<%= nowMonth %></span></a>
					<a href="#void" onclick="moveCal(<%=(nowMonth+1)==13 ? 1 : nowMonth+1 %>,<%= (nowMonth+1)==13 ? nowYear+1 : nowYear %>)" title="다음 월">&gt;&gt;</a>
				</div>
				<div id="calContainer">
					<table id="calTab">
						<thead>
							<tr>
								<th class="sunTitle">일</th>
								<th class="weekTitle">월</th>
								<th class="weekTitle">화</th>
								<th class="weekTitle">수</th>
								<th class="weekTitle">목</th>
								<th class="weekTitle">금</th>
								<th class="satTitle">토</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							<%! //declaration : 선언 - JSP에서 method를 만들거나, instance변수, static 변수를 만들때 사용.
							public static final int START_DAY = 1;
							%>
							<%
							String textCss="";//요일별 글자색 설정
							String tdCss="";//오늘을 강조하기위한 CSS
							for(int tempDay=1; ;tempDay++){
								//증가하는 임시일자를 달력객체에 설정
								//현재월에 없는 날짜가 입력되면 자동으로 다음달로 1일로 된다.(6월 기중 31일이 입력되면 7월 1일)
								cal.set(Calendar.DAY_OF_MONTH,tempDay);
								if(cal.get(Calendar.DAY_OF_MONTH) != tempDay){
									int lastDayOfWeek=cal.get(Calendar.DAY_OF_MONTH);
									//for(int blankTd=1; blankTd < lastDayOfWeek; blankTd++){
									
									//}//end for
									break;
								}// end if
								
								//1일을 출력전에 공백 설정
								switch(tempDay){
								case START_DAY:
									int startDayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
									for(int blankTd=1; blankTd < startDayOfWeek; blankTd++){
										%><td></td><%
									}//end for
								}// end if
								
								textCss="weekTextColor";
								switch(cal.get(Calendar.DAY_OF_WEEK)){
								case Calendar.SUNDAY : textCss="sunTextColor"; break;
								case Calendar.SATURDAY : textCss="satTextColor"; break;
								}// end switch
								
								tdCss="dayCss";
								if(toDayFlag && tempDay == nowDay){
									tdCss="toDayCss";
								}// end if
								
								//증가하는 일을 출력
								%>
								<td class="<%= tdCss %>"><span class="<%= textCss %>"><%= tempDay %></span></td>
								<%
								switch(cal.get(Calendar.DAY_OF_WEEK)){
								case Calendar.SATURDAY:
									%></tr>
									<tr>
									<%
								}//end switch
							}//end for %>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="footer">
		
		</div>
	</div>
</body>
</html>