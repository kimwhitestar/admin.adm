<%@page import="guest.database.GuestVO"%>
<%@page import="guest.database.GuestDAO"%>
<%@page import="board.database.BoardVO"%>
<%@page import="board.database.BoardDAO"%>
<%@page import="member.database.MemberVO"%>
<%@page import="member.database.MemberDAO"%>
<%@page import="study.database.LoginVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  MemberDAO memberDao = new MemberDAO();
  List<MemberVO> memberVos = memberDao.searchMemberList(99, 0, 10);
  pageContext.setAttribute("memberVos", memberVos);
  
  BoardDAO boardDao = new BoardDAO();
  List<BoardVO> boardVos = boardDao.searchBoardList(0, 10);
  pageContext.setAttribute("boardVos", boardVos);
  
  GuestDAO guestDao = new GuestDAO();
  List<GuestVO> guestVos = guestDao.searchGuestList(0, 10);
  pageContext.setAttribute("guestVos", guestVos);
  
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>javagreenJ(김흰별 수업내용)</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="/include/bs4.jsp" %>
  <style>
  .dashimg {
    height: 200px;
    background: #ddd;
  }
  </style>
</head>
<body>

<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>

<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
      <h3 class="p-2 text-left">신규 가입 회원</h3>
      <h6 class="text-left">최근 가입한 회원 명단</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white w3-blue-grey">
            <th>아이디</th>
            <th>닉네임</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
	          <tr>
	             <td>&nbsp; - ${memberVos[i].mid}</td>
	             <td>${memberVos[i].nickName}</td>
	           </tr>
	        </c:forEach>
	      </table>
      </div>
      <p>1회 방문시마다 5point를 지급합니다.(단, 1일 최대 50point 까지 지급)</p>
      <h3 class="text-left">Study Links</h3>
      <p class="text-left">학습하고 있는 개발 언어</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active bg-info" href="#">Training</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/userList.st">Ajax 수업</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/0420/test03.jsp">JQuery 숙제</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/jstl1.st">JSTL Core 수업</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/jstl2.st">JSTL Function 수업</a>
        </li>
        <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/jstl3.st">JSTL Format 수업</a>
        </li>
<!--         <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
 -->

      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8">
      <h3 class="text-left p-2">게시판 신규자료</h3>
      <h6 class="text-left">최근에 게시된 글</h6>
      <div class="dashimg">
        <table class="table table-bordered text-center m-0">
          <tr class="text-white w3-blue-grey" >
            <th width="38%">올린이</th>
            <th width="62%">글제목</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
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
          <tr class="text-white w3-blue-grey" >
            <th width="68%">내용</th>
            <th width="32%">방문자</th>
          </tr>
	        <c:forEach var="i" begin="0" end="2">
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
<br><br>
<%@ include file="/include/footer.jsp" %>
</body>
</html>