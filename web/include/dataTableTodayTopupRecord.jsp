<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.MaintainTopupControl, domain.Topup, java.util.ArrayList, java.text.*, java.sql.*" %>
<%  MaintainTopupControl topupControlForTable = new MaintainTopupControl();
    ArrayList<Topup> topupList = topupControlForTable.retrieveAllTodayRecord(new Timestamp(System.currentTimeMillis())); %>
<div class="table-responsive">
<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th>Reload ID</th>
      <th>Top Up Date & Time</th>
      <th>Student ID</th>
      <th>Name</th>
      <th>Points Credited (CP)</th>
      <th>Managed By</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <th>Reload ID</th>
      <th>Top Up Date & Time</th>
      <th>Student ID</th>
      <th>Name</th>
      <th>Points Credited (CP)</th>
      <th>Managed By</th>
    </tr>
  </tfoot>
  <tbody>
    <% for(int i=0; i<topupList.size(); i++){ %>
    <tr>
      <td><%= topupList.get(i).getId() %></td>
      <td>
      <% DateFormat dateFormatTopbar = new SimpleDateFormat("dd MMM yyyy h:mm:ss a"); %>
                                <%  if (topupList.get(i).getTopupDate() != null){ %>
                                <%= dateFormatTopbar.format(topupList.get(i).getTopupDate()) %>
                                <%  } else { %>
                                <%= "Not Available" %>
                                <% } %>
                                </td>
      <td><%=  topupList.get(i).getStudent().getId() %></td>
      <td><%=  topupList.get(i).getStudent().getWebUser().getRealName() %></td>
      <td><%=  topupList.get(i).getTopupAmt() %></td>
      <td><%=  topupList.get(i).getStaff().getWebUser().getRealName() %></td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>