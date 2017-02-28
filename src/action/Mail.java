package action;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.UserDAO;
import util.MD5Util;

/**
 * Servlet implementation class Mail
 */
@WebServlet("/mail")
public class Mail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Mail() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//目标地址
		String targetEmail = null;
		try {
			targetEmail = UserDAO.get((String) request.getSession().getAttribute("username")).getEmail();
		} catch (SQLException e3) {
			e3.printStackTrace();
		}
		//验证合法性
		try {
			if (!request.getParameter("verify").equals(MD5Util.getMD5(targetEmail)))
				return;
		} catch (NoSuchAlgorithmException e3) {
		}
		//发送邮件
		String myEmailAccount = "cf0524cf@163.com";
		String myEmailPassword = null;
		try {
			myEmailPassword = UserDAO.get("admin").getOid();
		} catch (SQLException e2) {
			e2.printStackTrace();
		}
		String myEmailSMTPHost = "smtp.163.com";
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.host", myEmailSMTPHost);
		props.setProperty("mail.smtp.auth", "true");
		Session session = Session.getDefaultInstance(props);
		session.setDebug(true);
		MimeMessage message = new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(myEmailAccount, "OJ-Follow", "UTF-8"));
			message.setRecipient(MimeMessage.RecipientType.TO,
					new InternetAddress(targetEmail,
							(String) request.getSession().getAttribute("username"), "UTF-8"));
			message.setSubject("OJ-Follow 邮箱验证", "UTF-8");
			Calendar calendar=Calendar.getInstance();
			String url="http://www.likole.cn:8080/OJ-Follow/"+"email_verify?username="+(String) request.getSession().getAttribute("username")+"&email="+targetEmail+"&code="+MD5Util.getMD5(calendar.get(Calendar.YEAR)+calendar.get(Calendar.MONTH)+calendar.get(Calendar.DAY_OF_MONTH)+targetEmail);
			message.setContent((String) request.getSession().getAttribute("username") + ",您好！<br/>感谢您注册OJ-Follow!<br/>点击此链接激活:<a href='"+url+"'>"+url+"</a>",
					"text/html;charset=UTF-8");
			message.setSentDate(new Date());
		} catch (MessagingException | NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
		Transport transport = null;
		try {
			transport = session.getTransport();
			transport.connect(myEmailAccount, myEmailPassword);
			transport.sendMessage(message, message.getAllRecipients());
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		} finally {
			if (transport != null) {
				try {
					transport.close();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("<script>alert('验证邮件已发往邮箱，请进入邮箱查看。验证链接当日有效。');history.go(-1);</script>");
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
