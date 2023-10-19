package com.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mycart.FactoryProvider;
import com.mycart.dao.UserDAO;
import com.mycart.entities.User;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out=response.getWriter()) {
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			
			//validations 
			
			//authentication of user
			UserDAO userDao=new UserDAO(FactoryProvider.getFactory());
			User user=userDao.getEmailAndPassword(email, password);
			//System.out.println(user);
			HttpSession httpSession= request.getSession();
			if(user==null) {
				httpSession.setAttribute("message","Invalid Details !! Try with another one" );
				response.sendRedirect("login.jsp");
				return;
			}
			else
			{
				//out.println("<h1>Welcome "+user.getUserName()+" </h1>");
				//login
				httpSession.setAttribute("current-user", user);
				if(user.getUserType().equals("admin"))
				{   //admin-admin.jsp
					response.sendRedirect("admin.jsp");
				}
				else if(user.getUserType().equals("normal"))
				{   //normal-normal.jsp
					response.sendRedirect("normal.jsp");
				}
				else
				{
					out.println("We have not identified User Type");
				}
				
			}
		}
		
	}

}
