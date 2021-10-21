<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
    <head>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
        <title>Update Product</title>
    </head>
    <header class="header-6">
        <div class="header-nav">
            <a href="index.jsp" class="nav-link nav-text">Home</a>
            <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
            <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
        </div>
    </header>
    <body>
    <div  style="text-align:center">
<%
        String pname = request.getParameter("productname");
        String newPrice = request.getParameter("newPrice");
        String newOrigin = request.getParameter("newOrigin");
        String newDesc = request.getParameter("newDesc");

        if(newPrice != null || newOrigin != null || newDesc != null){
            //int newPriceN = Integer.parseInt(newPrice);
            String updateSQL = "UPDATE product SET productPrice = ?, productOrigin = ?, productDesc = ? WHERE productName = ?";
            PreparedStatement pstmt1 = con.prepareStatement(updateSQL);
            pstmt1.setString(1, newPrice);
            pstmt1.setString(2, newOrigin);
            pstmt1.setString(3, newDesc);
            pstmt1.setString(4, pname);
            pstmt1.executeUpdate();
            String message = "Product Updated!";
            session.setAttribute("InvalidProduct", message);
            response.sendRedirect("manageDB.jsp");
        }

        double oldPrice = 0;
        String oldDesc = null;
        String oldOrigin = null;
        out.println("<h1>Update: " + pname + "</h1>");
        boolean ProductExists = false;
        try{
            getConnection();
            String getProduct = "SELECT productName, productPrice, productDesc, productOrigin FROM product WHERE productName = ?";
            PreparedStatement pstmt= con.prepareStatement(getProduct);
            pstmt.setString(1, pname);
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                String product = rst.getString(1);
                if(pname.equalsIgnoreCase(product)){
                    oldPrice = rst.getDouble(2);
                    oldDesc = rst.getString(3);
                    oldOrigin = rst.getString(4);
                    ProductExists = true;
                    break;
                }
            }
            if(ProductExists){
                out.println("<form method=\"get\" action=\"updateProduct.jsp\">");
                out.println("<table class=\"table-compact\" style=\"display:inline\">");
                out.println("<tr><td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Product Name:</font></td>");
                out.println("<td><input id=\"productname\" type=\"text\" name=\"productname\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" value=\""+pname+"\" required></td></tr>");

                out.println("<tr><td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\" >Product Price:</font></td>");
                out.println("<td><input type=\"number\" step=\"0.01\" name=\"newPrice\"  size=\"50\" maxlength=\"40\" class=\"clr-input\" min=\"0\" value=\""+oldPrice+"\" required></td></tr>");
                out.println("<tr><td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Product Origin:</font></td>");
                out.println("<td><input type=\"text\" name=\"newOrigin\" size=\"50\" maxlength=\"30\" class=\"clr-input\" value=\""+oldOrigin+"\" required></td></tr>");
                out.println("<tr><td><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Description:</font></td>");
                out.println("<td><input type=\"text\" name=\"newDesc\" size=\"50\" maxlength=\"1000\" class=\"clr-input\" value=\""+oldDesc+"\"></td></tr>");
                out.println("<tr><td colspan=\"2\"><input type=\"button\" value=\"Go back\" class=\"btn btn-primary-outline btn-sm\" onclick=\"history.back()\"><input type=\"submit\" name=\"submit\" size=\"50\" maxlength=\"30\" class=\"btn btn-outline-success btn-sm\" value=\"Update\"></td></tr>");
                out.println("</table></form>");
            }
            else{
                String message = "Product does not exist! Try again.";
                session.setAttribute("InvalidProduct", message);
		        response.sendRedirect("manageDB.jsp");
            }
            //Close connection
            rst.close();
            pstmt.close();
        }
        catch(SQLException ex)
{System.out.println(ex);}
        %>

        </div>

        </body>
        </html>