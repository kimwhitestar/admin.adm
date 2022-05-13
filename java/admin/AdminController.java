package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.adm")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		//관리자 로그인
		if (com.equals("adminLogin")) {
			viewPage += "/admin/adminLogin.jsp";
		}
		//관리자 로그인OK
		else if (com.equals("adminLoginOk")) {
			command = new AdminLoginOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//관리자 로그아웃
		else if (com.equals("adminLogout")) {
			command = new AdminLogoutCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//관리자메뉴-frameset(main)
		else if (com.equals("adminMain")) {
			command = new AdminMenuCommand();
			command.execute(request, response);
			viewPage += "/admin/adminMain.jsp";
		}
		//관리자 Left
		if (com.equals("adminLeft")) {
			viewPage += "/admin/adminLeft.jsp";
		}
		//관리자 Content
		if (com.equals("adminContent")) {
			command = new AdminContentCommand();
			command.execute(request, response);
			viewPage += "/admin/adminContent.jsp";
		}
		//전체회원 게시판
		else if (com.equals("adminBoardList")) {
			command = new AdminBoardListCommand();
			command.execute(request, response);
			viewPage += "/admin/board/adminBoardList.jsp";
		}
		//관리자 대시보드-전체회원 방명록
		else if (com.equals("adminGuestList")) {
			command = new AdminGuestListCommand();
			command.execute(request, response);
			viewPage += "/admin/guest/adminGuestList.jsp";
		}
		//관리자 대시보드-전체회원 목록(공개회원)
		else if (com.equals("adminMemberList")) {
			command = new AdminMemberListCommand();
			command.execute(request, response);
			viewPage += "/admin/member/adminMemberList.jsp";
		}
		//관리자 -전체회원 목록(공개회원)->선택된 회원의 등급 수정
		else if (com.equals("adminMemberLevelUpdate")) {
			command = new AdminMemberLevelUpdateCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//관리자 -전체회원 목록(공개회원 중 회원탈퇴신청 후 30일 경과된 회원들)->선택된 회원 삭제
		else if (com.equals("adminMemberDelete")) {
			command = new AdminMemberDeleteCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		
		
				
//		//아이디 찾기
//		else if (com.equals("")) {
//			command = new ();
//			command.execute(request, response);
//			viewPage += "/member/sha/.jsp";
//		}
//		//비밀번호 찾기
//		else if (com.equals("")) {
//			command = new ();
//			command.execute(request, response);
//			viewPage += "/member/sha/.jsp";
//		}
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
