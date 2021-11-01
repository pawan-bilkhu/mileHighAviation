<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file= "sessionAttribute.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
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
        String payType = request.getParameter("payType");
        String payNum = request.getParameter("payNum");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String direction = request.getParameter("direction");

    try{
        getConnection();
        String updateSQL = "UPDATE customer SET address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE customerId = ?";
        PreparedStatement pstmt= con.prepareStatement(updateSQL);
        pstmt.setString(1, address);
        pstmt.setString(2, city);
        pstmt.setString(3, state);
        pstmt.setString(4, postalCode);
        pstmt.setString(5, country);
        pstmt.setString(6, custid);
        pstmt.executeUpdate();
        pstmt.close();

        if(direction.equals("customerInfo")){
            response.sendRedirect("customer.jsp?id=" + custid);
        }
        else if(direction.equals("shippingMethod"))
        {
            response.sendRedirect("shippingMethod.jsp?customerId=" + custid + "&payType=" + payType + "&payNum=" + payNum);
        }


    }catch(SQLException ex)
    {System.out.println(ex);}

    %>





    </body>
</html>
