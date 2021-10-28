    <%@ page language="java" import="java.io.*,java.sql.*"%>
        <%@ include file="jdbc.jsp" %>
            <%
	String authenticatedUser = null;
	session = request.getSession(true);
	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }
	if(authenticatedUser != null)
		if(!request.getParameter("productId").equals("null"))
			response.sendRedirect("newReview.jsp?id=" + request.getParameter("productId") + "&name=" + request.getParameter("productName"));
		else if(!request.getParameter("direction").equals("null"))
		{
			if(request.getParameter("direction").equals("checkout"))
			{
			    response.sendRedirect("checkout.jsp");
			}
			else if(request.getParameter("direction").equals("customerInfo"))
			{
			    response.sendRedirect("customer.jsp");
			}

	    }
	    else
	    {
	            response.sendRedirect("index.jsp");
	    }
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
%>
            <%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		if(username == null || password == null)
		{
		        session.setAttribute("loginMessage","Invalid Username and/or Password");
				return null;
		}
		if((username.length() == 0) || (password.length() == 0))
		{
		        session.setAttribute("loginMessage","Invalid Username and/or Password");
				return null;
		}
		try
		{
			getConnection();

			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.

			String SQL= "SELECT userid, password FROM customer WHERE userid=? AND password= ?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rstStr = pstmt.executeQuery();

			rstStr.next();
			if(username.equalsIgnoreCase(rstStr.getString("userid")) && password.equalsIgnoreCase(rstStr.getString("password")))
			retStr = username;
		}
		catch (SQLException ex) {
			out.println(ex);
		}


		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", username);
		}
		else
			session.setAttribute("loginMessage","Invalid Username and/or Password.");
		return retStr;
	}
%>
