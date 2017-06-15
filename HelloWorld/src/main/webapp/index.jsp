<html>
<body>
<h2>Hello World3!</h2>
<%   String ip = request.getHeader("X-Forwarded-Host");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        %>
<h3>
<%
 out.println( " CLIENT-IPAddress:"+ip );
%>
<%  String serverIP = request.getLocalAddr();
%>
<%
 out.println( "<BR><BR><BR> SERVER-IPAddress:"+serverIP );
%></h3>
</body>
</html>


