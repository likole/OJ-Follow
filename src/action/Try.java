package action;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.OJUtil;

/**
 * Servlet implementation class Try
 */
@WebServlet("/try")
public class Try extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String yourid;
	private String othersid;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Try() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		yourid = request.getParameter("yourid");
		othersid = request.getParameter("othersid");
		List<String> your = OJUtil.getList(yourid);
		List<String> others = OJUtil.getList(othersid);
		Set<String> rsSet = new HashSet<String>(others);
		for (String string : your) {
			rsSet.remove(string);
		}
		String[] arr = new String[rsSet.size()];
		rsSet.toArray(arr);
		Arrays.sort(arr);
		request.setAttribute("data", arr);
		request.getRequestDispatcher("try.jsp").forward(request, response);
	}

}
