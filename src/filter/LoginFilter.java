package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/*")
public class LoginFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public LoginFilter() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest request2 = (HttpServletRequest) request;
		HttpServletResponse response2 = (HttpServletResponse) response;
		HttpSession session = request2.getSession();
		String path = request2.getRequestURI();

		String[] noFilter = {
				//jsp
				"index.jsp",
				"login_error.jsp",
				//servlet
				"try", 			
				"regist", 
				"exist", 
				"login",
				"email_verify",
				//css
				"css/bootstrap.css",
				"css/bootstrapValidator.css",
				//js
				"js/jquery.min.js",
				"js/bootstrap.js",
				"js/bootstrapValidator.js",
				"js/language/zh_CN.js",
				//font
				"glyphicons-halflings-regular"};
		for (String string : noFilter) {
			if(path.contains(string))
			{
				chain.doFilter(request, response);
				return;
			}
		}
		if (session.getAttribute("login") == null) {
			response2.sendRedirect("index.jsp");
		} else {
			chain.doFilter(request, response);

		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
