<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp"%>
<%@ include file="auth.jsp"%>
<%@ include file="sessionAttribute.jsp"%>
<!DOCTYPE html>
<html>
        <head>
                <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
                <title>Customer list</title>
        </head>
        <body>
        <div class="main-container">
                <header class="header-6">
                        <div class="header-nav">
                                <a href="index.jsp" class="nav-link nav-text">Home</a>
                                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                                <%@ include file="adminHeaderNav.jsp"%>
                        </div>
        <%@ include file="userHeaderNav.jsp"%>


</header>
                        <div style="text-align:center">
                                <h1>Customer List</h1>
                        </div>


            <%
	if(user!= null && user.equalsIgnoreCase("admin")){
    try
    {
        getConnection();
        String sql = "SELECT * FROM CustView";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rst = pstmt.executeQuery();
        out.println("<table class=\"table table-compact\" ><tr><th>Customer Id</th><th>First Name</th><th>Last Name</th><th>Userid</th></tr>");
        while(rst.next())
        {
	        out.println("<tr>");
	        out.println("<td>" + rst.getString(1) + "</td>");
	        out.println("<td>" + rst.getString(2) + "</td>");
	        out.println("<td>" + rst.getString(3) + "</td>");
	        out.println("<td>" + rst.getString(4) + "</td>");
	        // Display user's passwords, was only used for testing purposes
	        // out.println("<td>" + rst.getString(5) + "</td>");
	        out.println("</tr>");
        }
        pstmt.close();
	    rst.close();
	    out.println("</table>");
    }
    catch(SQLException ex)
{System.out.println(ex);}
	}
	else{
		out.println("<div style=\"margin:0 auto;text-align:center;display:inline\">");
		out.println("<h1> Unauthorized User!</h1></div>");
	}
    %>
        </div>
        </body>
        </html>
