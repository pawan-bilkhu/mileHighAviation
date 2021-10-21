<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
        <html>
                <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
                <link rel="stylesheet" href="css/admin.css">
                <head>
                        <title>Administrator Page</title>
                </head>
                <body>
                <div class="main-container">
                        <header class="header-6" align="centre">
                                <div class="header-nav">
                                        <a href="index.jsp" class="nav-link nav-text">Home</a>
                                        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                                        <%@ include file="adminHeaderNav.jsp" %>
                                </div>
<%@ include file="userHeaderNav.jsp" %>
                </header>
                        <%
        out.println("<div id=\"table1\">");
if(user!= null && user.equalsIgnoreCase("admin")){
    //NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    try ( Connection con = DriverManager.getConnection(url, uid, pw);)
    {
        out.println("<h1> Administrator Sales Report by Day</h1>");
        String SQL = "SELECT FORMAT(orderDate, 'yyyy-MM-dd'), SUM(totalAmount) FROM ordersummary GROUP BY FORMAT(orderDate, 'yyyy-MM-dd') ";
        PreparedStatement pstmt= con.prepareStatement(SQL);
        ResultSet rst = pstmt.executeQuery();
        out.print("<table class=\"table\"><tr><th>Order Date</th><th>Total Order Amount </th></tr>");

        while(rst.next()){
                out.print("<tr><td>"+rst.getString(1)+"</td> ");
                out.print("<td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
        }
        rst.close();
        pstmt.close();
    }
}
else{
    out.println("<h1> Unauthorized User!</h1>");
}
%>

                </table>
                </div>
            </div>
    </body>
</html>
