<%-- 
    Document   : exchangeRmToCp
    Created on : Mar 30, 2019, 7:58:10 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%  String password = request.getParameter("password");
    String cfmPassword = request.getParameter("cfmPassword");
%>

<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>

<%-- Get student details from currentUserId --%>
<%@ page import="control.MaintainWebUserControl, domain.WebUser, domain.PasswordUtils, java.sql.*" %>
<%  
    MaintainWebUserControl webUserControl = new MaintainWebUserControl(); 
    boolean isSuccess;
    if (webUserControl.selectRecordWithUserId(currentUserId) != null){
        String passSalt = PasswordUtils.getSalt(30);
        String passEncrypted = PasswordUtils.generateEncryptedPassword(password, passSalt);
        webUserControl.updatePassword(currentUserId, passEncrypted, passSalt);
        long millis=System.currentTimeMillis();  
        Timestamp lastUpdate  = new Timestamp(millis);
        webUserControl.updateLastLogin(currentUserId, lastUpdate);
        isSuccess = true;
    } else {
        isSuccess = false;
    }
%>

<% out.print(isSuccess); %>