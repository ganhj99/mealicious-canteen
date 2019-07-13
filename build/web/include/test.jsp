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

<%  OrderDetailDA orderDetailDA = new OrderDetailDA();
    
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
    
    String startDate = yr1 + "-" + mn1 + "-" + dy1;
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    
    String LastDate = yr2 + "-" + mn2 + "-" + dy2;
    java.util.Date ldate = sdf1.parse(LastDate);
    java.sql.Date sqlLastDate = new java.sql.Date(ldate.getTime());
    
    
%>

<%@include file="../include/monthlyOrderTable.jsp" %>

