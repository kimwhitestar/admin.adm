<%@ page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="pageNo" value="${pageNo}" scope="request" />
<c:set var="totPage" value="${totPage}" scope="request" />
<c:set var="curScrStartNo" value="${curScrStartNo}" scope="request" />
<c:set var="blockSize" value="${blockSize}" scope="request" />
<c:set var="curBlock" value="${curBlock}" scope="request" />
<c:set var="lastBlock" value="${lastBlock}" scope="request" />
<%-- <c:set var="pageSize" value="${pageSize}" scope="request" /> --%>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />

<c:set var="vos" value="${vos}" scope="request" />
<c:set var="no" value="${vos.size()}" scope="page" />
<c:set var="attrMapTgt" scope="request" />
<c:set var="attrMid" scope="request" />
<c:set var="attrLevel" scope="request" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminMemberList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
		let mapTarget = new HashMap();

		function arrangeTargetMap() {
    		let elmtArrChk = myForm.arrChk;
    		let elmtArrIdx = myForm.arrIdx;
    		let elmtArrMid = myForm.arrMid;
    		let elmtSelArrLevel = myForm.arrLevel;
    		
    		//once 1개만 체크됬으면 cnt가 1이므로 new Array[1]로, 여러개 체크됬으면 new Array[cnt]로 배열생성
    		let cnt = 0, index = 0;
    		for (int i=0; i<elmtArrChk.length(); i++) {
        		if (elmtArrChk[i].checked) ++cnt;
    		}
    		if (0 == cnt) {
    			alert('선택한 회원이 없습니다.');
    			return;
    		}
    		let targetArrIdx = new Array[cnt];
    		let targetArrMid = new Array[cnt];
    		let targetArrLevel = new Array[cnt];
    		for (int i=0; i<elmtArrChk.length(); i++) {
        		if (elmtArrChk[i].checked) {
        			targetArrIdx[index] = elmtArrIdx[i].value;
        			targetArrMid[index] = elmtArrMid[i].value;
        			for (int j=0; j<elmtSelArrLevel[i].options.length(); j++) {
        				if (elmtSelArrLevel[i].options[j].selected)
        					targetArrLevel[index] = elmtSelArrLevel[i].options[j].value;
        			}
        			++index;
        		}
    		}
    		//1개든 여러개든 체크된 항목을 mapTarget에 배열값으로 설정
    		mapTarget.put("targetArrIdx", targetArrIdx);
    		mapTarget.put("targetArrMid", targetArrMid);
    		mapTarget.put("targetArrLevel", targetArrLevel);
    		//jstl로 선언한 REQUEST attribute변수 'mapTgt'에 mapTarget설정
    		${attrMapTgt} = mapTarget;
    	}
		function arrangeTargetMap(flg, mid, level) {
    		let targetArrIdx, targetArrMid, targetArrLevel;
    		if ('update' == flg) {
    			if ('' == level) {
    				alert('회원등급을 변경해야 수정할 수 있습니다');
    				return;
    			}
    			targetArrIdx = new Array[1];
    			targetArrMid = new Array[1];
    			targetArrLevel = new Array[1];
    			targetArrIdx = null;
        		targetArrMid[1] = mid;
        		targetArrLevel[1] = level;
    		} else if ('delete' == flg) {
    			targetArrIdx = null;
    			targetArrMid = new Array[1];
   				targetArrLevel = null;
        		targetArrMid[1] = mid;
   			} else {
   				return;
   			}
    		//1개든 여러개든 체크된 항목을 mapTarget에 배열값으로 설정
    		mapTarget.put("targetArrIdx", targetArrIdx);
    		mapTarget.put("targetArrMid", targetArrMid);
    		mapTarget.put("targetArrLevel", targetArrLevel);
    		//jstl로 선언한 REQUEST attribute변수 'mapTgt'에 mapTarget설정
    		${attrMapTgt} = mapTarget;
		}
    	function changeLevel(targetLevel) {
    		let arrOption = targetLevel.options;
    		let levelValue = '';
    		for (int i=0; i<arrOption.length(); i++) {
    			if (arrOption[i].selected) levelValue = arrOption[i].value;
    		}
    		alert('등급변경 버튼을 클릭하면 선택된 등급으로 수정됩니다' + levelValue);
    		${attrLevel} = levelValue;
    	}
    	function updateMemberLevel(flg, chk) {
    		if ('once' == chk) arrangeTargetMap(flg, ${attrMid}, ${attrLevel});
    		else if ('checked' == chk) arrangeTargetMap();
    		location.href = '${ctxPath}/adminMemberLevelUpdate.adm';
    	}
    	function deleteMember(flg, chk) {
    		if ('once' == chk) arrangeTargetMap(flg, ${attrMid}, null);
    		else if ('checked' == chk) arrangeTargetMap();
    		if (confirm('정말 회원에서 삭제처리하겠습니까?')) {
    			location.href = '${ctxPath}/adminMemberDelete.adm;
    		}
    	}
    	function locationControl(flg, chk, mid) {
    		${attrMid} = mid;
    		if ('update' == flg) updateMemberLevel(flg, chk);
           	else if ('delete' == flg) deleteMember(flg, chk);
    	}
    	function openWindowMemberDetail(mid) {
    		${attrMid} = mid;
    		let url = '${ctxPath}/memberDetail.mbr';
    		window.open(url,"memberDetailWin","width=800px,height=600px");
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2 class="text-center">관리자 전체 회원 목록</h2>
	<form name="myForm" method="post" action="${ctxPath}/adminMemberList.adm">
		<div class="m-2 row">
			<div class="col text-left">
				<select name="level">
					<option value="0" <c:if test="${0 == vo.level}">selected</c:if> >관리자</option>
					<option value="1" <c:if test="${1 == vo.level}">selected</c:if> >정회원</option>
					<option value="2" <c:if test="${2 == vo.level}">selected</c:if> >준회원</option>
					<option value="3" <c:if test="${3 == vo.level}">selected</c:if> >우수회원</option>
					<option value="4" <c:if test="${4 == vo.level}">selected</c:if> >운영자</option>
				</select>
				<input type="submit" value="조회" class="btn btn-secondary"/>
				<input type="button" value="등급변경" class="btn btn-secondary" onclick="locationControl('update', 'checked', null)"/>&nbsp;
				<input type="button" value="회원삭제" class="btn btn-secondary" onclick="locationControl('delete', 'checked', null)"/>
			</div>
			
			<!-- 페이징 처리 시작 -->
			<div class="col text-right">
<c:if test="${pageNo > 1}">
				<a href='adminMemberList.adm?pageNo=1' title='first'>${First}</a>
					<a href='adminMemberList.adm?pageNo=${pageNo - 1}' title='prev'>${Prev}</a>
</c:if>
					${pageNo}Page / ${totPage}Pages
<c:if test="${pageNo != totPage}">
					<a href='adminMemberList.adm?pageNo=${pageNo + 1}' title='next'>${Next}</a>
</c:if>
				<a href='adminMemberList.adm?pageNo=${totPage}' title='last'>${Last}</a>
			</div>
			<!-- 페이징 처리 끝 -->
			
		</div>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th><input type="checkbox" name="allChk" width="15px" height="15px"></th>
				<th>번호</th>
				<th>아이디</th>
				<th>별명</th>
				<th>성명</th>
				<th>성별</th>
				<th>공개유무</th>
				<th>회원등급</th>
			</tr>
<c:forEach var="vo" items="vos" varStatus="stat">
			<tr>
				<td>
					<input type="checkbox" name="arrChk" width="15px" height="15px">
					<input type="hidden" name="arrIdx" value="${vo.idx}"/>
					<input type="hidden" name="arrMid" value="${vo.mid}"/>
				</td>
				<td><c:out value="${curScrStartNo}"></c:out></td>
				<td><a href="javascript:openWindowMemberDetail(${vo.mid})"><c:out value="${vo.mid}"></c:out></a></td>
				<td><c:out value="${vo.nickName}"></c:out></td>
				<td><c:out value="${vo.name}"></c:out></td>
				<td><c:out value="${vo.gender}"></c:out></td>
				<td><c:out value="${vo.userInfo}"></c:out></td>
				<td>
					<select name="arrLevel" onchange="changeLevel(this.arrLevel)">
						<option value="0" <c:if test="${0 == vo.level}">selected</c:if> >관리자</option>
						<option value="1" <c:if test="${1 == vo.level}">selected</c:if> >정회원</option>
						<option value="2" <c:if test="${2 == vo.level}">selected</c:if> >준회원</option>
						<option value="3" <c:if test="${3 == vo.level}">selected</c:if> >우수회원</option>
						<option value="4" <c:if test="${4 == vo.level}">selected</c:if> >운영자</option>
					</select>
					<input type="button" value="등급변경" class="btn btn-secondary btn-sm" onclick="locationControl('update', 'once', ${vo.mid})"/>
				</td>
				<td>
					<c:if test="${'OK' == vo.userDel}"><font color="red">탈퇴신청</font></c:if>
					<c:if test="${'NO' == vo.userDel}"><font color="red">활동중</font></c:if>
					<c:if test="${30 <= vo.overDaysUserDel}"><font color="blue">*</font></c:if>
					<input type="button" value="회원삭제" class="btn btn-secondary btn-sm" onclick="locationControl('delete', 'once', ${vo.mid})"/>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
</c:forEach>
		</table>
		
		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
<c:if test="${pageNo > 1}">
			[<a href='adminMemberList.adm?pageNo=1' title='first'>첫페이지</a>]
</c:if>
<c:if test="${curBlock > 0}">
				[<a href='adminMemberList.adm?pageNo=${(curBlock-1)*blockSize+1}' title='prevBlock'>이전블록</a>]
</c:if>
 				<c:set var="isBreak" value="false"/>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" step="1"> 
					<c:if test="${i>totPage}"><c:set var="isBreak" value="true"/></c:if>
					<c:if test="${isBreak == false}">
						<c:if test="${i==pageNo}">[<a href='adminMemberList.adm?pageNo="${i}"'><font color='red'><b>${i}</b></font></a>]</c:if>
						<c:if test="${i!=pageNo}"></c:if>
					</c:if>
				</c:forEach>
<c:if test="${curBlock < lastBlock}">
				[<a href='adminMemberList.adm?pageNo=${(curBlock+1)*blockSize+1}' title='nextBlock'>다음블록</a>]
</c:if>
<c:if test="${page != totPage}">
			[<a href='adminMemberList.adm?pageNo=${totPage}' title='last'>마지막페이지</a>]
</c:if>
		</div>
		<!-- 블럭페이징 처리 끝 -->
		
	</form>
</div>
</body>
</html>