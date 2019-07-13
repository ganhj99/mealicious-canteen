<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="domain.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  CartDA cartDA = new CartDA();
    CartDetailDA cartDetailDA = new CartDetailDA();
    OrderDA orderDA = new OrderDA();
    OrderDetailDA orderDetailDA = new OrderDetailDA();
    StudentDA studentDA = new StudentDA();
    
    int cid = Integer.parseInt(request.getParameter("cid"));
    Cart cart = cartDA.getRecord(cid);
    
    Date date= new Date();
    long time = date. getTime();
    Timestamp ts = new Timestamp(time);
    
    int ttl = 0;
    
    ArrayList<CartDetail> cartDetail = new ArrayList<CartDetail>(); 
    cartDetail.addAll(cartDetailDA.getCartDetails(cart.getId())); 
    
    for (int i = 0; i < cartDetail.size(); i++) { 
        ttl += (cartDetail.get(i).getCp() * cartDetail.get(i).getQtt());
    }
    
    Student student = cart.getStud();
    
    Order order = new Order(ts, "Success", ttl, student);
    orderDA.addRecord(order);
    order = orderDA.getOrderId(student.getId());
      
    for (int i = 0; i < cartDetail.size(); i++) { 
        //String coupon = String.valueOf(order.getId()) + String.valueOf(cartDetail.get(i).getMeal().getId()) + cartDetail.get(i).getSession() + String.valueOf(cartDetail.get(i).getCp()*cartDetail.get(i).getQtt());
        DateFormat dateFormat = new SimpleDateFormat("yyMMdd");
        String datePortion = dateFormat.format(order.getDateOrder());
        String sessionPortion = cartDetail.get(i).getSession().substring(0,1);
        String coupon = sessionPortion + datePortion + order.getId() + cartDetail.get(i).getMeal().getId();
        orderDetailDA.addRecord(cartDetail.get(i), order.getId(), ts, coupon);
    }
    
    studentDA.modCP((student.getCpBalance() - ttl), student.getId());
    cartDetailDA.delAll(cart.getId());
%>
