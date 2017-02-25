package action;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import util.OJUtil;

/**
 * Servlet implementation class Exist
 */
@WebServlet("/exist")
public class Exist extends HttpServlet {
	private static final long serialVersionUID = 1L;
     private String what=null; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Exist() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		what=request.getParameter("what");
		switch (what) {
		case "username":
			String username=request.getParameter("regist_username");
			try {
				if(UserDAO.exist(username)){
					response.getWriter().println("{\"valid\":false}");
				}else{
					response.getWriter().println("{\"valid\":true}");
				}
			} catch (SQLException e) {
				response.getWriter().println("{\"valid\":false}");
			}
			break;
		case "oid":
			String oid=request.getParameter("oj");
			if(OJUtil.exist(oid)){
				response.getWriter().println("{\"valid\":true}");
			}else{
				response.getWriter().println("{\"valid\":false}");
			}
		default:
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
