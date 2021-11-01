<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file= "sessionAttribute.jsp" %>
<%@ include file="getAuthenticatedUser.jsp" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
        <html>
                <head>
                <style type="text/css">table, th, td {
                        .right text-align: right;}
                        h2 {text-align: center;}
                        h3 {text-align: center;}
                </style>
                <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
                <title>MHA Grocery Order Processing</title>
                </head>
                <body>
                        <div class="main-container">
                        <header class="header-6">
                                <div class="header-nav">
                                        <a href="index.jsp" class="nav-link nav-text">Home</a>
                                        <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                                        <a href="showcart.jsp" class="active nav-link nav-text">Cart</a>
                                </div>
                        </header>
        <div class="content-container">
                <div class="content-area">

                    <%
// Get customer id and pass
String custid = request.getParameter("customerId");
String payType = request.getParameter("payType");
String payNum = request.getParameter("payNum");
String address = null;
String city = null;
String state = null;
String postalCode = null;
String country = null;
String custName = null;
String fullAddress = null;
int orderId = 0;
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message
// Make connection

boolean validUser = false;
if(user != null)
{
    try
    {
         getConnection();
         String SQL = "SELECT userid FROM customer WHERE customerId = ? ";
         PreparedStatement pstmt = con.prepareStatement(SQL);
         pstmt.setString(1, custid);
         ResultSet rst = pstmt.executeQuery();
         while(rst.next())
         {
            if(rst.getString("userid").equals(user))
            {
                validUser = true;
            }

         }
         pstmt.close();
         rst.close();
    }
    catch(SQLException ex)
    {
        System.out.println(ex);
    }
}

if(validUser)
{
    try
    {
        getConnection();
	    double sum = 0;
		String SQL = "SELECT firstName, lastName, address, city, state, postalCode, country FROM customer WHERE customerId = ?";
		PreparedStatement pstmt=null;
		ResultSet rst = null;
		pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, custid);
		rst = pstmt.executeQuery();

		while(rst.next())
		{
		        custName = rst.getString(1) + " " + rst.getString(2);
		        address = rst.getString(3);
		        city = rst.getString(4);
		        state = rst.getString(5);
		        postalCode = rst.getString(6);
		        country = rst.getString(7);
		        fullAddress =  address + ", " + city + ", " + state + ", " + postalCode + ", " + country;

		}
	}
    catch(SQLException ex)
	{
	    System.out.println(ex);
	}
		if(!productList.isEmpty())
		{
			NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

			out.println("<table class=table><th colspan=\"6\"><h1>You Order Summary</h1></th>");
			out.println("<tr><th>Product ID</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
            double sum = 0;
				while (iterator.hasNext())
				{
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
					String productName = (String) product.get(1);
					String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ((Integer)product.get(3)).intValue();
					double total = pr*qty;
					sum += total;

					out.println("<tr>");
					out.println("<td>" + productId +  "</td>");
					out.println("<td>" + productName +  "</td>");
					out.println("<td>" + qty +  "</td>");
					out.println("<td>" + currFormat.format(pr) +  "</td>");
					out.println("<td>" + currFormat.format(total) +  "</td>");
					out.println("</tr>");
				}
				out.println("<tfoot><tr><td><b>Order Total:</b></td><td></td><td></td><td></td><td>"+currFormat.format(sum)+"</td></tr></tfoot>");
				out.println("</table>");

				//get date
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				LocalDateTime now = LocalDateTime.now();
				String orderDate = dtf.format(now);

                try
                {
                getConnection();
				        //finally adding all information into ordersummary
				        String insert = "INSERT INTO ordersummary (orderDate, customerId, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry) VALUES (?,?,?,?,?,?,?,?) ";
				        PreparedStatement pstmt = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
				        pstmt.setString(1, orderDate);
				        pstmt.setString(2, custid);
				        pstmt.setDouble(3, sum);
				        pstmt.setString(4, address);
				        pstmt.setString(5, city);
				        pstmt.setString(6, state);
				        pstmt.setString(7, postalCode);
				        pstmt.setString(8, country);
				        int rowcount = pstmt.executeUpdate();
				        ResultSet keys = pstmt.getGeneratedKeys();
				        keys.next();
				        orderId = keys.getInt(1);
				}
				catch(SQLException ex)
	            {
	                    System.out.println(ex);
	            }

				try
				{
				        getConnection();
				        //insert into orderproduct table
				        String insert2 = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?,?,?,?)";
				        PreparedStatement pstmt = con.prepareStatement(insert2);
				        pstmt.setInt(1, orderId);
				        Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator(); //traverse productlist again
				        while (iterator2.hasNext())
				        {
					            Map.Entry<String, ArrayList<Object>> entry = iterator2.next();
					            ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					            String productId = (String)product.get(0);
					            String price = (String)product.get(2);
					            double pr = Double.parseDouble(price);
					            int qty = ((Integer)product.get(3)).intValue();

					            pstmt.setString(2, productId);
					            pstmt.setInt(3, qty);
					            pstmt.setDouble(4, pr);
					            int rowcount2 = pstmt.executeUpdate();
				        }
				}
				catch(SQLException ex)
	            {
	                    System.out.println(ex);
	            }

				out.println();
				out.println("<h2>Order completed. Will be shipped to: " + fullAddress + "</h2>");
				out.println("<h2>Order Charged to "+ payType + " ending in: " + payNum.substring(15, 19) + "</h2>");
				out.println("<h2>Your order reference number is: <b>" + orderId + "</b></h2>" );
				out.println("<h2>Shipping to customer: <u>" + custid + "</u> Name: <u>" + custName + "</u></h2>");
				out.println("<div style=\"text-align:center\"><span><a href=listprod.jsp class=\"btn btn-primary\">Return Shopping</a> ");
				out.println("<a href=\"index.jsp\" class=\"btn btn-primary\">Home page</a></span></div>");

				productList.clear();
		}
		else
		{
			out.println("<h2>You have an empty cart!</h2>");
			out.println("<h3><a href=listprod.jsp class=\"btn btn-primary\">Return to Shop</a></h3>");
		}
    }
	else
	{
        String message = "Incorrect Customer ID and/or Password";
        session.setAttribute("loginMessage", message);
		response.sendRedirect("checkout.jsp");
	}


// Save order information to database
	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/
// Insert each item into OrderProduct table using OrderId from previous INSERT
// Update total amount for order record
// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/
// Print out order summary
// Clear cart if order placed successfully
%>

        </div>
    </div>
</div>
</body>
</html>
