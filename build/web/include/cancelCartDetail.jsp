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

<%  CartDetailDA cartDetailDA = new CartDetailDA();
    
    int cid = Integer.parseInt(request.getParameter("cid"));
    
    int mid = Integer.parseInt(request.getParameter("mid"));
    
    String mses = request.getParameter("mses");
    
    String startDate = request.getParameter("odate");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    
    cartDetailDA.delRecord(cid, mid, mses, sqlStartDate);
%>