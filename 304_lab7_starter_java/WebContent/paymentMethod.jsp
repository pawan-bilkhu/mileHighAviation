<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
    <html>
    <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <style type="text/css">table, th, td {
            .right text-align: right;}
            h2 {text-align: center;}
            h3 {text-align: center;}
            td {text-align: center;
            vertical-align: middle;}
        </style>
        <title>Create Payment Method</title>
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
String pass = request.getParameter("password");
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
   String sql = "SELECT paymentType, paymentNumber, FORMAT(paymentexpiryDate, 'yyyy-MM-dd') FROM paymentmethod WHERE customerId = ?";
   PreparedStatement pstmt = con.prepareStatement(sql);
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
            out.println("<td><a href=\"shippingMethod.jsp?customerId=" + custid + "&password=" +pass+ "&payType=" +rst.getString(1)+ "&payNum=" +rst.getString(2)+ "\" class=\"btn btn-success-outline btn-sm\">Select</a></td>");
            out.println("</tr>");
        }while(rst.next());
        out.print("<tr><td colspan=\"4\"><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a><a href=\"newPayment.jsp?customerId=" + custid + "&password=" + pass +"\" class=\"btn btn-primary\">Add new payment method</a></td></tr>");
        out.println("</table>");
        out.println("</div><br>");
   }
   else
   {
        out.println("<h1>You have no Payment methods<h1>");
        out.print("<div style=\"text-align:center\"><span><a href=\"showcart.jsp\" class=\"btn btn-primary\">Return to cart</a></span><span><a href=\"newPayment.jsp?customerId=" + custid + "&password=" + pass +"\" class=\"btn btn-primary\">Add new payment method</a></span></div>");
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