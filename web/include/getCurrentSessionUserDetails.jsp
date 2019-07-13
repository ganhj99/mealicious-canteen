<%--    This JSP should be include to check current session user role (student or staff) only --%>

<%  Integer currentUserId = null;
    String currentUsername = null;
    String currentUserRole = null;
    String currentStaffPost = null;
    
    //if (session != null){
        currentUserId  = (Integer) session.getAttribute("currentUserId");
        currentUsername = (String) session.getAttribute("currentUsername");
        currentUserRole = (String) session.getAttribute("currentUserRole");
        
        if (currentUserId != null || currentUsername != null || currentUserRole != null) {
            if (("Student".equalsIgnoreCase(currentUserRole))){
                
            } else if (("Staff".equalsIgnoreCase(currentUserRole))){
                currentStaffPost = (String) session.getAttribute("currentStaffPost");
            } 
        }
    //} 
%>