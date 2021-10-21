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
        <div id="container1"><h1>Log in to complete the transaction:</h1>

<%@ include file= "sessionAttribute.jsp" %>
        </div>
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
