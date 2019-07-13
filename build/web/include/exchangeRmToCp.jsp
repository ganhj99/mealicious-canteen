<%-- 
    Document   : exchangeRmToCp
    Created on : Mar 30, 2019, 7:58:10 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%  int ringgit = Integer.parseInt(request.getParameter("ringgit"));
    int creditPoints = ringgit * 10;
%>

<% out.print(creditPoints); %>