<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  OrderDA orderDA = new OrderDA();
    OrderDetailDA orderDetailDA = new OrderDetailDA();
    StudentDA studentDA = new StudentDA();
    
    String dt = request.getParameter("dt");
    String ldt = request.getParameter("ldt");
    String dy1 = dt.substring(8, 10);
    String yr1 = dt.substring(11, 15);
    String mn1 = dt.substring(4, 7);
    String dy2 = ldt.substring(8, 10);
    String yr2 = ldt.substring(11, 15);
    String mn2 = ldt.substring(4, 7);
    if("Jan".equals(mn1)){
        mn1 = "01";
    }
    else if("Feb".equals(mn1)){
        mn1 = "02";
    }
    else if("Mar".equals(mn1)){
        mn1 = "03";
    }
    else if("Apr".equals(mn1)){
        mn1 = "04";
    }
    else if("May".equals(mn1)){
        mn1 = "05";
    }
    else if("Jun".equals(mn1)){
        mn1 = "06";
    }
    else if("Jul".equals(mn1)){
        mn1 = "07";
    }
    else if("Aug".equals(mn1)){
        mn1 = "08";
    }
    else if("Sep".equals(mn1)){
        mn1 = "09";
    }
    else if("Oct".equals(mn1)){
        mn1 = "10";
    }
    else if("Nov".equals(mn1)){
        mn1 = "11";
    }
    else if("Dec".equals(mn1)){
        mn1 = "12";
    }
    
    if("Jan".equals(mn2)){
        mn2 = "01";
    }
    else if("Feb".equals(mn2)){
        mn2 = "02";
    }
    else if("Mar".equals(mn2)){
        mn2 = "03";
    }
    else if("Apr".equals(mn2)){
        mn2 = "04";
    }
    else if("May".equals(mn2)){
        mn2 = "05";
    }
    else if("Jun".equals(mn2)){
        mn2 = "06";
    }
    else if("Jul".equals(mn2)){
        mn2 = "07";
    }
    else if("Aug".equals(mn2)){
        mn2 = "08";
    }
    else if("Sep".equals(mn2)){
        mn2 = "09";
    }
    else if("Oct".equals(mn2)){
        mn2 = "10";
    }
    else if("Nov".equals(mn2)){
        mn2 = "11";
    }
    else if("Dec".equals(mn2)){
        mn2 = "12";
    }
    
    String sid = request.getParameter("sid");
    Student student = studentDA.getRecordByStudId(sid);
    int dy = Integer.parseInt(request.getParameter("dy"));
    
    String startDate = yr1 + "-" + mn1 + "-" + dy1;
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    
    String LastDate = yr2 + "-" + mn2 + "-" + dy2;
    java.util.Date ldate = sdf1.parse(LastDate);
    java.sql.Date sqlLastDate = new java.sql.Date(ldate.getTime());
    
    long ms1 = sqlStartDate.getTime();
        for(int p = 0;p<dy;p++){
            ms1 += 86400000;
        }
    Date newDate1 = new Date(ms1);
    
    long ms2 = sqlLastDate.getTime();
        for(int p = 0;p<dy;p++){
            ms2 += 86400000;
        }
    Date newDate2 = new Date(ms2);
    
    long ms21 = sqlStartDate.getTime();
        for(int p = 0;p<(dy+7);p++){
            ms21 += 86400000;
        }
    Date newDate21 = new Date(ms21);
    
    long ms22 = sqlLastDate.getTime();
        for(int p = 0;p<(dy+7);p++){
            ms22 += 86400000;
        }
    Date newDate22 = new Date(ms22);
    
    long ms31 = sqlStartDate.getTime();
        for(int p = 0;p<(dy+14);p++){
            ms31 += 86400000;
        }
    Date newDate31 = new Date(ms31);
    
    long ms32 = sqlLastDate.getTime();
        for(int p = 0;p<(dy+14);p++){
            ms32 += 86400000;
        }
    Date newDate32 = new Date(ms32);
    
    long ms41 = sqlStartDate.getTime();
        for(int p = 0;p<(dy+21);p++){
            ms41 += 86400000;
        }
    Date newDate41 = new Date(ms41);
    
    long ms42 = sqlLastDate.getTime();
        for(int p = 0;p<(dy+21);p++){
            ms42 += 86400000;
        }
    Date newDate42 = new Date(ms42);
    
    long millis=System.currentTimeMillis();  
    Timestamp ts  = new Timestamp(millis);
    
    int ttl = 0;
    
    ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
    orderDetail.addAll(orderDetailDA.getOrderDetailByDate(sid, sqlStartDate, sqlLastDate));
    
    for(int p = 0;p<4;p++){
    for (int i = 0; i < orderDetail.size(); i++) { 
        ttl += (orderDetail.get(i).getCp() * orderDetail.get(i).getQtt());
    }
    }
    
    if(student.getCpBalance() >= ttl){
        Order order = new Order(ts, "Success", ttl, student);
        orderDA.addRecord(order);
        order = orderDA.getOrderId(student.getId());

        for(int i=0;i<orderDetail.size();i++){
            long ms = orderDetail.get(i).getDateCollect().getTime();
            for(int p = 0;p<dy;p++){
                ms += 86400000;
            }
            Date newDate = new Date(ms);
            String coupon = String.valueOf(orderDetail.get(i).getOrder().getId()) + String.valueOf(orderDetail.get(i).getMeal().getId()) + orderDetail.get(i).getSession() + String.valueOf(orderDetail.get(i).getCp()*orderDetail.get(i).getQtt());
            OrderDetail od = new OrderDetail(order, orderDetail.get(i).getMeal(), newDate, orderDetail.get(i).getSession(), orderDetail.get(i).getQtt(), orderDetail.get(i).getCp(), "Pending", ts, coupon);
            orderDetailDA.addNewRecord(od, sid, newDate1, newDate2);
        }

        for(int i=0;i<orderDetail.size();i++){
            long ms = orderDetail.get(i).getDateCollect().getTime();
            for(int p = 0;p<(dy+7);p++){
                ms += 86400000;
            }
            Date newDate = new Date(ms);
            String coupon = String.valueOf(orderDetail.get(i).getOrder().getId()) + String.valueOf(orderDetail.get(i).getMeal().getId()) + orderDetail.get(i).getSession() + String.valueOf(orderDetail.get(i).getCp()*orderDetail.get(i).getQtt());
            OrderDetail od = new OrderDetail(order, orderDetail.get(i).getMeal(), newDate, orderDetail.get(i).getSession(), orderDetail.get(i).getQtt(), orderDetail.get(i).getCp(), "Pending", ts, coupon);
            orderDetailDA.addNewRecord(od, sid, newDate21, newDate22);
        }

        for(int i=0;i<orderDetail.size();i++){
            long ms = orderDetail.get(i).getDateCollect().getTime();
            for(int p = 0;p<(dy+14);p++){
                ms += 86400000;
            }
            Date newDate = new Date(ms);
            String coupon = String.valueOf(orderDetail.get(i).getOrder().getId()) + String.valueOf(orderDetail.get(i).getMeal().getId()) + orderDetail.get(i).getSession() + String.valueOf(orderDetail.get(i).getCp()*orderDetail.get(i).getQtt());
            OrderDetail od = new OrderDetail(order, orderDetail.get(i).getMeal(), newDate, orderDetail.get(i).getSession(), orderDetail.get(i).getQtt(), orderDetail.get(i).getCp(), "Pending", ts, coupon);
            orderDetailDA.addNewRecord(od, sid, newDate31, newDate32);
        }

        for(int i=0;i<orderDetail.size();i++){
            long ms = orderDetail.get(i).getDateCollect().getTime();
            for(int p = 0;p<(dy+21);p++){
                ms += 86400000;
            }
            Date newDate = new Date(ms);
            String coupon = String.valueOf(orderDetail.get(i).getOrder().getId()) + String.valueOf(orderDetail.get(i).getMeal().getId()) + orderDetail.get(i).getSession() + String.valueOf(orderDetail.get(i).getCp()*orderDetail.get(i).getQtt());
            OrderDetail od = new OrderDetail(order, orderDetail.get(i).getMeal(), newDate, orderDetail.get(i).getSession(), orderDetail.get(i).getQtt(), orderDetail.get(i).getCp(), "Pending", ts, coupon);
            orderDetailDA.addNewRecord(od, sid, newDate41, newDate42);
        }

        studentDA.modCP((student.getCpBalance() - ttl), student.getId());
        out.print("Nice");
    }
    else{
        out.print(ttl);
    }
%>



