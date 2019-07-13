<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  MealDA mealDA = new MealDA();
   
    int mid = Integer.parseInt(request.getParameter("mid"));
    
    int pr = Integer.parseInt(request.getParameter("pr"));
   
    String stt = request.getParameter("stt");
    
    mealDA.modRecord(mid, pr, stt);
%>