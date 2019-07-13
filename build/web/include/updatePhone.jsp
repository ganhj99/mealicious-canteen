<%-- 
    Document   : exchangeRmToCp
    Created on : Mar 30, 2019, 7:58:10 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%  String phone = request.getParameter("phone");
    
%>

<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>

<%-- Get student details from currentUserId --%>
<%@ page import="control.MaintainWebUserControl, domain.WebUser, java.sql.*" %>
<%  
    MaintainWebUserControl webUserControl = new MaintainWebUserControl(); 
    boolean isSuccess = true;
    if (webUserControl.selectRecordWithUserId(currentUserId) != null){
        webUserControl.updatePhone(currentUserId, phone);
        long millis=System.currentTimeMillis();  
        Timestamp lastUpdate  = new Timestamp(millis);
        webUserControl.updateLastUpdate(currentUserId, lastUpdate);
        isSuccess = true;
    } else {
        isSuccess = false;
    }
%>

<% out.print(isSuccess); %>