package action;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MappingDAO;
import dao.NegletDAO;
import dao.UserDAO;
import entity.Mapping;
import entity.Neglet;
import entity.User;

/**
 * Servlet implementation class Profile
 */
@WebServlet("/profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Profile() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			User user = UserDAO.get((String) request.getSession().getAttribute("username"));
			List<Mapping> mappings = MappingDAO.get((String) request.getSession().getAttribute("username"));
			List<Neglet> neglets = NegletDAO.get((String) request.getSession().getAttribute("username"));
			request.setAttribute("user", user);
			request.setAttribute("mappings", mappings);
			request.setAttribute("neglets", neglets);
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		} catch (SQLException e) {
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
