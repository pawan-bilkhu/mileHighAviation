<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>


<html>
<head>
<title>Product Information</title>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style type="text/css">table, th, td {
    .right text-align: right;}
    h2 {text-align: center;}
    h3 {text-align: center;}
    td {text-align: center;
    vertical-align: middle;}
    </style>
    <style>
    img {
    float: left;
    }
    </style>
    <style>
    .checked {
    color: orange;
    }
    .unchecked{
    color: black;
    }
    </style>

    </head>
<body>
    <div class="main-container">
    <header class="header-6">
    <div class="header-nav">
        <a href="index.jsp" class="nav-link nav-text">Home</a>
        <a href="listprod.jsp" class="active nav-link nav-text">Shop</a>
        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        <%@ include file="adminHeaderNav.jsp" %>
    </div>
    <%@ include file="userHeaderNav.jsp" %>
    </header>
    <div style="margin:0 auto;text-align:center;display:inline">
        <%
// Print prior error login message if present
if (session.getAttribute("InvalidReview") != null)
{
	out.println("<p>"+session.getAttribute("InvalidReview").toString()+"</p>");
	session.setAttribute("InvalidReview", null);
}
// Get product name to search for
String productId = request.getParameter("id");
%>
    </div>
<%
try
{
    getConnection();
    String getRating = "SELECT AVG(reviewRating) FROM review WHERE productId = ?";
    PreparedStatement pstmtR = con.prepareStatement(getRating);
    pstmtR.setString(1, productId);

    ResultSet rstR = pstmtR.executeQuery();

    String a = "un", b = "un", c = "un", d = "un", e = "un";
    int review = 0;
    if(rstR.next()){
        review = rstR.getInt(1);
        switch (review){
            case 1:
                a="";
                break;
            case 2:
                a=""; b="";
                break;
            case 3:
                a=""; b=""; c= "";
                break;
            case 4:
                a=""; b=""; c=""; d="";
                break;
            case 5: a=""; b=""; c=""; d=""; e=""; break;
            }
            pstmtR.close();
            rstR.close();
    }


    // TODO: Retrieve and display info for the product
    String sql = "SELECT productId, productName, productDesc, productPrice, productImageURL FROM product WHERE productId = ?";

    PreparedStatement pstmt = con.prepareStatement(sql);

    pstmt.setString(1, productId);

    ResultSet rst = pstmt.executeQuery();

    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

    while(rst.next())
    {
        out.print("<div style=\"margin:0 auto;text-align:center;display:inline\">");


        out.println("<span class=\"title\"><h1>" + rst.getString(2) +" - " + currFormat.format(rst.getDouble(4)) +  "</h1></span>");

        // Testing purposes:
        // System.out.println(rst.getString(2) + " url: "+ rst.getString(5));

        // TODO: If there is a productImageURL, display using IMG tag

        out.println("<table class=\"table table\">");
        out.println("<tr>");
        if(rst.getString(5) != null)
            out.println("<td rowspan=\"3\"><img src=\"" + rst.getString(5) +"\"></td>");
        out.println("<td><table class=\"table table\"><th>Description</th><tr><span class=\"fa fa-star " +a+ "checked\"></span><span class=\"fa fa-star " +b+ "checked\"></span><span class=\"fa fa-star " +c+ "checked\"></span><span class=\"fa fa-star " +d+ "checked\"></span><span class=\"fa fa-star " +e+ "checked\"></span></td></tr><tr><td style=\"text-align:left\">" + rst.getString(3) + "</td></tr></table>");
        out.println("</tr></table>");
        out.println("</div>");
        // TODO: Add links to Add to Cart and Continue Shopping
        out.println("<div style=\"text-align:center\">");
        out.println("<a href=\"listprod.jsp\" class=\"btn btn-primary\">Return to Product Page</a><a href=\"addcart.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price="+ rst.getDouble(4) + "\" class=\"btn btn-primary\">Add to Cart</a>");
        out.println("<a href=\"newReview.jsp?id=" + rst.getString(1) +  "&name=" + rst.getString(2) + "\" class=\"btn btn-success\">Add Review</a></div>");
    }
    rst.close();
    pstmt.close();


    out.println("<br><br><br>");

    String reviewSQL = "SELECT customerId, reviewComment, FORMAT(reviewDate, 'yyyy-MM-dd') FROM review WHERE productId = ?";

    PreparedStatement pstmt1 = con.prepareStatement(reviewSQL);
    pstmt1.setString(1, productId);
    ResultSet rst1 = pstmt1.executeQuery();

    out.print("<div style=\"margin:0 auto;text-align:center;display:inline\">");

    if(rst1.next()){
            out.print("<h1>Reviews</h1>");
            out.print("<table class=\"table\"");
            out.print("<tr><th>Customer</th><th>Review</th><th>Date</th></tr>");

            do
            {
                if(rst1.getString(2).length() != 0 || rst1.getString(2).equals("null")){
                    out.print("<tr>");
                    out.print("<td>" + rst1.getString(1) + "</td>" + "<td>" + rst1.getString(2) + "</td>" + "<td>" + rst1.getString(3) + "</td>");
                    out.println("</tr>");
                }


            }while(rst1.next());
            out.print("</tr></table>");
        }
        else
            out.println("<h1>No Reviews</h1<");

        out.print("</div>");
    rst1.close();
    pstmt1.close();

}catch(SQLException ex)
{System.out.println(ex);}
%>
    </div>
</body>
</html>

