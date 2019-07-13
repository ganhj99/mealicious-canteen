<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  PendingRecipeDA pendingRecipeDA = new PendingRecipeDA();
    
    int pid = Integer.parseInt(request.getParameter("pid"));
    
    pendingRecipeDA.delRecord(pid);

%>
