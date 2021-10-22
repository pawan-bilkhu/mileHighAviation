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
if(custid != null && user != null)
{
        try
        {
                getConnection();
	            String SQL = "SELECT  firstName, lastName, email, phonenum, password, address, city, state, postalCode, country FROM customer WHERE customerId = ? ";
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
                        String address = rst.getString("address");
                        String city = rst.getString("city");
                        String state = rst.getString("state");
                        String pcode = rst.getString("postalCode");
                        String country = rst.getString("country");

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
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Address:</font></td>");
                        out.print("<td><input type=\"text\" name=\"address\" size=\"50\" maxlength=\"50\" class=\"clr-input\" value=\"" + address + "\"></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">City:</font></td>");
                        out.println("<td><input type=\"text\" name=\"city\" size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + city + "\"></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">State/Province:</font></td>");
                        out.println("<td><input type=\"text\" name=\"state\" size=\"50\" maxlength=\"20\" class=\"clr-input\" value=\"" + state + "\"></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Postal Code/Zip Code:</font></td>");
                        out.print("<td><input type=\"text\" name=\"postalCode\" size=\"50\" maxlength=\"20\" class=\"clr-input\" value=\"" + pcode + "\"></td>");
                        out.print("</tr>");

                        out.print("<tr>");
                        out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Country:</font></td>");
                        out.print("<td><input type=\"text\" name=\"country\" size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + country + "\"></td>");
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
{
        out.print("<h1>Unauthorized Access. Please login to view this page.<h1>");
        out.print("<a href=\"login.jsp\">Go to Login</a>");
}
%>
        </div>
        </html>

