<%-- 
    Document   : monthlyOrderTable
    Created on : Apr 10, 2019, 1:01:26 AM
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>

<div class="table-responsive orderDateTable">
<table class="table table-bordered" id="dataTable-orderH-cancel" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th>Collect Date</th>
      <th>Session</th>
      <th>Meal Name</th>
      <th>Quantity</th>
      <th>Total Amount(CP)</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <th>Collect Date</th>
      <th>Session</th>
      <th>Meal Name</th>
      <th>Quantity</th>
      <th>Total Amount(CP)</th>
    </tr>
  </tfoot>
  <tbody class="cancelTable">
    <% ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>(); %>
    <% orderDetail.addAll(orderDetailDA.getOrderDetailByDate(sid, sqlStartDate, sqlLastDate)); %>
    <% for(int i=0;i<orderDetail.size();i++){ %>
    <tr>
      <th><%= orderDetail.get(i).getDateCollect() %></th>
      <th><%= orderDetail.get(i).getSession() %></th>
      <th><%= orderDetail.get(i).getMeal().getName() %></th>
      <th><%= orderDetail.get(i).getQtt() %></th>
      <th><%= orderDetail.get(i).getCp() * orderDetail.get(i).getQtt() %></th>
    </tr>
    <% } %>
  </tbody>
</table>
</div>
                  
<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>