<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp"%>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <head>
        <title>Manage Database</title>
    </head>
    <body>
        <header class="header-6" align="centre">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
            <%@ include file="adminHeaderNav.jsp"%>
        </div>
        <%@ include file="userHeaderNav.jsp" %>
        </header>
    </body>
    <div class="main-container">
    <div style="margin:0 auto;text-align:center;display:inline">
<%
    // Print prior error login message if present
    if (session.getAttribute("InvalidProduct") != null){
        out.println("<p>"+session.getAttribute("InvalidProduct").toString()+"</p>");
        session.setAttribute("InvalidProduct", null);
    }
    if (session.getAttribute("InvalidDelete") != null){
        out.println("<p>"+session.getAttribute("InvalidDelete").toString()+"</p>");
        session.setAttribute("InvalidDelete", null);
    }
if(user== null || !user.equalsIgnoreCase("admin")){
        response.sendRedirect("login.jsp");
    }
%>
        <h1>Reset Database from default</h1>
        <div  style="text-align:center">
            <span><a href="loaddata.jsp" class="btn btn-primary btn-sm">Reload</a></span>
        </div>
        <h1>Add a Product to the Database</h1>
        <form method="get" action="registerProduct.jsp">
            <table class="table-compact" style="display:inline">
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></td>
                    <td><input id="productname" type="text" name="productname"  size="50" maxlength="500" class="clr-input" placeholder="AASI Jetcruzer, ATR ATR-72, etc . . ." required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2" >Product Price:</font></td>
                    <td><input type="number" step="0.01" name="price"  size="50" maxlength="10" class="clr-input" min="0" placeholder="$0.00" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Product Origin:</font></td>
                    <td><input type="text" name="origin" size="50" maxlength="30" class="clr-input" placeholder="Canada, United States, etc . . . " required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Description:</font></td>
                    <td><input type="text" name="desc" size="50" maxlength="1000" class="clr-input" placeholder="Optional"></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success btn-sm" value="Add"></td>
                </tr>
            </table>
        </form>
        <h1>Delete a Product from the Database</h1>
        <form method="get" action="deleteProduct.jsp">
            <table class="table-compact" style="display:inline">
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></td>
                    <td><input id="productname" type="text" name="productname"  size="50" maxlength="40" class="clr-input" placeholder="AASI Jetcruzer, ATR ATR-72, etc . . ." required></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-warning btn-sm" value="Delete"></td>
                </tr>
            </table>
        </form>

        <h1>Update an Existing Product</h1>
        <form method="get" action="updateProduct.jsp">
            <table class="table-compact" style="display:inline">
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></td>
                    <td><input id="productname" type="text" name="productname"  size="50" maxlength="40" class="clr-input" placeholder="AASI Jetcruzer, ATR ATR-72, etc . . ." required></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success btn-sm" value="Search"></td>
                </tr>
            </table>
        </form>
    </div>
    <br>
    <br>
    <div  style="text-align:center"><span><a href="index.jsp" class="btn btn-primary">Go back</a></span></div>
    </div>
</html>



