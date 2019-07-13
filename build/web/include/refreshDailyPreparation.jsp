<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  DailyPreparationDA dailyPreparationDA = new DailyPreparationDA();
    
    String startDate = request.getParameter("dt");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
      
%>

<%@include file="../include/dailyPreparationTable.jsp" %>

