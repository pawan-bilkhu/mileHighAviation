<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file= "sessionAttribute.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
    <html>
    <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <link rel="stylesheet" href="css/paymentMethod.css" />
        <title>Payment Method</title>
    </head>
    <body>
        <div class="main-container">
        <header class="header-6">
            <div class="header-nav">
                <a href="index.jsp" class="nav-link nav-text">Home</a>
                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
            </div>
        </header>
    <div class="content-container">
        <div class="content-area">
        <%
String custid = request.getParameter("customerId");
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
    try
    {
        getConnection();
        String SQL = "SELECT paymentType, paymentNumber, FORMAT(paymentexpiryDate, 'yyyy-MM-dd') FROM paymentmethod WHERE customerId = ?";
        PreparedStatement pstmt = con.prepareStatement(SQL);
        pstmt.setString(1, custid);
        ResultSet rst = pstmt.executeQuery();
        if(rst.next())
        {
            out.println("<h1>Choose your Payment method</h1>");
            out.println("<div style=\"margin:0 auto;text-align:center;display:inline\">");
            out.println("<h3>Payment methods<h3>");
            out.println("<table class=\"table\" style=\"display:inline\">");
            out.println("<tr><th>Type</th><th>Card Number</th><th>Expiry Date</th><th></th>");
            do{

                out.println("<tr>");
                out.println("<td style=\"vertical-align: middle\">" + rst.getString(1) + "</td><td style=\"vertical-align: middle\">" + rst.getString(2) + "</td><td style=\"vertical-align: middle\">" +rst.getString(3)+ "</td>");
                out.println("<td><a href=\"shippingMethod.jsp?customerId=" + custid + "&payType=" +rst.getString(1)+ "&payNum=" +rst.getString(2)+ "\" class=\"btn btn-success-outline btn-sm\">Select</a></td>");
                out.println("</tr>");
            }while(rst.next());
            out.print("<tr><td colspan=\"4\"><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a><a href=\"newPayment.jsp?customerId=" + custid + "&direction=paymentMethod\" class=\"btn btn-primary\">Add new payment method</a></td></tr>");
            out.println("</table>");
            out.println("</div><br>");
        }
        else
        {
            out.println("<h1>You have no Payment methods<h1>");
            out.print("<div class=\"center\"><span><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a></span><span><a href=\"newPayment.jsp?customerId=" + custid + "&direction=paymentMethod\" class=\"btn btn-primary\">Add new payment method</a></span></div>");
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
    String message = "Access Denied";
    session.setAttribute("loginMessage", message);
	response.sendRedirect("login.jsp");
}

        %>
                </div>
            </div>
        </div>
    </body>
</html>
