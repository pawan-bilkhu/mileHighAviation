<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp"%>
<!DOCTYPE html>
        <html>
                <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
                <link rel="stylesheet" href="css/changeCustomer.css" />
                <head>
                        <title>Update Customer</title>
                </head>
                <body>
                        <header class="header-6" align="centre">
                        <div class="header-nav">
                                <a href="index.jsp" class="nav-link nav-text">Home</a>
                                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                                <%@ include file="adminHeaderNav.jsp"%>
                        </div>

                        </header>
                </body>
                <div id="table1">
<%@ include file="sessionAttribute.jsp" %>

<%
// retrieve data embedded in link from previous page
String custid = request.getParameter("id");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String phoneNo = request.getParameter("phoneNo");
String password = request.getParameter("password");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String pcode = request.getParameter("postalCode");
String country = request.getParameter("country");
// Print an error message if the user is invalid
%>
                        <h1>Update your Account</h1>
                        <form method="get" action="updateCustomer.jsp">
                                <% out.println("<input type=\"hidden\" name=\"customerId\" value=\"" + custid + "\">"); %>
                                <table class="table-compact">
                                        <tr>
                                                <th colspan=2><h3>User Info</h3></th>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">First name:</font></td>
                                                <% out.println("<td><input id=\"firstName\" type=\"text\" name=\"firstName\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + fname + "\" required></td>");%>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2" >Last name:</font></td>
                                                <% out.println("<td><input id=\"lastName\" type=\"text\" name=\"lastName\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + lname + "\" required></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></td>
                                                <% out.println("<td><input id=\"email\" type=\"email\" name=\"email\"  size=\"50\" maxlength=\"50\" class=\"clr-input\" value=\"" + email + "\" required></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Phone number:</font></td>
                                                <% out.println("<td><input id=\"phoneNo\" type=\"tel\" name=\"phoneNo\"  size=\"50\" maxlength=\"10\" class=\"clr-input\" value=\"" + phoneNo + "\" pattern=\"[0-9]{3}[0-9]{3}[0-9]{4}\" required></td>"); %>
                                        </tr>

                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></td>
                                                <% out.println("<td><input type=\"text\" name=\"address\" size=\"50\" maxlength=\"50\" class=\"clr-input\" value=\"" + address + "\"></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">City:</font></td>
                                                <% out.println("<td><input type=\"text\" name=\"city\" size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + city + "\"></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">State/Province:</font></td>
                                                <% out.println("<td><input type=\"text\" name=\"state\" size=\"50\" maxlength=\"20\" class=\"clr-input\" value=\"" + state + "\"></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Postal Code/Zip Code:</font></td>
                                                <% out.println("<td><input type=\"text\" name=\"postalCode\" size=\"50\" maxlength=\"20\" class=\"clr-input\" value=\"" + pcode + "\"></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></td>
                                                <% out.println("<td><input type=\"text\" name=\"country\" size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\"" + country + "\"></td>"); %>
                                        </tr>
                                        <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></td>
                                                <% out.println("<td><input type=\"password\" name=\"password\" size=\"50\" maxlength=\"30\" class=\"clr-input\" value=\"" + password + "\" required></td>"); %>
                                        </tr>
                                        <tr>
                                                <td colspan="2"><input type="button" value="Go back" class="btn btn-primary btn-sm" onclick="history.back()"><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success btn-sm" value="Submit"></td>
                                        </tr>

                                </table>
                        </form>

                </div>
        </html>
