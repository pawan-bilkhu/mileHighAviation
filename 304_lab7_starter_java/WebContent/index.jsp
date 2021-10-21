<%@ include file="getAuthenticatedUser.jsp"%>
<!DOCTYPE html>
<html>
<head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <link rel="stylesheet" href="path/to/node_modules/@clr/icons/clr-icons.min.css">
        <title>Mile High Aviation Home Page</title>
</head>
        <script src="path/to/node_modules/@clr/icons/clr-icons.min.js"></script>

        <div class="main-container">
                <header class="header-6" align="centre">
                        <div class="header-nav">
                                <a href="index.jsp" class="active nav-link nav-text">Home</a>
                                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>

                                <%@ include file="adminHeaderNav.jsp" %>
                        </div>
                        <%@ include file="userHeaderNav.jsp" %>
                </header>

                <div style="margin:0 auto;text-align:center;display:inline">

                        <%@ include file="sessionAttribute.jsp" %>

                        <h1>Welcome</h1>
                        <img src="img/98.png">
                        <table class="table">
                                <tr>
                                        <th><h1><a href="listprod.jsp">Begin Shopping</a></h1></th>
                                </tr>
                                <tr>
                                        <th><h1><a href="customer.jsp">Customer Info</a></h1></th>
                                </tr>
                        </table>

                </div>
        </div>
</body>
</html>


