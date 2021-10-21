<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
       <html>
              <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
       <head>
              <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
              <title>Add Product</title>
       </head>
       <header class="header-6">
              <div class="header-nav">
                     <a href="index.jsp" class="nav-link nav-text">Home</a>
                     <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                     <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
              </div>
       </header>
<%
    String pname = request.getParameter("productname");
    String price = request.getParameter("price");
    String origin = request.getParameter("origin");
    String desc= request.getParameter("desc");
    boolean validProduct = true;
        try{
            getConnection();
            String prodName = "SELECT productName FROM product";
            PreparedStatement pstmt= con.prepareStatement(prodName);
            ResultSet rst = pstmt.executeQuery();
            while(rst.next())
            {
                String product = rst.getString(1);
                if(pname.equalsIgnoreCase(product))
                {
                    validProduct = false;
                    break;
                }
            }
            if(validProduct)
            {
                String insertSQL = "INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES (?, ?, ?, ?)";
                pstmt = con.prepareStatement(insertSQL);
                pstmt.setString(1, pname);
                pstmt.setString(2, price);
                pstmt.setString(3, desc);
                pstmt.setString(4, origin);
                pstmt.executeUpdate();
                String message = "Product Added!";
                session.setAttribute("InvalidProduct", message);
                response.sendRedirect("manageDB.jsp");
            }
            else
            {
                String message = "Product already exists, please add a unique product";
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
</html>