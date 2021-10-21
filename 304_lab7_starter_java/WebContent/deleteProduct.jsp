<%@ include file="jdbc.jsp" %>
<%
String pname = request.getParameter("productname");
boolean validDelete = false;
try{
    getConnection();
    String prodName = "SELECT productName FROM product";
    PreparedStatement pstmt= con.prepareStatement(prodName);
    ResultSet rst = pstmt.executeQuery();
    while(rst.next()){
        String product = rst.getString(1);
        if(pname.equalsIgnoreCase(product)){
            validDelete = true;
            break;
        }
    }
    if(validDelete){
        String updateSQL = "DELETE FROM product WHERE productName = ?";
        pstmt = con.prepareStatement(updateSQL);
        pstmt.setString(1, pname);
        pstmt.executeUpdate();
        String message = "Product Deleted Successfully!";
        session.setAttribute("InvalidDelete", message);
        response.sendRedirect("manageDB.jsp");
    }
    else {
        String message = "Product does not exist in the database";
        session.setAttribute("InvalidDelete", message);
		response.sendRedirect("manageDB.jsp");
    }

// Close connection
pstmt.close();
}
catch(SQLException ex)
{System.out.println(ex);}
%>