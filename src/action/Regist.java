package action;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import entity.User;

/**
 * Servlet implementation class Regist
 */
@WebServlet("/regist")
public class Regist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Regist() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("<script>alert('注册失败');history.go(-1);</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("regist_username");
		String password = request.getParameter("regist_password");
		response.setCharacterEncoding("utf-8");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		try {
			if (!UserDAO.exist(username)) {
				UserDAO.add(user);
				request.getSession().setAttribute("login", true);
				request.getSession().setAttribute("username", username);
				request.getRequestDispatcher("regist.jsp").forward(request, response);
			} else {
				response.getWriter().println("<script>alert('注册失败');history.go(-1);</script>");
			}
		} catch (SQLException e) {
			response.getWriter().println("<script>alert('注册失败');history.go(-1);</script>");
		}
	}

}
