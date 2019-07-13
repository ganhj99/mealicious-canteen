<%-- 
    Document   : updateStaff
    Created on : Apr 7, 2019, 6:17:06 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>

<%@ page import="control.MaintainStaffControl, control.MaintainStudentControl, control.MaintainTopupControl" %>
<%@ page import="domain.Staff, domain.Student, domain.Topup" %>
<%@ page import="java.sql.*, java.util.Calendar, java.util.ArrayList" %>
<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>
<%  
    //Open Controller for staff, student and topup
    MaintainStaffControl staffControl = new MaintainStaffControl();
    MaintainStudentControl studControl = new MaintainStudentControl();
    MaintainTopupControl topupControl = new MaintainTopupControl();
    
    // Retrieve data from parameter
    Integer staffId = Integer.valueOf(staffControl.selectRecord(currentUserId).getId());
    String studentId = request.getParameter("studentId");
    int topupAmt = Integer.valueOf(request.getParameter("topupAmt"));
    
    //Create staff, student domain
    Student stud = studControl.selectRecordByStudId(studentId);
    Staff staff = staffControl.selectRecordByStaffId(staffId);
    //Update stud balance in student domain
    stud.setCpBalance(stud.reloadCreditPoint(topupAmt));
    //Current timestamp
    Timestamp currentTimestamp = new Timestamp(Calendar.getInstance().getTime().getTime());
    //Create topup domain
    Topup topup = new Topup(currentTimestamp, topupAmt, stud, staff);
    //Insert topup to db
    topupControl.insertRecord(topup);
    //Update stud cp balance to db
    studControl.updateCreditBalance(stud.getId(), stud.getCpBalance());
 
    
%>

<%@include file="../include/dataTableTodayTopupRecord.jsp" %>

