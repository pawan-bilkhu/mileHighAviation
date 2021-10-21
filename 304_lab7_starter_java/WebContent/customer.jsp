<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
    <!DOCTYPE html>
        <html>
            <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
            <style type="text/css">table, th, td {
                .right text-align: right;}
                h2 {text-align: center;}
                h3 {text-align: center;}
                td {text-align: center;
                    vertical-align: middle;}
            </style>
        <head>
        <title>Customer Page</title>
        </head>
        <body>
            <header class="header-6" align="centre">
                <div class="header-nav">
                        <a href="index.jsp" class="nav-link nav-text">Home</a>
                        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                        <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                        <%@ include file="adminHeaderNav.jsp" %>
                </div>

<%          out.println("<div class=\"header-actions\">");
            if( user != null){
                out.println("<a class=\"nav-link nav-text\"><span class=\"nav-text\"> Logged in as: " + user + "</span></a>");
                out.println("<a href=\"logout.jsp\" class=\"nav-link nav-text\"><span class=\"nav-text\">Logout</span></a>");
            }
            else{
                String message = "You must sign in to view customer info";
                session.setAttribute("loginMessage", message);
            }
            out.println("</div>");
%>
            </header>

 <%
try{
            getConnection();

			String SQL = "SELECT  * FROM customer WHERE userid = ? ";
			String custid = null;
			PreparedStatement pstmt= con.prepareStatement(SQL);
			pstmt.setString(1, user);
			ResultSet rst = pstmt.executeQuery();

			out.print("<div style=\"margin:0 auto;text-align:center;display:inline\">");
            out.print("<h1>Customer Profile<h1>");
            out.print("<table class=\"table\" style=\"display:inline\">");
			while(rst.next()){
			    custid = rst.getString("customerId");
                out.print("<tr><th colspan=\"4\">Credentials</th></tr>");
                out.print("<tr><th>Customer Id</th><td>"+rst.getString("customerId")+"</td><th>User id</th><td>"+rst.getString("userid")+"</td></tr>");

			    out.print("<tr><td colspan=\"4\"><table class=\"table\">");
			    out.print("<tr><th colspan=\"2\">Personal Info</th><th colspan=\"2\">Shipping Info</th></tr>");
				out.print("<tr><th>First Name</th><td>"+rst.getString("firstName")+"</td><th>Address</th><td>"+rst.getString("address")+"</td></tr>");
				out.print("<tr><th>Last Name</th><td>"+rst.getString("lastName")+"</td><th>City</th><td>"+rst.getString("city")+"</td></tr>");
				out.print("<tr><th>Username</th><td>"+rst.getString("userid")+"</td><th>State</th><td>"+rst.getString("state")+"</td></tr>");
				out.print("<tr><th>Email</th><td>"+rst.getString("email")+"</td><th>Postal Code</th><td>"+rst.getString("postalCode")+"</td></tr>");
				out.print("<tr><th>Phone</th><td>"+rst.getString("phonenum")+"</td><th>Country</th><td>"+rst.getString("country")+"</td></tr>");

				out.print("</table></td></tr>");
				out.print("</table></div>");
				out.print("<div style=\"text-align:center\"><a href=\"changeCustomer.jsp?id=" + rst.getString("customerId")
				+ "&fname=" + rst.getString("firstName") + "&lname=" + rst.getString("lastName")
			    + "&email=" + rst.getString("email") + "&phoneNo=" + rst.getString("phonenum")
			    + "&password=" + rst.getString("password") + "&address=" + rst.getString("address")
			    + "&city=" + rst.getString("city") + "&state=" + rst.getString("state")
			    + "&postalCode=" + rst.getString("postalCode") + "&country=" + rst.getString("country")
			    + "\" class=\"btn btn-primary\">Change Customer Info</a></div>");
			}



            SQL = "SELECT paymentType, paymentNumber, FORMAT(paymentexpiryDate, 'yyyy-MM-dd'), paymentMethodId FROM paymentmethod WHERE customerId = ?";
            pstmt = con.prepareStatement(SQL);
            pstmt.setString(1, custid);
            rst = pstmt.executeQuery();

            if(rst.next())
            {
                out.print("<div style=\"margin:0 auto;text-align:center;display:inline\">");
                out.print("<h1>Payment Info<h1>");
                out.print("<table class=\"table\" style=\"display:inline\">");
                out.print("<tr><th>Type</th><th>Card Number</th><th>Expiry Date</th><th></th><tr>");
                do{
                    out.print("<tr>");
                    out.print("<td style=\"vertical-align:middle\">" + rst.getString(1) + "</td><td style=\"vertical-align:middle\">" + rst.getString(2) + "</td><td style=\"vertical-align:middle\">" +rst.getString(3)+ "</td>");
                    out.print("<td><a href=\"deletePayment.jsp?&payId=" + rst.getString(4) + "\" class=\"btn btn-warning-outline btn-sm\">Delete</a></td>");
                    out.print("</tr>");
                }while(rst.next());
                out.print("</table>");
                out.print("<div style=\"text-align:center\"><a href=\"newPayment.jsp?customerId=" + custid + "\" class=\"btn btn-primary\">Add new payment method</a></div>");
            }
            else
            {
                    out.println("");
                    out.print("<div style=\"text-align:center\"><h1>You have no Payment methods<h1><a href=\"newPayment.jsp?customerId=" + custid + "\" class=\"btn btn-primary\">Add new payment method</a></div>");
            }

            out.print("</div>");

			rst.close();
			pstmt.close();
	}

	catch(SQLException e ){
		out.println(e);
	}
%>
            </div>
        </body>
        </html>