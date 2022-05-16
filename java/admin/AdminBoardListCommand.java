package admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.database.BoardDAO;
import board.database.BoardVO;
import common.Paging;

public class AdminBoardListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		char recetlyYmd = '0'; 
		int recetlyTerm = 0;
		String paramRecetlyYmd = request.getParameter("recetlyYmd");
		if (null == paramRecetlyYmd || 0 == paramRecetlyYmd.trim().length()) recetlyYmd = (char)0;
		else recetlyYmd = paramRecetlyYmd.toCharArray()[0];
		String paramRecetlyTerm = request.getParameter("recetlyTerm");
		if (null == paramRecetlyTerm || 0 == paramRecetlyTerm.trim().length()) recetlyTerm = 0;
		else recetlyTerm = Integer.parseInt(paramRecetlyTerm);
		String searchCondition = request.getParameter("searchCondition");
		String searchString = request.getParameter("searchString");
		
		BoardDAO dao = new BoardDAO();
		
		//페이징 설정하기 
		int pageNo = request.getParameter("pageNo")==null ? 1 : Integer.parseInt(request.getParameter("pageNo"));//현 페이지
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));//각 페이징할 목록의 레코드 갯수
		int totalRecordSize = dao.boardListTotRecCnt(recetlyYmd, recetlyTerm, searchCondition, searchString);//목록의 총 레코드 갯수
		int blockingSize = request.getAttribute("blockSize")==null ? 3 : Integer.parseInt((String)request.getAttribute("blockSize"));//페이징할 블록 갯수
		
		//페이징을 설정하면, 페이징 객체로 부터 산출된 페이징정보가 REQUEST 객체에 설정된다
		Paging paging = new Paging(request, response);
		paging.setPaging(pageNo, totalRecordSize, pageSize, blockingSize);
		
		//한 페이징에 표시할 레코드 검색
		List<BoardVO> vos = dao.searchBoardList(recetlyYmd, recetlyTerm, searchCondition, searchString, paging.getStartIndexNo(), paging.getPageSize());
		request.setAttribute("vos", vos);
		request.setAttribute("searchCondition", searchCondition);
		request.setAttribute("searchString", searchString);
		request.setAttribute("searchCount", totalRecordSize);
	}
}