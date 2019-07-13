<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.MaintainStudentControl, domain.Student" %>

<%  String studentId = request.getParameter("studentId"); 
    MaintainStudentControl studentControl = new MaintainStudentControl();
    if (studentId != null){
        if (studentId.length() == 7){
            Student student = null;
            student = studentControl.selectRecordByStudId(studentId);

            if (student != null){
                out.print("Student ID already exist in the system.");
            } else {
                out.print("true");
            }
        } else {
            out.print("Username must be exactly 7 digits long.");
        }
    }
%>