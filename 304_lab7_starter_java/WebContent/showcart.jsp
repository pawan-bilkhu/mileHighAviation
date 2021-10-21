<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="getAuthenticatedUser.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
</head>
<body>
<div class="main-container">
    <header class="header-6">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="active nav-link nav-text">Cart</a>
            <%@ include file="adminHeaderNav.jsp" %>
        </div>
    <div class="header-nav"></div>
        <%@ include file="userHeaderNav.jsp" %>
    </header>
    <title>Shopping Cart</title>


    <script>
    function update(newid, newqty){
    window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
    }
    </script>
    <div class="content-container">
        <div class="content-area">
            <form name="form1">


<%
String update = request.getParameter("update");
String newqty = request.getParameter("newqty");
String del = request.getParameter("delete");
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
ArrayList<Object> product;

if(update != null && (!update.equals(""))) {
		if (productList.containsKey(update)) { // find item in shopping cart
			product = (ArrayList<Object>) productList.get(update);
			if(new Integer(newqty) < 0){
				out.println("<div style=\"text-align:center\"><h1>Can't have negative quantity!</h1></div><br></br>");
			}
			else if(new Integer(newqty) == 0){
				productList.remove(update);
			}
			else{
				product.set(3, (new Integer(newqty))); // change quantity to new quantity
			}
		}
	}
if(del != null){
	productList.remove(del);
}
if(productList == null)
{
    out.println("<div style=\"text-align:center\"><h1>Your shopping cart is empty!</h1></div><br></br>");
    out.println("<div style=\"text-align:center\"><span><a href=\"listprod.jsp\" class=\"btn btn-primary\">Return to Shop</a></span>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else if (productList.isEmpty())
{
    out.println("<div style=\"text-align:center\"><h1>Your shopping cart is empty!</h1></div><br></br>");
    out.println("<div style=\"text-align:center\"><span><a href=\"listprod.jsp\" class=\"btn btn-primary\">Return to Shop</a></span>");
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    out.println("<div align=\"center\"><h1>Your Shopping Cart</h1><div>");
	out.print("<table class=\"table\"><tr><th >Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th><th></th><th></th></tr>");
	double total =0;
	int count = 0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}

		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		// need to make this into updatable field
		count++;
		out.print("<td align=\"center\"><input type=\"number\" name=\"newqty"+count+"\" size=\"5\"  min=\"0\" value=\""+product.get(3)+"\"></td>");
		// out.print("<td align=\"center\">"+product.get(3)+"</td>");

		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;

		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.println("<td align=\"right\"><a href=showcart.jsp?delete=" + product.get(0) + " class =\"btn btn-warning-outline\">Remove Item</a></td>");
		String id = product.get(0).toString();
		// Object x = document.getElementById("nextqty").value;
		out.println("<td align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" onclick=\"update(" + id+ ", document.form1.newqty" + count + ".value)\" class =\"btn btn-success-outline\" value=\"Update Quantity\"></td></tr>");
		// document.form1.newqty1.value
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.print("<div style=\"text-align:center\"><span><a href=\"listprod.jsp\" class=\"btn btn-primary\">Continue Shopping</a></span><span><a href=\"checkout.jsp\" class=\"btn btn-primary\">Checkout</a></span></div>");
}
%>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

