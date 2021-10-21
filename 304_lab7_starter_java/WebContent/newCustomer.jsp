<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
    <!DOCTYPE html>
    <html>

        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <head>
        <title>Customer Page</title>
    </head>
    <body>
    <div class="main-container">
        <header class="header-6" align="centre">
            <div class="header-nav">
                <a href="index.jsp" class="nav-link nav-text">Home</a>
                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
            </div>
        </header>
    <div class="content-container">
        <div class="content-area">
            <div style="margin:0 auto;text-align:center;display:inline">
    <%
        // Print prior error login message if present
if (session.getAttribute("InvalidUserId") != null)
{
	out.println("<p>"+session.getAttribute("InvalidUserId").toString()+"</p>");
	session.setAttribute("InvalidUserId", null);
	}
%>
        <h1>Create your account</h1>
        <form method="get" action="registerCustomer.jsp">
            <table class="table-compact" style="display:inline">
                <tr>
                    <th colspan=2><h3>User Info</h3></th>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">First name:</font></td>
                    <td><input id="firstName" type="text" name="firstName"  size="40" maxlength="40" class="clr-input" placeholder="John" required></td>
                    <td>

                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2" >Last name:</font></td>
                    <td><input type="text" name="lastName"  size="50" maxlength="40" class="clr-input" placeholder="Doe" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></td>
                    <td><input type="email" name="email" size="50" maxlength="50" class="clr-input" placeholder="example@mha.ca" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Phone number:</font></td>
                    <td><input type="tel" name="phoneNo" size="50" maxlength="10" class="clr-input" placeholder="1234567890" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></td>
                    <td><input type="text" name="address" size="50" maxlength="50" class="clr-input" placeholder="123 Richter Street" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">City:</font></td>
                    <td><input type="text" name="city" size="50" maxlength="40" class="clr-input" placeholder="Kelowna, Kamloops, etc . . . "></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">State/Province:</font></td>
                    <td><input type="text" name="state" size="50" maxlength="20" class="clr-input" placeholder="BC, AB, etc . . . "></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Postal Code/Zip Code:</font></td>
                    <td><input type="text" name="postalCode" size="50" maxlength="20" class="clr-input" placeholder="V1Z 2A3, 54130, etc . . ."></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></td>
                    <td><input type="text" name="country" size="50" maxlength="40" class="clr-input" placeholder="Canada, United States, etc . . . "></td>
                </tr>
                <th colspan=2><h3>Pick a Username and Password</h3></th>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></td>
                    <td><input type="text" name="userid" size="50" maxlength="20" class="clr-input" placeholder="Enter a username" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></td>
                    <td><input type="password" name="password" size="50" maxlength="30" class="clr-input" placeholder="Enter a password" required></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" value="Go back" class="btn btn-primary-outline btn-sm" onclick="history.back()"></span><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success-outline btn-sm" value="Create Account"></td>
                </tr>

                </tr>
            </table>
        </form>

    </div>


            </div>
        </div>
    </div>
    </body>
    </html>