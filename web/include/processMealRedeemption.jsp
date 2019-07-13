<%-- 
    Document   : processMealRedeemption
    Created on : Apr 10, 2019, 2:45:30 AM
    Author     : USER
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  String couponCode = request.getParameter("code");
    OrderDetailDA orderDetailDA1 = new OrderDetailDA();
    
    Date date= new Date(System.currentTimeMillis());
    long time = date.getTime();
    Timestamp redeemTime = new Timestamp(time);
    
    orderDetailDA1.modStatusByCoupon(couponCode, redeemTime, "Redeemed");
    
    %>
    
    <%@include file="../include/dataTableTodayRedeem.jsp" %>