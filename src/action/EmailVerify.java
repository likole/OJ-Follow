package action;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import util.MD5Util;

/**
 * Servlet implementation class EmailVerify
 */
@WebServlet("/email_verify")
public class EmailVerify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmailVerify() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String targetEmail = request.getParameter("email");
		String code = request.getParameter("code");

		Calendar calendar = Calendar.getInstance();
		response.setCharacterEncoding("utf-8");
		try {
			if (MD5Util.getMD5(calendar.get(Calendar.YEAR) + calendar.get(Calendar.MONTH)
					+ calendar.get(Calendar.DAY_OF_MONTH) + targetEmail).equals(code)) {
				UserDAO.changeEmailState(username, true);
				response.getWriter().println("<script>alert('验证成功');history.go(-1);</script>");
			} else {
				response.getWriter().println("<script>alert('验证验证失败');history.go(-1);</script>");
			}
		} catch (NoSuchAlgorithmException | SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
