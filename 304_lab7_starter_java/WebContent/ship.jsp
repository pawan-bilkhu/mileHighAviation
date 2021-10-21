<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>MHA Grocery Shipment Processing</title>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />

    <header class="header-6">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        </div>
    <div class="header-nav"></div>
        <%
String userid= request.getParameter("username");
String user = (String)session.getAttribute("authenticatedUser");
out.println("<div class=\"header-actions\">");
if( user != null)
{
        out.println("<a class=\"nav-link nav-text\"><span class=\"nav-text\"> Logged in as: " + user + "</span></a>");
        out.println("<a href=\"logout.jsp\" class=\"nav-link nav-text\"><span class=\"nav-text\">Logout</span></a>");
        }
else
{
        out.println("<a class=\"nav-link nav-text\" href=\"login.jsp\">Login</a>");
        }
        out.println("</div>");
        %>
    </header>
</head>
<body>
    <div style="text-align:center">

<%
	// TODO: Get order id
String orderId = request.getParameter("orderId");

try
{
    getConnection();
    Statement updateProduct = con.createStatement();
    Statement newShipment = con.createStatement();

    // TODO: Start a transaction (turn-off auto-commit)
    con.setAutoCommit(false);




	// TODO: Retrieve all items in order with given id
    String sql1 = "SELECT orderId, productId, quantity FROM orderproduct WHERE orderId = ?";
    String sql2 = "SELECT productId, quantity FROM productinventory WHERE warehouseId = '1' AND productId = ?";


    PreparedStatement orderProduct = con.prepareStatement(sql1);

    orderProduct.setString(1, orderId);


    ResultSet r_orderProduct = orderProduct.executeQuery();

    PreparedStatement productInventory = con.prepareStatement(sql2);

    ResultSet r_productInventory = null;






    out.println("<h1>");
    if(r_orderProduct.next())
    {

        do{
        out.println("Ordered Product: " + r_orderProduct.getString(2));

        out.println("Qty: " + r_orderProduct.getInt(3));

        productInventory.setString(1, r_orderProduct.getString(2));

        r_productInventory = productInventory.executeQuery();

        while(r_productInventory.next())
        {

            // TODO: For each item verify sufficient quantity available in warehouse 1.
            if((r_productInventory.getInt(2) - r_orderProduct.getInt(3)) >= 0)
            {
                out.println("Previous Inventory: " + r_productInventory.getString(2) + "");

                String sql3 = "UPDATE productinventory SET quantity =" + (r_productInventory.getInt(2) - r_orderProduct.getInt(3)) + " WHERE productId =" + r_orderProduct.getString(2) + " AND warehouseId = '1'";

                updateProduct.executeUpdate(sql3);


                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				LocalDateTime now = LocalDateTime.now();
				String orderDate = dtf.format(now);

                // TODO: Create a new shipment record.
                String sql4 = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES ('" +orderDate+ "', 1)";
                newShipment.executeUpdate(sql4);


                String sql5 = "SELECT quantity FROM productinventory WHERE warehouseId = '1' AND productId = ?";
                PreparedStatement updatedInventory = con.prepareStatement(sql5);

                updatedInventory.setString(1, r_orderProduct.getString(2));
                ResultSet r_updatedInventory = updatedInventory.executeQuery();

                while(r_updatedInventory.next())
                    out.println("Current Inventory: " + r_updatedInventory.getString(1) +"<br><br>");


            }
            else
            {
                // TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
                con.rollback();
                out.println("Current Inventory: " + r_productInventory.getString(2) + "");
                out.println("<br>Shipment not done. Insufficient inventory for product id: " + r_orderProduct.getString(2) + "<br><br>");
            }

        }


        } while(r_orderProduct.next());
         con.commit();

    }
    else
   {
      out.println("Invalid OrderId");
   }
   out.println("</h1>");

	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);

}
catch(SQLException ex)
{System.out.println(ex); con.rollback();}
// Close connection
%>                       				

    <h2><a href="index.jsp" class="btn btn-primary">Back to Main Page</a></h2>

    </div>

</body>
</html>
