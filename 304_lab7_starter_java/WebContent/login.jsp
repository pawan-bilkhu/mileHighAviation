<!DOCTYPE html>
<html>
	<link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />
	<link rel="stylesheet" href="css/login.css"/>
<head>
<title>Login</title>
</head>
<body>
	<div class="main-container">
		<header class="header-6">
			<div class="header-nav">
				<a href="index.jsp" class="active nav-link nav-text">Home</a>
				<a href="listprod.jsp" class="nav-link nav-text">Shop</a>
				<a href="showcart.jsp" class="nav-link nav-text">Cart</a>
			</div>
		</header>
		<div class="content-container">
			<div class="content-area">
				<form name="MyForm" method="post" action="validateLogin.jsp">
					<%
						out.println("<input type=\"hidden\" name=\"productId\" value=\"" + request.getParameter("id") + "\">");
						out.println("<input type=\"hidden\" name=\"productName\" value=\"" + request.getParameter("name") + "\">");
						out.println("<input type=\"hidden\" name=\"direction\" value=\"" + request.getParameter("direction") + "\">");
					%>
					<%@ include file="sessionAttribute.jsp" %>
					<table class="table">
						<th colspan="2">
							Please Login to System
						</th>
						<tr>
							<td><font face="Arial, Helvetica, sans-serif" size="2">Username:</font>
							<input type="text" name="username"  size="30" maxlength="10"></td>
						</tr>
						<tr>
							<td><font face="Arial, Helvetica, sans-serif" size="2">Password:</font>
							<input type="password" name="password" size="30" maxlength="10"></td>
						</tr>
						<tr>
							<td colspan="2">
								<input class="btn btn-warning" type="reset" value="Reset">
								<input class="btn btn-success" type="submit" name="Submit2" value="Log In">
								<span><a href="newCustomer.jsp">Create an Account</a></span>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

