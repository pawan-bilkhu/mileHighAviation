<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
    <html>
        <head>
            <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
            <link rel="stylesheet" href="css/changeShippingAddress.css" />
            <title>Change Shipping Address</title>
        </head>
        <header class="header-6">
            <div class="header-nav">
                <a href="index.jsp" class="nav-link nav-text">Home</a>
                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
            </div>
        </header>
    <body>
<%
String custid = request.getParameter("customerId");
String direction = request.getParameter("direction");
String payType = request.getParameter("payType");
String payNum = request.getParameter("payNum");

boolean validUser = false;
if(user != null) {
    try {
         getConnection();
         String SQL = "SELECT userid FROM customer WHERE customerId = ? ";
         PreparedStatement pstmt = con.prepareStatement(SQL);
         pstmt.setString(1, custid);
         ResultSet rst = pstmt.executeQuery();
         while(rst.next()) {
            if(rst.getString("userid").equals(user)) {
                validUser = true;
            }
         }
         pstmt.close();
         rst.close();
    } catch(SQLException ex) {
        System.out.println(ex);
    }
}
if(validUser) {
    out.print("<div id=\"container1\">");
    out.print("<h1>Change Shipping Address</h1>");
    out.print("<form method=\"POST\" action=\"updateShippingAddress.jsp?\">");
    out.print("<input type=\"hidden\" name=\"customerId\" value=\"" + custid + "\">");
    out.print("<input type=\"hidden\" name=\"direction\" value=\"" + direction + "\">");
    if(direction.equals("shippingMethod")) {
        out.print("<input type=\"hidden\" name=\"payType\" value=\"" + payType + "\">");
        out.print("<input type=\"hidden\" name=\"payNum\" value=\"" + payNum + "\">");
    }

    out.print("<table class=\"table-compact\">");

    out.print("<tr>");
    out.print("<th colspan=\"3\"><h3>Shipping Info</h3></th>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Address:</font></td>");
    out.print("<td><input type=\"text\" name=\"address\" size=\"50\" maxlength=\"50\" class=\"clr-input\" placeholder=\"123 Richter Street\" required></td>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">City:</font></td>");
    out.print("<td><input type=\"text\" name=\"city\" size=\"50\" maxlength=\"40\" class=\"clr-input\" placeholder=\"Kelowna, Kamloops, etc . . . \"></td>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">State/Province:</font></td>");
    out.print("<td><input type=\"text\" name=\"state\" size=\"50\" maxlength=\"20\" class=\"clr-input\" placeholder=\"British Columbia, California, etc . . . \"></td>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Postal Code/Zip Code:</font></td>");
    out.print("<td><input type=\"text\" name=\"postalCode\" size=\"50\" maxlength=\"20\" class=\"clr-input\" placeholder=\"V1Z2A3, 54130, etc . . .\"></td>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Country:</font></td>");
    out.print("<td><input type=\"text\" name=\"country\" size=\"50\" maxlength=\"40\" class=\"clr-input\" placeholder=\"Canada, United States, etc . . . \"></td>");
    out.print("</tr>");

    out.print("<tr>");
    out.print("<td colspan=\"3\"><span><input type=\"button\" value=\"Go back\" class=\"btn btn-primary btn-sm\" onclick=\"history.back()\"></span><input type=\"submit\" name=\"submit\" size=\"50\" maxlength=\"30\" class=\"btn btn-success btn-sm\" value=\"Submit\"></td>");
    out.print("</tr>");
    out.print("</table>");
    out.print("</form>");
    out.print("</div>");
} else {
    String message = "Access Denied. Please login to view that page";
    session.setAttribute("loginMessage", message);
    if(direction.equals("shippingMethod")){
        response.sendRedirect("checkout.jsp");
    }
    else if (direction.equals("customerInfo")){
        response.sendRedirect("login.jsp?direction=customerInfo");
    }
}
        %>




    </body>
    </html>
