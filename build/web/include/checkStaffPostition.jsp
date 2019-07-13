<%--    This JSP should be include to grant access to admin only --%>

<%  
    if (session != null){
        String staffPost = (String) session.getAttribute("currentStaffPost");        
        if (staffPost != null) {
            if (!(userRole.equalsIgnoreCase("Staff") && staffPost.equalsIgnoreCase("Admin")))
                response.sendRedirect("management.jsp"); %>
    <%  } } %>