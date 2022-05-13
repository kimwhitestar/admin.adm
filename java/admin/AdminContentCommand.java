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
import member.database.MemberDAO;
import member.database.MemberVO;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  MemberDAO memberDao = new MemberDAO();
	  List<MemberVO> memberVos = memberDao.searchMemberList(0, 0, 10);
	  request.setAttribute("memberVos", memberVos);
	  
	  BoardDAO boardDao = new BoardDAO();
	  List<BoardVO> boardVos = boardDao.searchBoardList(0, 10);
	  request.setAttribute("boardVos", boardVos);
	  
	  GuestDAO guestDao = new GuestDAO();
	  List<GuestVO> guestVos = guestDao.searchGuestList(0, 10);
	  request.setAttribute("guestVos", guestVos);
	}
}
