<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.MaintainWebUserControl, domain.EmailValidator, domain.WebUser" %>

<%  String email = request.getParameter("email"); 
    EmailValidator emailValidator = new EmailValidator();
    if(emailValidator.validateEmail(email)){
        MaintainWebUserControl webUserControl = new MaintainWebUserControl();
    
        WebUser webUser = null;
        webUser = webUserControl.selectRecordWithEmail(email);
    
        if (webUser != null){
            out.print("Email address has been taken.");
        } else {
            out.print("true");
        }
    } else {
        out.print("Please enter a valid email address.");
    }
%>