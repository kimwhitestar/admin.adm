package admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.database.MemberDAO;

public class AdminMemberLevelUpdateCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map mapTarget = request.getAttribute("attrMapTgt")==null?null:(Map)request.getAttribute("attrMapTgt");
		String[] targetArrIdx = null, targetArrMid = null, targetArrLevel = null;

		if (null != mapTarget) {
			targetArrIdx = (String[])mapTarget.get("targetArrIdx");
			targetArrMid = (String[])mapTarget.get("targetArrMid");
			targetArrLevel = (String[])mapTarget.get("targetArrLevel");
		}
		
		if (null == targetArrLevel || null == targetArrIdx || null == targetArrMid 
			|| targetArrLevel.length != targetArrIdx.length 
			|| targetArrIdx.length != targetArrMid.length 
			|| targetArrMid.length != targetArrLevel.length) {
			request.setAttribute("msg", "memberLevelUpdateNo");
			request.setAttribute("url", request.getContextPath()+"/adminMemberList.adm");//관리자-전체회원목록
			return;
		}
		
		MemberDAO dao = new MemberDAO();
		int resCnt = 0;
		for (int i=0; i<targetArrIdx.length; i++) {
			//id중복체크해서 mid만으로 DB DML SQL작성하기로 함
			int res = dao.updateMemberLevel(targetArrLevel[i], targetArrIdx[i], targetArrMid[i]);//회원레벨 수정
			if (1 == res) ++resCnt;
		}
		
//		if (resCnt == targetArrIdx.length) {
//			request.setAttribute("msg", "memberLevelUpdateOk");
//		} else {
//			//oracle이라면 db commit안하거나 rollbak필요한데, mysql도 기능이 있을까?
//			request.setAttribute("msg", "memberLevelUpdateNo");
//		}
		
		request.setAttribute("msg", "memberLevelUpdateOk");//중단 전 updated회원 or 정상 updated회원
		request.setAttribute("url", request.getContextPath()+"/adminMemberList.adm");//관리자-전체회원목록
	}
}