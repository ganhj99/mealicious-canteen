<%-- 
    Document   : updateStaff
    Created on : Apr 7, 2019, 6:17:06 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%@ page import="control.*, domain.*, java.sql.*, java.text.*" %>
<%  
        Integer staffUserId = Integer.valueOf(request.getParameter("staffUserId"));
        String position = request.getParameter("position");
        String status = request.getParameter("status");

        MaintainStaffControl staffControl = new MaintainStaffControl();
        MaintainWebUserControl webUserControl = new MaintainWebUserControl();
        Staff staff = staffControl.selectRecord(staffUserId);
        if(!staff.getPosition().equalsIgnoreCase(position)){
            staffControl.updatePosition(staffUserId, position);
            long millis=System.currentTimeMillis();  
            Timestamp lastUpdate  = new Timestamp(millis);
            webUserControl.updateLastUpdate(staffUserId, lastUpdate);
        } else {
            out.print("0"); // No changes will be made
        }
        if(!staff.getStatus().equalsIgnoreCase(status)){
            if("Active".equalsIgnoreCase(status)){
                out.println("1");
                staffControl.updateStatus(staffUserId, status, null);
            } else if("Quit".equalsIgnoreCase(status)){
                out.println("2");
                staffControl.updateStatus(staffUserId, status, Date.valueOf(request.getParameter("endDate")));
            } 
            webUserControl.updateLastUpdate(staffUserId, new Timestamp(System.currentTimeMillis()));
        } else {
            out.print("0"); // No changes will be made
        }
       
    
%>