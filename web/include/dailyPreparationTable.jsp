<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>

<div class="table-responsive dailyPreparationTable">
<table class="table table-bordered" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th></th>
      <th>Ingredient Name</th>
      <th>Size</th>
      <th>Unit</th>
    </tr>
  </thead>
  <tbody>
      <% ArrayList<DailyPreparation> dailyPreparation = new ArrayList<DailyPreparation>(); %>
      <% dailyPreparation = dailyPreparationDA.getRecord(sqlStartDate); %>
      <% if (dailyPreparation.size() != 0){ %>
      <% for (int i = 0; i < dailyPreparation.size(); i++) { %>
    <tr>
      <td><%= i+1 %></td>
      <td><%= dailyPreparation.get(i).getMealName() %></td>
      <td><%= dailyPreparation.get(i).getSize() %></td>
      <td><%= dailyPreparation.get(i).getUnit() %></td>
    </tr>
    <% } %>
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