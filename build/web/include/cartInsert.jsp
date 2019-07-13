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

<%  CartDA cartDA = new CartDA();
    CartDetailDA cartDetailDA = new CartDetailDA();
    MealDA mealDA = new MealDA();
    
    int cp = Integer.parseInt(request.getParameter("cp"));
    
    int qtt = Integer.parseInt(request.getParameter("qtt"));
    
    String startDate = request.getParameter("dorder");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    
    int cid = Integer.parseInt(request.getParameter("cid"));
    Cart cart = cartDA.getRecord(cid);
    
    int mid = Integer.parseInt(request.getParameter("mid"));
    Meal meal = mealDA.getRecord(mid);
    
    String mss = request.getParameter("mss"); 
    
    CartDetail cartDetail = new CartDetail(cart, meal, mss, qtt, cp, sqlStartDate);
    cartDetailDA.addRecord(cartDetail);
%>