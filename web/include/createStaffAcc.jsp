<%-- 
    Document   : exchangeRmToCp
    Created on : Mar 30, 2019, 7:58:10 PM
    Author     : USER
--%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.MaintainStaffControl, control.MaintainWebUserControl, domain.Staff, domain.WebUser, domain.PasswordUtils, java.sql.Date" %>
<%  String username = request.getParameter("username");
    String realName = request.getParameter("realName");
    String position = request.getParameter("position");
    Date hireDate = Date.valueOf(request.getParameter("hireDate"));
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
%>

<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>

<%  long millis=System.currentTimeMillis();  
    Date dateNow = new Date(millis);
    String passSalt = PasswordUtils.getSalt(30);
    String passEncrypted = PasswordUtils.generateEncryptedPassword(phone, passSalt); // Using phone as default/firstimelogin password
    WebUser webUser = new WebUser(username, realName, phone, email, false, dateNow, null, null, passEncrypted, passSalt, "Staff"); // To be sent to database

    MaintainWebUserControl webUserControl = new MaintainWebUserControl();
    MaintainStaffControl staffControl = new MaintainStaffControl();
    webUserControl.insertRecord(webUser); // Add record, to generate id in database.
    webUser = webUserControl.selectRecordWithUsername(username); // Get webUser all attrb including database generated id

    Staff staff = new Staff(position, "New", hireDate, null, webUser); // Staff all attrb including webUser's generated id
    staffControl.insertRecord(staff);
%>

<% out.print(username); %>