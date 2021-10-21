<%@ page import="java.text.NumberFormat" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .checked {
        color: orange;
        }
        .unchecked{
        color: black;
        }
    </style>
        <head>
            <title>Review Page</title>
        </head>
            <body>
            <div class="main-conatiner">
                <header class="header-6" align="centre">
                    <div class="header-nav">
                        <a href="index.jsp" class="nav-link nav-text">Home</a>
                        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                        <%@ include file="adminHeaderNav.jsp" %>
                    </div>
    <%
            out.println("<div class=\"header-actions\">");
            if( user != null){
                out.println("<a class=\"nav-link nav-text\"><span class=\"nav-text\"> Logged in as: " + user + "</span></a>");
                out.println("<a href=\"logout.jsp\" class=\"nav-link nav-text\"><span class=\"nav-text\">Logout</span></a>");
            }
            else{
                String message = "You must sign in to review a product";
                session.setAttribute("loginMessage", message);
                response.sendRedirect("login.jsp?id=" + request.getParameter("id") + "&name=" + request.getParameter("name"));
            }
            out.println("</div>");%>
        </header>
            <div class="content-container">
                <div class="content-area">

        <div style="margin:0 auto;text-align:center;display:inline">
<% out.println("<h1>Write a review for: "+request.getParameter("name"));
%>
            <form method="get" action="registerReview.jsp">
<%
            String custID = null;
            try{
                getConnection();
                String getCustId = "SELECT customerId FROM customer WHERE userid = ?";
                PreparedStatement pstmt = con.prepareStatement(getCustId);
                pstmt.setString(1, user);
                ResultSet rst = pstmt.executeQuery();
                rst.next();
                custID= rst.getString(1);
            }
            catch(SQLException ex)
            {System.out.println(ex);}
            out.print("<input type=\"hidden\" name=\"customerId\" value=\"" +custID+ "\">");
            out.print("<input type=\"hidden\" name=\"productId\" value=\"" +request.getParameter("id")+ "\">");
%>
                <table class="table-compact" style="display:inline">
                    <tr>
                        <td><textarea name="comment" cols="50" rows="5" class="clr-textarea" placeholder="Tell us what you think..."></textarea></td>
                    </tr>
                </table><br>
                <table class="table" style="display:inline">
                    <tr>
                        <th colspan="5"><font face="Arial, Helvetica, sans-serif" size="2">Rating:</font></th>
                    </tr>
                    <tr>
                        <td><input type="radio" id="rating" name="rating" value="1" required><label for="rating"><span class="fa fa-star checked" style="font-size:20px"></span></label></td>
                        <td><input type="radio" id="rating" name="rating" value="2" required><label for="rating"><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span></label></td>
                        <td><input type="radio" id="rating" name="rating" value="3" required><label for="rating"><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span></label></td>
                        <td><input type="radio" id="rating" name="rating" value="4" required><label for="rating"><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span></label></td>
                        <td><input type="radio" id="rating" name="rating" value="5" required><label for="rating"><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span><span class="fa fa-star checked" style="font-size:20px"></span></label></td>
                    </tr>
                    <tr>
                        <td colspan="5"> <% out.println("<span><a href=\"product.jsp?id=" + request.getParameter("id") + "\" class=\"btn btn-primary btn-sm\">Go back</a>"); %>
    </span><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success btn-sm" value="Confirm"></td>
                    </tr>
                </table>
        </form>

        </div>

                </div>
            </div>
        </div>
    </body>
</html>