<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	body {background-color: #ddd}
    </style>
    <script>
    	'use strict';
    	function logoutCheck() {
    		parent.location.href = "${ctxPath}/memberLogout.mbr";
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h4>관리자 메뉴</h4>
	<hr/>
	<p><a href="${ctxPath}/" target="_top">홈으로</a></p>
	<p><a href="${ctxPath}/adminMemberList.adm" target="adminContent">회원관리</a></p>
	<p><a href="${ctxPath}/adminGuestList.adm" target="adminContent">방명록</a></p>
	<p><a href="${ctxPath}/" target="adminContent">게시판</a></p>
	<p><a href="${ctxPath}/" target="adminContent">PDS</a></p>
	<p><a href="${ctxPath}/" target="adminContent">자료실</a></p>
	<p><a href="javascript:logoutCheck()" >로그아웃</a></p>
</div>
</body>
</html>