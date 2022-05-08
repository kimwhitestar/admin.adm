package admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberInterface;
import member.database.MemberDAO;

public class AdminMemberDeleteCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Map mapTarget = request.getAttribute("attrMapTgt")==null?null:(Map)request.getAttribute("attrMapTgt");
		String[] targetArrIdx = null, targetArrMid = null;

		if (null != mapTarget) {
			targetArrIdx = (String[])mapTarget.get("targetArrIdx");
			targetArrMid = (String[])mapTarget.get("targetArrMid");
		}
		
		if (null == targetArrIdx || null == targetArrMid 
			|| targetArrIdx.length != targetArrMid.length ) {
			request.setAttribute("msg", "memberDeleteNo");
			request.setAttribute("url", request.getContextPath()+"/adminMemberList.adm");//관리자-전체회원목록
			return;
		}
		
		MemberDAO dao = new MemberDAO();
		int resCnt = 0;
		for (int i=0; i<targetArrIdx.length; i++) {
			//id중복체크해서 mid만으로 DB DML SQL작성하기로 함
			//int res = dao.delete(targetArrIdx[i], targetArrMid[i]);//회원삭제
			int res = dao.delete(targetArrMid[i]);//회원삭제
			if (1 == res) ++resCnt;
		}
		
//		if (resCnt == targetArrIdx.length) {
//			request.setAttribute("msg", "memberLevelUpdateOk");
//		} else {
//			//oracle이라면 db commit안하거나 rollbak필요한데, mysql도 기능이 있을까?
//			request.setAttribute("msg", "memberLevelUpdateNo");
//		}
		
		request.setAttribute("msg", "memberDeleteOk");
		request.setAttribute("url", request.getContextPath()+"/adminMemberList.adm");
	}
}