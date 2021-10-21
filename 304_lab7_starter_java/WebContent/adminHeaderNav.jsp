<%
if (user != null && user.equalsIgnoreCase("admin")){
    out.println("<a href=listcustomer.jsp class=\"nav-link nav-text\">List All Customers</a>");
    out.println("<a href=listorder.jsp class=\"nav-link nav-text\">List All Orders</a>");
    out.println("<a href=admin.jsp class=\"nav-link nav-text\">Administrators</a>");
    out.println("<a href=manageDB.jsp class=\"nav-link nav-text\">Manage Database</a>");
}
%>
