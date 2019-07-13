<%--    This JSP should be include to restrict a non-user (not logged in) from
        accessing a user page --%>

<%  session = request.getSession(true);
    
    Integer userId  = (Integer) session.getAttribute("currentUserId"); 
    String username = (String) session.getAttribute("currentUsername");
    String userRole = (String) session.getAttribute("currentUserRole");
    
    if (userId == null || username == null || userRole == null) { 
        response.sendRedirect("../portal/login.jsp?msg=redirectBack");  // Redirect to login page, if non-user/no user session is detected
    } 
%>
