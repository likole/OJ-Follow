package action;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import util.OJUtil;

/**
 * Servlet implementation class Home
 */
@WebServlet("/home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Home() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// yours
		String yourid = null;
		try {
			yourid = UserDAO.get((String) request.getSession().getAttribute("username")).getOid();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<String> your = OJUtil.getList(yourid);
		// others
		List<String> others = new ArrayList<String>();
		try {
			List<Mapping> mappings = MappingDAO.get((String) request.getSession().getAttribute("username"));
			for (Mapping mapping : mappings) {
				List<String> other = OJUtil.getList(mapping.getTargetid());
				others.addAll(other);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// neglet
		List<Neglet> neglets = new ArrayList<Neglet>();
		try {
			neglets = NegletDAO.get((String) request.getSession().getAttribute("username"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// compute
		Set<String> rsSet = new HashSet<String>(others);
		for (String string : your) {
			rsSet.remove(string);
		}
		for (Neglet neglet : neglets) {
			rsSet.remove(String.valueOf(neglet.getPid()));
		}
		String[] arr = new String[rsSet.size()];
		rsSet.toArray(arr);
		Arrays.sort(arr);
		request.setAttribute("data", arr);
		request.getRequestDispatcher("home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
