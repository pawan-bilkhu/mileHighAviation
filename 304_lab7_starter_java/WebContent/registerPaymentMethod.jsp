<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
            <%
String custid = request.getParameter("customerId");
String direction = request.getParameter("direction");
String payType = request.getParameter("payType");
String payNum = request.getParameter("payNum");
String expDate = request.getParameter("expDate");

try
{
    getConnection();
    String sql = "INSERT INTO paymentmethod(customerId, paymentType, paymentNumber, paymentExpiryDate) VALUES (?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, custid);
    pstmt.setString(2, payType);
    pstmt.setString(3, payNum);
    pstmt.setDate(4, java.sql.Date.valueOf(expDate));
    pstmt.executeUpdate();
    pstmt.close();

    if(direction.equals("null"))
         response.sendRedirect("customer.jsp");
    else
         response.sendRedirect("paymentMethod.jsp?customerId=" + custid);

}
catch(SQLException ex)
{System.out.println(ex);con.rollback();}
%>
        </div>

        </body>
        </html>
