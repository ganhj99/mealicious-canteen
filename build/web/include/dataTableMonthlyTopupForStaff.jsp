<%-- 
    Document   : dataTableMonthlyTopup
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.*, domain.*, java.util.ArrayList, java.sql.*" %>
<%-- Get current session user information --%>
<%  String month = request.getParameter("month");
    String year = request.getParameter("year");
    MaintainTopupControl topupControlForTable = new MaintainTopupControl();
    ArrayList<Topup> topupList = topupControlForTable.retrieveAllMonthRecordForStaff(month, year); %>
    
     <% //CreateConnection
     String host = "jdbc:derby://localhost:1527/mealiciousDB";
     String user = "nbuser";
     String password = "nbuser";
     Connection conn = null;
     PreparedStatement stmt;
     try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
        }
%>

<%  //Get record from database using multitable query
     String queryStr = "SELECT TOPUP_AMT, COUNT(*), SUM(TOPUP_AMT) " +
                        "FROM TOPUP " +
                        "WHERE MONTH(TOPUP_DATE) = ? AND YEAR(TOPUP_DATE) = ? " +
                        "GROUP BY TOPUP_AMT " +
                        "ORDER BY TOPUP_AMT ";
     try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, month);
            stmt.setString(2, year);
            ResultSet rs = stmt.executeQuery(); %>
    
<div class="table-responsive">
<table class="table table-bordered" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th></th>
      <th>Topup Amount</th>
      <th>Number of Students Topup</th>
      <th>Total Topup Amount</th>
    </tr>
  </thead>
  <tbody>
    <% int i = 1, total = 0; %>
    <% while (rs.next()) {%>
    <tr>
      <td><%= i %></td>
      <td><%= rs.getString(1) %></td>
      <td><%= String.valueOf(rs.getInt(2)) %></td>
      <td><%= String.valueOf(rs.getInt(3)) %></td>
    </tr>
    <% total += rs.getInt(3); %>
     <% i++; }%>
    <% if (i==1){ %>
    <tr>
        <td colspan="4" class="text-center">No records found for this month. Please try again.</td>
    </tr>
    <% } else { %>
    <tr>
      <td colspan="2" class="font-italic text-right">*RM 1.00 is equivalent to 10 Credit Points</td>
      <th scope="row">Grand Total</th>
      <td><%= total %> CP (RM <%= String.format("%.2f", (float)total/10) %>)</td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>
<% } catch (SQLException ex) {
out.print(ex);
        }
%>