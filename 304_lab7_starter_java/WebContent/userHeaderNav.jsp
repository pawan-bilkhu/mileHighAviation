 <%
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