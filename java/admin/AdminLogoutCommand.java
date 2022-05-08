package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import guest.GuestInterface;

public class AdminLogoutCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("sAdmin");
		request.setAttribute("msg", "adminLogoutOk");
		request.setAttribute("url", request.getContextPath()+"/adminLogin.adm");
	}
}
