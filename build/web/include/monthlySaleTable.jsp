<%-- 
    Document   : dataTableMonthlyTopup
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="control.*, domain.*, da.*, java.util.ArrayList" %>
<%-- Get current session user information --%>

<%  String mn = request.getParameter("month");
    String yr = request.getParameter("year");
    MonthlySaleDA monthlySaleDA = new MonthlySaleDA();
    
    ArrayList<MonthlySale> ms = monthlySaleDA.getRecord(mn, yr); 
    int total = 0; %>
<div class="table-responsive">
<table class="table table-bordered">
    <thead>
    <tr>
      <th scope="col"></th>
      <th scope="col">Meal Name</th>
      <th scope="col">Credit Point(CP)</th>
      <th scope="col">Quantity</th>
      <th scope="col">Subtotal (CP)</th>
    </tr>
  </thead>
  <tbody>
  <% if (ms.size() != 0) { %>
    <% for(int i=0;i<ms.size();i++) { %>
    <tr>
      <th scope="row"><%= i+1 %></th>
      <td><%= ms.get(i).getMealName() %></td>
      <td><%= ms.get(i).getCp() %></td>
      <td><%= ms.get(i).getQtt() %></td>
      <td><%= ms.get(i).getTtl() %></td>
    </tr>
    <% total += ms.get(i).getTtl();
       } %>
    <tr>
      <td colspan="3" class="font-italic text-right">*RM 1.00 is equivalent to 10 Credit Points</td>
      <th scope="row">Grand Total</th>
      <td><%= total %> CP (RM <%= String.format("%.2f", (float)total/10) %>)</td>
    </tr>
  <% } else { %>
    <tr>
        <td colspan="5" class="text-center">No records found for this month. Please try again.</td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

  
<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>
