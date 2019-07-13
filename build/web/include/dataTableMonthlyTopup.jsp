<%-- 
    Document   : dataTableMonthlyTopup
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.*, domain.*, java.util.ArrayList, java.text.*" %>
<%-- Get current session user information --%>
<%@include file="../include/getCurrentSessionUserDetails.jsp" %>
<%  String month = request.getParameter("month");
    String year = request.getParameter("year");
    MaintainTopupControl topupControlForTable = new MaintainTopupControl();
    MaintainStudentControl studControlForTable = new MaintainStudentControl();
    ArrayList<Topup> topupList = topupControlForTable.retrieveAllMonthRecordForStud(studControlForTable.selectRecordByUserId(currentUserId).getId(), month, year); %>
    
    <% if(topupList.size()==0){ %>
        <%= false %>
    <% } else { %>
    
<div class="table-responsive">
<table class="table table-bordered" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th>Topup ID</th>
      <th>Topup Date</th>
      <th>Credit Points Reloaded (CP)</th>
    </tr>
  </thead>
  <tbody>
    <% DateFormat dateFormatTopbar = new SimpleDateFormat("dd MMM yyyy h:mm:ss a"); %>
    <% for(int i=0; i<topupList.size(); i++){ %>
    <tr>
      <td><%= topupList.get(i).getId() %></td>
      <td><%  if (topupList.get(i).getTopupDate() != null){ %>
          <%= dateFormatTopbar.format(topupList.get(i).getTopupDate()) %>
          <%  } else { %>
          <%= "Not Available" %>
          <% } %>
      </td>
      <td><%=  topupList.get(i).getTopupAmt() %></td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>
<% } %>