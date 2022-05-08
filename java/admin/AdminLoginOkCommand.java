package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.database.AdminDAO;
import conn.SecurityUtil;

public class AdminLoginOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null? 99 : (int) session.getAttribute("sLevel");
		String mid = request.getParameter("mid");
		String pwd = request.getParameter("pwd");
		String shaPwd = new SecurityUtil().encryptSHA256(pwd);//비밀번호 암호화처리-SHA2(sha256)

		int res = new AdminDAO().searchAdminLogin(mid, shaPwd);

		if (1 == res) {
			session.setAttribute("sLevel", 0);
			session.setAttribute("sAdmin", "adminOk");
			request.setAttribute("msg", "adminOk");
			request.setAttribute("url", "adminMain.adm");
		} else {
			session.setAttribute("sLevel", level);
			session.setAttribute("sAdmin", "adminNo");
			request.setAttribute("msg", "adminNo");
			request.setAttribute("url", "adminLogin.adm");
		}
	}
}
