<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
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
String pass = request.getParameter("password");
String payType = request.getParameter("payType");
String payNum = request.getParameter("payNum");
out.println("<div style=\"margin:0 auto;text-align:center;display:inline\">");
try
{
   getConnection();
        String valCustSql = "SELECT customerId, password FROM customer ";
		PreparedStatement pstmt1=null;
		ResultSet rst1 = null;
		pstmt1 = con.prepareStatement(valCustSql);
		rst1 = pstmt1.executeQuery();
		boolean validUser = false;
		boolean validPass = false;
		while(rst1.next())
		{
			if(custid.equals(rst1.getString(1))){
				validUser = true;
				if(pass.contentEquals(rst1.getString(2)))
					validPass = true;
					break;
			}
		}
   if(validUser && validPass)
   {
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
            + "&password=" + pass
            + "&payType=" + payType
            + "&payNum=" + payNum
            + "\" class=\"btn btn-primary\">Change Shipping Address</a>");

       out.println("<a href=\"order.jsp?customerId=" + custid
            + "&password=" + pass
            + "&payType=" + payType
            + "&payNum=" + payNum
            +"\" class=\"btn btn-primary\">Confirm Order</a></td></tr>");

        out.println("</table>");
        out.println("</div><br>");
   }
   else
   {
        out.println("<h1>You have no Shipping Address<h1>");
        out.print("<div style=\"text-align:center\"><span><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a></span><span><<a href=\"changeShippingAddress.jsp?customerId=" + custid + "\" class=\"btn btn-primary\">Change Shipping Address</a></span></div>");
   }

   pstmt.close();
   rst.close();
   }
    else
		{
			String message = "Incorrect Customer ID and/or Password";
            session.setAttribute("loginMessage", message);
		    response.sendRedirect("checkout.jsp");
		}
}catch(SQLException ex)
{System.out.println(ex);}
        %>
                </div>
            </div>
        </div>
    </body>
</html>