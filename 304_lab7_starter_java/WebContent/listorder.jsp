<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<%@ include file="sessionAttribute.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <style type="text/css">table, th, td {
    border: 1px solid black;
    .right text-align: right;
    }</style>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
<title>MHA Grocery Order List</title>
</head>
<body>
<div class="main-container">
<header class="header-6">
    <div class="header-nav">
        <a href="index.jsp" class="nav-link nav-text">Home</a>
        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        <%@ include file="adminHeaderNav.jsp" %>
    </div>
    <%@ include file="userHeaderNav.jsp" %>
</header>
    <div style="text-align:center">
        <h1>Order List</h1>
    </div>



<%

try{
    getConnection();


    // Write query to retrieve all order summary records
    String sql = "SELECT orderId, orderDate, ordersummary.customerId, firstName, lastName, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId";
    PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);



	while (rst.next())
	{
	    out.println("<table class=\"table table-compact\" ><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th>" + "<th>Customer Name</th><th>Total Amount</th></tr>");
	    // Print out the order summary information
	    out.println("<tr>");
	    out.println("<td>" + rst.getString(1) + "</td>");
	    out.println("<td>" + rst.getTimestamp(2) + "</td>");
	    out.println("<td>" + rst.getString(3) + "</td>");
	    out.println("<td>" + rst.getString(4) + " " + rst.getString(5) + "</td>");
	    out.println("<td>" + currFormat.format(rst.getDouble(6)) + "</td>");
	    out.println("</tr>");
	    String fullAddress = rst.getString(7) + ", " + rst.getString(8) + ", " + rst.getString(9) + ", " + rst.getString(10) + ", " + rst.getString(11);
	    out.println("<tr>");
	    out.println("<th>Shipped to</th>");
	    out.println("<td colspan=\"4\">" + fullAddress + "</td>");
	    out.println("</tr>");

	    // Write a query to retrieve the products in the order
	    //   - Use a PreparedStatement as will repeat this query many times
        String sql1 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
	    PreparedStatement pstmt1 = con.prepareStatement(sql1);
	    pstmt1.setString(1, rst.getString(1));
	    ResultSet rst1 = pstmt1.executeQuery();


        out.println("<tr>");
        out.println("<td colspan=\"5\" >");
        out.println("<table align=\"right\"><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");
        // For each product in the order
        while(rst1.next())
        {
            out.println("<tr>");
            // Write out product information
            out.println("<td>" + rst1.getString(1)+ "</td>");
            out.println("<td>" + rst1.getString(2)+ "</td>");
            out.println("<td>" + currFormat.format(rst1.getDouble(3))+ "</td>");
            out.println("</tr>");

        }
        out.println("</table></td></tr>");
        pstmt1.close();

	}
	pstmt.close();
	rst.close();
	out.println("</tr></table>");
}
catch(SQLException ex)
{System.out.println(ex);}
// Close connection
%>
</div>
</body>
</html>

