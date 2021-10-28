<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file= "sessionAttribute.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
    <html>
    <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <title>Shipping Address</title>
    </head>
    <header class="header-6">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        </div>
    </header>
<body>
<div class="main-container">
    <div class="content-container">
        <div class="content-area">
            <%
String custid = request.getParameter("customerId");
String payType = request.getParameter("payType");
String payNum = request.getParameter("payNum");
boolean validUser = false;
if(user != null)
{
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
            {
                validUser = true;
            }

         }
         pstmt.close();
         rst.close();
    }
    catch(SQLException ex)
    {
        System.out.println(ex);
    }
}

if(validUser)
{
   out.println("<div style=\"margin:0 auto;text-align:center;display:inline\">");
   try{

        String sql = "SELECT address, city, state, postalCode, country FROM customer WHERE customerId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, custid);
        ResultSet rst = pstmt.executeQuery();
        if(rst.next())
        {
            out.println("<div style=\"margin:0 auto;text-align:center;display:inline\">");
            out.println("<h1>Your Shipping Address<h1>");
            out.println("<table class=\"table\" style=\"display:inline\">");
            out.println("<th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th>");
            out.println("<tr>");
            out.println("<td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>" +rst.getString(3)+ "</td><td>" +rst.getString(4)+ "</td><td>" +rst.getString(5)+ "</td>");
            out.println("</tr>");
            out.print("<tr><td colspan=\"5\"><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a><a href=\"changeShippingAddress.jsp?customerId=" + custid
                + "&payType=" + payType
                + "&payNum=" + payNum
                + "&direction=shippingMethod"
                + "\" class=\"btn btn-primary\">Change Shipping Address</a>");

            out.println("<a href=\"order.jsp?customerId=" + custid
                + "&payType=" + payType
                + "&payNum=" + payNum
                +"\" class=\"btn btn-primary\">Confirm Order</a></td></tr>");

        out.println("</table>");
        out.println("</div><br>");
        }
        else
        {
            out.println("<h1>You have no Shipping Address<h1>");
            out.print("<div style=\"text-align:center\"><span><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a></span><span><a href=\"changeShippingAddress.jsp?customerId=" + custid
                + "&payType=" + payType
                + "&payNum=" + payNum
                + "&direction=shippingMethod"
                + "\" class=\"btn btn-primary\">Change Shipping Address</a></span></div>");
        }

        pstmt.close();
        rst.close();
   }
   catch(SQLException ex)
   {
        System.out.println(ex);
   }
}
else
{
	String message = "Incorrect Customer ID and/or Password";
    session.setAttribute("loginMessage", message);
	response.sendRedirect("checkout.jsp");
}




        %>
                </div>
            </div>
        </div>
    </body>
</html>
