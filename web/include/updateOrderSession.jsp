<%-- 
    Document   : orderInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  OrderDetailDA orderDetailDA = new OrderDetailDA();
    
    String nses = request.getParameter("nses");
    
    int oid = Integer.parseInt(request.getParameter("oid"));
    
    int mid = Integer.parseInt(request.getParameter("mid"));
    
    String mses = request.getParameter("mses");
    
    String startDate = request.getParameter("odate");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    
    orderDetailDA.modSession(nses, oid, mid, mses, sqlStartDate);
%>