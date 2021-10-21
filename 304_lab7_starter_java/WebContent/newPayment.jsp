<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
    <html>
        <link rel="stylesheet" href="https://unpkg.com/@clr/ui/clr-ui.min.css" />

    <!-- borrowed this credit card formatter from the internet here:
    https://www.peterbe.com/plog/cc-formatter?fbclid=IwAR10Yzc4WUNGbcPiSIRAnSoF8eKFG2CcykK14deLkm41Ux7dn941e7NmfBU -->
    <script>

    function cc_format(value) {
        var v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '')
        var matches = v.match(/\d{4,16}/g);
        var match = matches && matches[0] || ''
        var parts = []
        for (i=0, len=match.length; i<len; i+=4) {
            parts.push(match.substring(i, i+4))
        }
        if (parts.length) {
            return parts.join(' ')
        } else {
            return value
        }
    }

        onload = function() {
        document.getElementById('payNum').oninput = function() {
        this.value = cc_format(this.value)
        }
    }
    </script>

        <head>
            <title>Create Payment Method</title>
        </head>
        <body>
        <div class="main-container">
            <header class="header-6" align="centre">
                <div class="header-nav">
                <a href="index.jsp" class="nav-link nav-text">Home</a>
                <a href="listprod.jsp" class="nav-link nav-text">Shop</a>
                <a href="showcart.jsp" class="nav-link nav-text">Cart</a>
                </div>
            </header>

    <div class="content-container">
        <div class="content-area">
    <div style="margin:0 auto;text-align:center;display:inline">

    <%@ include file="sessionAttribute.jsp" %>
    <% String custid = request.getParameter("customerId"); %>
    <% String pass = request.getParameter("password"); %>

    <h1>Add Payment Method</h1>
        <form method="get" action="registerPaymentMethod.jsp?">
        <% out.println("<input type=\"hidden\" name=\"customerId\" value=\"" + custid + "\">"); %>
        <% out.println("<input type=\"hidden\" name=\"password\" value=\"" + pass + "\">"); %>
            <table class="table-compact" style="display:inline">
                <tr>
                    <th colspan=3><h3>Payment Info</h3></th>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Payment Type</font></td>
                    <td><input type="radio" id="payType" name="payType" value="Visa" required><label for="payType"> Visa</label></td>
                    <td><input type="radio" id="payType" name="payType" value="Master Card" required><label for="payType"> Master Card</label></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2" >Card Number: </font></td>
                    <td colspan="2"><input id="payNum" type="text" name="payNum"  size="50" maxlength="30" class="clr-input" placeholder="1234 5678 9876 5432" required></td>
                </tr>
                <tr>
                    <td><font face="Arial, Helvetica, sans-serif" size="2">Expiry Date: </font></td>
                    <td colspan="2"><input type="date" name="expDate" size="50" maxlength="30" class="clr-input" required></td>
                </tr>
                <tr>
                    <td colspan="3"><span><input type="button" value="Go back" class="btn btn-primary btn-sm" onclick="history.back()"></span><input type="submit" name="submit" size="50" maxlength="30" class="btn btn-success btn-sm" value="Confirm"></td>
                </tr>
            </table>
        </form>
    </div>
            </div>
        </div>
    </div>
</body>
</html>