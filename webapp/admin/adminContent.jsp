<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminContent.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<style>
	.dashimg {
	    height: 550px;
	    background: #ddd;
	}
	</style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<p><br></p>
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
      <h3 class="p-2 text-left">신규 가입 회원</h3>
      <h6 class="text-left">최근 가입한 회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${memberVos.size() > 9 ? 9 : memberVos.size()}">
	          <tr>
	             <td>&nbsp; - ${memberVos[i].mid}</td>
	             <td>${memberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p>1회 방문시마다 5point를 지급합니다.(단, 1일 최대 50point 까지 지급)</p>
      <h3 class="text-left">탈퇴신청한 회원</h3>
      <p class="text-left">최근 신청자</p>
      <ul class="nav nav-pills flex-column text-center">
        <li class="nav-item">
          <a class="nav-link active bg-info" href="#">탈퇴신청 회원명단</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="#"></a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="#"></a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="#"></a>
        </li>
         <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8">
      <h3 class="text-left p-2">게시판 신규자료</h3>
      <h6 class="text-left">최근에 게시된 글</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info" >
            <th width="38%">올린이</th>
            <th width="62%">글제목</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${boardVos.size() > 9 ? 9 : boardVos.size()}">
	          <tr>
	             <td>${boardVos[i].nickName}</td>
	             <td>${boardVos[i].title}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p></p>
      <p></p>
      <br>
      <h3 class="text-left p-2">방명록 신규자료</h3>
      <h6 class="text-left">최근에 게시된 방명록</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white bg-info" >
            <th width="68%">내용</th>
            <th width="32%">방문자</th>
          </tr>
	        <c:forEach var="i" begin="0" end="${guestVos.size() > 9 ? 9 : guestVos.size()}">
	          <tr >
	             <td>${guestVos[i].content}</td>
	             <td>${guestVos[i].name}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>