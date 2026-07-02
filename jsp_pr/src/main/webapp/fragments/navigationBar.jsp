<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="navigation bar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">
	<button class="navbar-toggler" type="button"
		data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
		aria-controls="navbarCollapse" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarCollapse">
		<ul class="navbar-nav me-auto mb-2 mb-md-0">
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="${ CommonURL }/index.html">메인</a></li>
			
			<li class="nav-item"><a class="nav-link" href="javacript:history.back()">이전으로</a></li>
			<li class="nav-item"><a class="nav-link" href="${CommonURL}/board/boardList.jsp">게시판</a></li>
			<li class="nav-item"><a class="nav-link disabled"
				aria-disabled="true">Disabled</a></li>
		</ul>
		<form class="d-flex" role="search">
		<c:choose>
			<c:when test="${ empty userInfo }">
				<a class="nav-link"	style="color:#FFF" aria-current="page" href="${CommonURL}/login/loginForm.jsp">로그인</a>&nbsp;&nbsp;
				<a class="nav-link" style="color:#FFF"	aria-current="page" href="${ CommonURL }/memberJoin/joinForm.jsp">회원가입</a>
			</c:when>
			<c:otherwise>
				<span title="${ userInfo.name }"><c:out value="${ userInfo.id }"/> </span>님이 로그인 하셨습니다.
				<a class="nav-link" style="color:#FFF"	aria-current="page" href="${ CommonURL }/mypage/mypage.jsp">마이 페이지</a>
				<a class="nav-link"	style="color:#FFF" aria-current="page" href="#void">로그아웃</a>&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
		</form>
	</div>
</div>