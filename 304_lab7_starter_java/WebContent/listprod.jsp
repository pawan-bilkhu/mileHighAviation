<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<%@ include file="sessionAttribute.jsp" %>
<!DOCTYPE html>
<html>
<head>
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
    .checked {
    color: orange;
    }
    .unchecked{
    color: black;
    }
    </style>
<title>Shop</title>
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
    <div class="content-container">
        <div class="content-area">
            <div style="text-align:center">
                <h1><span class="title">Search for the Aircrafts you want to buy or filter by Category:</span></h1>
            </div>
            <div style="text-align:center">
                <form class="search" method="get" action="listprod.jsp">
                    <select name="category" id="category">
                        <option value="">All</option>
                        <option value="Australia">Australia</option>
                        <option value="Austria">Austria</option>
                        <option value="Brazil">Brazil</option>
                        <option value="Canada">Canada</option>
                        <option value="China">China</option>
                        <option value="Czech Republic">Czech Republic</option>
                        <option value="European consortium">European consortium</option>
                        <option value="France">France</option>
                        <option value="Germany">Germany</option>
                        <option value="India">India</option>
                        <option value="Israel">Israel</option>
                        <option value="Italy">Italy</option>
                        <option value="Japan">Japan</option>
                        <option value="Netherlands">Netherlands</option>
                        <option value="New Zealand">New Zealand</option>
                        <option value="Poland">Poland</option>
                        <option value="Russia">Russia</option>
                        <option value="Singapore">Singapore</option>
                        <option value="Spain">Spain</option>
                        <option value="Sweden">Sweden</option>
                        <option value="Switzerland">Switzerland</option>
                        <option value="Ukraine">Ukraine</option>
                        <option value="United Kingdom">United Kingdom</option>
                        <option value= "United States of America">United States</option>
                    </select>
                    <label for="search_input">
                        <input id="search_input" type="text" name="productName" size="25" placeholder="Leave blank for all products">
                        <input class="btn btn-success-outline btn-sm" type="submit" value="Submit"><input class="btn btn-warning-outline btn-sm" type="reset" value="Reset">
                    </label>
                </form>
            </div>
<% // Get product name to search for
String name = request.getParameter("productName");
String cat = request.getParameter("category");

//Note: Forces loading of SQL Server driver


// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try
{
    getConnection();
    String sql = "SELECT productId, productName, productOrigin, productPrice FROM product";
    PreparedStatement pstmt = null;
    ResultSet rst = null;
    boolean hasName = name != null && !name.equals("");
    boolean hasCategory = cat != null && !cat.equals("0");

    pstmt = con.prepareStatement(sql);

    if(!hasName)
    {

        if(!hasCategory){
            sql += " ORDER BY productName ASC";
            pstmt = con.prepareStatement(sql);
         }
        else
        {
            cat = "%" + cat + "%";
            sql += " WHERE productOrigin LIKE ? ORDER BY productName ASC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, cat);
        }
    }
    else
    {
        name = name + "%";
        if(!hasCategory)
        {

            sql += " WHERE productName LIKE ? ORDER BY productName ASC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
        }
        else
        {
             cat = "%" + cat + "%";
             sql += " WHERE productName LIKE ? AND productOrigin LIKE ? ORDER BY productName ASC";
             pstmt = con.prepareStatement(sql);
             pstmt.setString(1, name);
             pstmt.setString(2, cat);
        }
    }

    rst = pstmt.executeQuery();

    out.println("<table class=\"table\">");
    out.println("<tr><th>Name</th><th>Country Origin</th><th>Price</th><th>Rating</th><th></th></tr>");
    while(rst.next())
    {
        out.println("<tr>");
        out.println("<td style=\"vertical-align: middle\"><a href=\"product.jsp?id=" + rst.getString(1) + "\">" + rst.getString(2) + "</a></td>");
        out.println("<td style=\"vertical-align: middle\">" + rst.getString(3) +  "</td>");
        out.println("<td style=\"vertical-align: middle\">" + currFormat.format(rst.getDouble(4)) +  "</td>");
        // For each product create a link of the form


        String getRating = "SELECT AVG(reviewRating) FROM review WHERE productId = ?";
        PreparedStatement pstmtR = con.prepareStatement(getRating);

        pstmtR.setString(1, rst.getString(1));

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
        }
        out.println("<td style =\"vertical-align: middle\"><span class=\"fa fa-star " +a+ "checked\"><span class=\"fa fa-star " +b+ "checked\"></span><span class=\"fa fa-star " +c+ "checked\"></span><span class=\"fa fa-star " +d+ "checked\"></span><span class=\"fa fa-star " +e+ "checked\"></span></span></td>");
        out.println("<td style=\"vertical-align: middle\"><a href=\"addcart.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price="+ rst.getDouble(4) + "\" class=\"btn btn-info-outline\">Add to Cart</a></td>");
        out.println("</tr>");
        out.println("</tr>");
        pstmtR.close();
        rstR.close();
    }
    out.println("</table>");
    // Close connection
    rst.close();
    pstmt.close();

}catch(SQLException ex)
{System.out.println(ex);}
%>
                </div>
            </div>
        </div>
    </body>
</html>
