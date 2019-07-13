<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.MaintainWebUserControl, domain.WebUser" %>

<%  String username = request.getParameter("username"); 
    MaintainWebUserControl webUserControl = new MaintainWebUserControl();
    if (username != null){
        if (username.length() >= 6 && username.length() <= 14){
            WebUser webUser = null;
            webUser = webUserControl.selectRecordWithUsername(username);

            if (webUser != null){
                out.print("Username has been taken.");
            } else {
                out.print("true");
            }
        } else {
            out.print("Username must be 6 - 12 characters long.");
        }
    }
%>