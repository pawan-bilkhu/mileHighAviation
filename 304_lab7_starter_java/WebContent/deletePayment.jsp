<%@ include file="jdbc.jsp" %>
<%
String payId = request.getParameter("payId");
try{
    getConnection();
    String updateSQL = "DELETE FROM paymentmethod WHERE paymentMethodId = ?";
    PreparedStatement pstmt = con.prepareStatement(updateSQL);
    pstmt = con.prepareStatement(updateSQL);
    pstmt.setString(1, payId);
    pstmt.executeUpdate();


// Close connection
pstmt.close();
response.sendRedirect("customer.jsp");

}
catch(SQLException ex)
{System.out.println(ex);}
%>