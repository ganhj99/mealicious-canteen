<%-- 
    Document   : verifyEmail
    Created on : Mar 30, 2019, 7:58:10 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%  String email = request.getParameter("email");
%>

<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>

<%-- Get student details from currentUserId --%>
<%@ page import="control.MaintainWebUserControl, domain.WebUser, domain.JWTUtils, domain.SendMail" %>
<%  
    MaintainWebUserControl webUserControl = new MaintainWebUserControl(); 
    boolean isSuccess;
    if (webUserControl.selectRecordWithUserId(currentUserId) != null){
        webUserControl.updateEmailAndStatus(currentUserId, email, false);
        
        String jwt = JWTUtils.createJWT("verifyEmail", currentUserId, email, currentUsername, "NoEncryptedPass", 3600000); //3600000ms = 1 hour
                    
        String msgInHtmlForm = 
            "<h1>Mealicious</h1>" +
            "<p><b>Email Verification</b></p>" +
            "<p>Seems like you want to update your email address for Mealicious. If this is true, click below to verify this email.</p>" +
            "<p>Please click this link to verify your email: "
                + "<a href='" + request.getServerName() + request.getContextPath() + "/servlet/UpdateEmailStatus?jwt=" + jwt + "'>Verify Email</a><p>" +
            "<p>If you did not perform this action, you can safely ignore this email.<p>";

        SendMail.send(email, "Email Verification", msgInHtmlForm);

        isSuccess = true;
    } else {
        isSuccess = false;
    }
%>

<% out.print(isSuccess); %>