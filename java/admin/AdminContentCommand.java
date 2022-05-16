package admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.database.BoardDAO;
import board.database.BoardVO;
import guest.database.GuestDAO;
import guest.database.GuestVO;
import admin.database.MemberDAO;
import member.database.MemberVO;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  //전체회원목록 대시보드 조회
		MemberDAO memberDao = new MemberDAO();
	  List<MemberVO> memberVos = memberDao.searchMemberList((char)0, 0, 0, 10);
	  request.setAttribute("adminMemberVos", memberVos);
	  
	  //최근접속회원목록 대시보드 조회
	  List<MemberVO> recentlyLoginMemberVos = memberDao.searchRecentlyLoginMemberList((char)0, 0, 0, 10);
	  request.setAttribute("recentlyLoginMemberVos", recentlyLoginMemberVos);
	  
	  //신규가입회원목록 대시보드 조회
	  List<MemberVO> recetylyEntryMemberVos = memberDao.searchRecentlyEntryMemberList((char)0, 0, 0, 10);
	  request.setAttribute("recetylyEntryMemberVos", recetylyEntryMemberVos);
	  
	  //탈퇴회원목록 대시보드 조회
	  List<MemberVO> pracLeaveMemberVos = memberDao.searchPracLeaveMemberList((char)0, 0, 0, 10);
	  request.setAttribute("pracLeaveMemberVos", pracLeaveMemberVos);
	  
	  //게시판목록 대시보드 조회
	  BoardDAO boardDao = new BoardDAO();
	  List<BoardVO> boardVos = boardDao.searchBoardList((char)0, 0, null, null, 0, 10);
	  request.setAttribute("adminBoardVos", boardVos);
	  
	  //방명록목록 대시보드 조회
	  GuestDAO guestDao = new GuestDAO();
	  List<GuestVO> guestVos = guestDao.searchGuestList((char)0, 0, null, null,0, 10);
	  request.setAttribute("adminGuestVos", guestVos);
	}
}
