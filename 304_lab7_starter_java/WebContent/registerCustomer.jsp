<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
<head>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <title>Create user id and password</title>
</head>
    <header class="header-6">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        </div>
    </header>

        <%
    String fname = request.getParameter("firstName");
    String lname = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNo= request.getParameter("phoneNo");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String pcode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String password = request.getParameter("password");
    String userid = request.getParameter("userid");
    boolean validId = true;

        try{
            getConnection();
            String useridSQL = "SELECT userid FROM customer";
            PreparedStatement pstmt= con.prepareStatement(useridSQL);
            ResultSet rst = pstmt.executeQuery();

            while(rst.next())
            {
                String username = rst.getString(1);
                if(userid.equals(username))
                {
                    validId = false;
                    break;

                }

            }

            if(validId)
            {
                String insertSQL = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(insertSQL);

                pstmt.setString(1, fname);
                pstmt.setString(2, lname);
                pstmt.setString(3, email);
                pstmt.setString(4, phoneNo);
                pstmt.setString(5, address);
                pstmt.setString(6, city);
                pstmt.setString(7, state);
                pstmt.setString(8, pcode);
                pstmt.setString(9, country);
                pstmt.setString(10, userid);
                pstmt.setString(11, password);

                pstmt.executeUpdate();
                out.println("<div style=\"margin:0 auto;text-align:center;display:inline\"><h1>You successfully registered! Welcome to MHA</h1> <br><br>");
                out.println("<div><span><a href=\"index.jsp\" class=\"btn btn-primary\">Home</a></span><span><a href=\"listprod.jsp\" class=\"btn btn-primary\">Start Shopping</a></span></div></div>");
            }
            else
            {
                String message = "Username has been taken, please pick a different one";
                session.setAttribute("InvalidUserId", message);
		        response.sendRedirect("newCustomer.jsp");
            }
            // Close connection
            rst.close();
            pstmt.close();

        }
        catch(SQLException ex)
{System.out.println(ex);}


        %>

</html>