<%@ include file="jdbc.jsp" %>
<%@ include file= "sessionAttribute.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
        <html>
        <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <link rel="stylesheet" href="css/checkout.css" />
        <title>MHA CheckOut Line</title>
        </head>
        <header class="header-6" align="centre">
                <div class="header-nav">
                        <a href="index.jsp" class="nav-link nav-text">Home</a>
                        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                </div>
        </header>

        <%
                if(user != null)
                {
                        try
                        {
                                getConnection();
                                String SQL = "SELECT customerId FROM customer WHERE userid = ? ";
			                    String custid = null;
			                    PreparedStatement pstmt = con.prepareStatement(SQL);
			                    pstmt.setString(1, user);
			                    ResultSet rst = pstmt.executeQuery();
                                while(rst.next())
                                {
                                        custid = rst.getString("customerId");
                                }
                                response.sendRedirect("paymentMethod.jsp?customerId=" + custid);
                        }
                        catch(SQLException ex)
                        {
                                System.out.println(ex);
                        }
                }
                else
                {
                        String message = "Please sign in to continue";
                        session.setAttribute("loginMessage", message);
                        response.sendRedirect("login.jsp?direction=checkout");
                }

        %>
        <div id="container2">
                <form name="MyForm" method="get" action="paymentMethod.jsp">
                        <table class="table" style="display:inline">
                                <tr >
                                        <th><font face="Arial, Helvetica, sans-serif" size="2">Customer ID: </font></th>
                                        <th><input type="text" name="customerId"  size="30" maxlength=10></th>
                                </tr>
                                <tr>
                                        <th><font face="Arial, Helvetica, sans-serif" size="2">Password: </font></th>
                                        <th><input type="password" name="password" size="30" maxlength="10"></th>
                                </tr>
                        </table>

                <div style="text-align:center">
                        <input class="btn btn-warning" type="reset" value="Reset">
                        <input class="btn btn-success" type="submit" name="submit" value="Log In">
                </div>
                </form>

        </div>
    </html>
