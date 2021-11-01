<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp"%>
<!DOCTYPE html>
        <html>
                <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
                <link rel="stylesheet" href="css/changeCustomer.css" />
                <head>
                        <title>Update Customer</title>
                </head>
                <body>
                        <header class="header-6" align="centre">
                        <div class="header-nav">
                                <a href="index.jsp" class="nav-link nav-text">Home</a>
                                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                                <%@ include file="adminHeaderNav.jsp"%>
                        </div>

                        </header>
                </body>
                <div id="table1">
<%@ include file="sessionAttribute.jsp" %>

<%
String custid = request.getParameter("id");
boolean userMatch = false;
try
{
        getConnection();
        String SQL = "SELECT userid FROM customer WHERE customerId = ? ";
		PreparedStatement pstmt = con.prepareStatement(SQL);
        pstmt.setString(1, custid);
        ResultSet rst = pstmt.executeQuery();
        while(rst.next())
        {
                if(rst.getString("userid").equals(user))
                        userMatch = true;
        }
}
catch(SQLException e)
{
        out.println(e);
}
if(custid != null && user != null && userMatch)
{
        // out.print(user);
        try
        {
                getConnection();
	            String SQL = "SELECT  firstName, lastName, email, phonenum, password FROM customer WHERE customerId = ? ";
		        PreparedStatement pstmt = con.prepareStatement(SQL);
		        pstmt.setString(1, custid);
		        ResultSet rst = pstmt.executeQuery();
                while(rst.next())
                {
                        String fname = rst.getString("firstName");
                        String lname = rst.getString("lastName");
                        String email = rst.getString("email");
                        String phoneNo = rst.getString("phonenum");
                        String password = rst.getString("password");
		                out.print("<h1>Update your Account</h1>");
		                out.print("<form method=\"POST\" action=\"updateCustomer.jsp\">");
		                out.print("<input type=\"hidden\" name=\"customerId\" value=\"" + custid + "\">");
		                out.print("<table class=\"table-compact\">");

		                out.print("<tr>");
		                out.print("<th colspan=\"2\"><h3>User Info</h3></th>");
		                out.print("</tr>");

		                out.print("<tr>");
		                out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">First name:</font></td>");
		                out.print("<td><input id=\"firstName\" type=\"text\" name=\"firstName\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + fname + "\" required></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\" >Last name:</font></td>");
                        out.print("<td><input id=\"lastName\" type=\"text\" name=\"lastName\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + lname + "\" required></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Email:</font></td>");
                        out.print("<td><input id=\"email\" type=\"email\" name=\"email\"  size=\"50\" maxlength=\"50\" class=\"clr-input\" value=\"" + email + "\" required></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Phone number:</font></td>");
                        out.print("<td><input id=\"phoneNo\" type=\"tel\" name=\"phoneNo\"  size=\"50\" maxlength=\"10\" class=\"clr-input\" value=\"" + phoneNo + "\" pattern=\"[0-9]{3}[0-9]{3}[0-9]{4}\" required></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Password:</font></td>");
                        out.println("<td><input type=\"password\" name=\"password\" size=\"50\" maxlength=\"30\" class=\"clr-input\" value=\"" + password + "\" required></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td colspan=\"2\"><input type=\"button\" value=\"Go back\" class=\"btn btn-primary btn-sm\" onclick=\"history.back()\"><input type=\"submit\" name=\"submit\" size=\"50\" maxlength=\"30\" class=\"btn btn-success btn-sm\" value=\"Submit\"></td>");
                        out.print("</tr>");
                }
                out.print("<table>");
                out.print("<form>");
	    }
        catch(SQLException e)
	    {
		        out.println(e);
	    }

}
else
{       String accessMessage = "<h1>Access Denied.";
        String loginMessage = "";
        out.print("<h1>");
        if(user == null || custid == null)
        {
               accessMessage = accessMessage + " Please login to view this page.";
               loginMessage = "<h3><a href=\"login.jsp\">Go to Login</a></h3>";
        }
        accessMessage = accessMessage + "</h1>";
        out.print(accessMessage);
        out.print(loginMessage);
        out.print("<h3><a href=\"index.jsp\">Home</a></h3>");
}
%>
        </div>
        </html>

