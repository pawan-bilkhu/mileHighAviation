<%
if (session.getAttribute("loginMessage") != null)
{
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
	session.setAttribute("loginMessage", null);
}
%>