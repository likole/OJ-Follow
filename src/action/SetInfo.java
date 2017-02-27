package action;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

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
import util.MD5Util;

/**
 * Servlet implementation class SetInfo
 */
@WebServlet("/setinfo")
public class SetInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SetInfo() {
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
		// type
		String what = null;
		String username = (String) request.getSession().getAttribute("username");
		what = request.getParameter("what");
		//
		switch (what) {
		
		case "following":
			Mapping mapping = new Mapping();
			mapping.setAlias(request.getParameter("alias"));
			mapping.setusername(username);
			mapping.setTargetid(request.getParameter("oj"));
			try {
				MappingDAO.add(mapping);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			response.sendRedirect("profile");
			break;

		case "delete_following":
			try {
				if (MD5Util.getMD5(request.getParameter("id")+username).equals(request.getParameter("verify"))) {
					try {
						MappingDAO.delete(Integer.parseInt(request.getParameter("id")));
					} catch (NumberFormatException e) {
						e.printStackTrace();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (NoSuchAlgorithmException e3) {
				e3.printStackTrace();
			}
			response.sendRedirect("profile");
			break;

		case "add_neglet":
			Neglet neglet = new Neglet();
			neglet.setUsername(username);
			neglet.setPid(Integer.parseInt(request.getParameter("pid")));
			try {
				NegletDAO.add(neglet);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			response.sendRedirect("home");
			break;

		case "remove_neglet":
			try {
				NegletDAO.delete(Integer.parseInt(request.getParameter("nid")));
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
			response.sendRedirect("profile");
			break;
			
		case "change_email":
			try {
				UserDAO.changeEmail(username, request.getParameter("email"));
				UserDAO.changeEmailState(username, false);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			response.sendRedirect("profile");
			break;
			
		case "change_oj":
			try {
				UserDAO.changeOid(username, request.getParameter("oj"));
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			response.sendRedirect("profile");
			break;
			
		default:
			String email = request.getParameter("email");
			String oid = request.getParameter("oj");
			if (username != null) {
				try {
					UserDAO.changeEmail(username, email);
					UserDAO.changeOid(username, oid);
					response.sendRedirect("home");
				} catch (SQLException e) {
				}
			}
			break;
		}
	}

}
