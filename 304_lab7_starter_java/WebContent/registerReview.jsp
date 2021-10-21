<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%
        String rating = request.getParameter("rating");
        String custId = request.getParameter("customerId");
        String prodId = request.getParameter("productId");
        String comment= request.getParameter("comment");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
        String date = dtf.format(now);
            try{
                getConnection();
                String searchReview = "SELECT reviewId FROM review WHERE customerId = ? AND productId = ? ";
                PreparedStatement pstmt = con.prepareStatement(searchReview);
                pstmt.setString(1, custId);
                pstmt.setString(2, prodId);
                ResultSet rst = pstmt.executeQuery();
                if(rst.next()){
                    String updateSQL = "UPDATE review SET reviewRating = ?, reviewDate = ?, reviewComment = ? WHERE productId = ? AND customerId = ?";
                    pstmt = con.prepareStatement(updateSQL);
                    pstmt.setString(1, rating);
                    pstmt.setString(2, date);
                    pstmt.setString(3, comment);
                    pstmt.setString(4, prodId);
                    pstmt.setString(5, custId);
                    pstmt.executeUpdate();
                    String message = "Review Updated!";
                    session.setAttribute("InvalidReview", message);
                    response.sendRedirect("product.jsp?id=" + prodId);
                }
                else{
                    String insertSQL = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertSQL);
                    pstmt.setString(1, rating);
                    pstmt.setString(2, date);
                    pstmt.setString(3, custId);
                    pstmt.setString(4, prodId);
                    pstmt.setString(5, comment);
                    pstmt.executeUpdate();
                    String message = "Thank you for your review!";
                    session.setAttribute("InvalidReview", message);
                    response.sendRedirect("product.jsp?id=" + prodId);
                }

                // Close connection
                rst.close();
                pstmt.close();
            }
            catch(SQLException ex)


{System.out.println(ex);}
%>