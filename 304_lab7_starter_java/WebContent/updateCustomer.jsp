<%@ include file="jdbc.jsp" %>

<%
    String custid = request.getParameter("customerId");
    String fname = request.getParameter("firstName");
    String lname = request.getParameter("lastName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phoneNo = request.getParameter("phoneNo");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String pcode = request.getParameter("postalCode");
    String country = request.getParameter("country");

        try
        {
                getConnection();
                String updateSQL = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, password = ? WHERE customerId = ?";
                PreparedStatement pstmt = con.prepareStatement(updateSQL);
                pstmt = con.prepareStatement(updateSQL);

                pstmt.setString(1, fname);
                pstmt.setString(2, lname);
                pstmt.setString(3, email);
                pstmt.setString(4, phoneNo);
                pstmt.setString(5, password);
                pstmt.setString(6, custid);
                pstmt.executeUpdate();


                // Close connection
                pstmt.close();
                response.sendRedirect("customer.jsp");

        }
                catch(SQLException ex)
        {
                System.out.println(ex);
        }
        %>

        </html>
