<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  OrderDA orderDA = new OrderDA();
    OrderDetailDA orderDetailDA = new OrderDetailDA();
    int oid = Integer.parseInt(request.getParameter("oid"));
    
    String studID = request.getParameter("sid");
    
    orderDA.modRecord(oid);
    ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
    
%>

<%@include file="../include/dataTableSuccessOrder.jsp" %>