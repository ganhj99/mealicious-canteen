<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@page import="java.text.*"%>
<%@page import="domain.*"%>
<%@page import="da.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>

<div class="tab-content mb-4 card-body animated--grow-in col-12 pt-0 succesOrder" id="pills-tabContent">
<div class="tab-pane fade show active col-12" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">

    <div class="table-responsive">
    <table class="table table-bordered" id="dataTable-orderH-sucess" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Order Date & Time</th>
          <th>Total Amount(CP)</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th>Order ID</th>
          <th>Order Date & Time</th>
          <th>Total Amount(CP)</th>
          <th>Actions</th>
        </tr>
      </tfoot>
      <tbody>
        
        <% ArrayList<Order> order = new ArrayList<Order>(); %>
        <% order.addAll(orderDA.getAllOrder(studID)); %>
        <% for(int i=0;i<order.size();i++){ 
            if("Success".equals(order.get(i).getStatus())){ %>
        <tr>
            <td class="orderID"><a href="orderDetail.jsp?orderID=<%= order.get(i).getId() %>"><%= order.get(i).getId() %></a></td>
          <% String ts = new SimpleDateFormat("dd-MM-yyyy HH:mm").format(order.get(i).getDateOrder()); %>
            <td class="orderTimestamp"><%= ts %></td>
            <td class="orderTtl"><%= order.get(i).getTtlcp() %></td>
          <td>
              <a href="orderDetail.jsp?orderID=<%= order.get(i).getId() %>" class="btn btn-info btn-sm">
                <span class="icon text-white-50">
                    <i class="fas fa-edit"></i>
                 </span>
                </a>

          </td>
        </tr>
        <% }
         } %>

      </tbody>
    </table>
    </div>
</div>


<div class="tab-pane fade col-12" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">

  <div class="table-responsive">
    <table class="table table-bordered" id="dataTable-orderH-cancel" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Order Date & Time</th>
          <th>Total Amount(CP)</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th>Order ID</th>
          <th>Order Date & Time</th>
          <th>Total Amount(CP)</th>
        </tr>
      </tfoot>
      <tbody class="cancelTable">
        <% ArrayList<Order> orderCancel = new ArrayList<Order>(); %>
        <% orderCancel.addAll(orderDA.getAllOrder("Kuredo")); %>
        <% for(int i=0;i<orderCancel.size();i++){ 
            if("Cancel".equals(order.get(i).getStatus())){ %>
        <tr>
          <td><a href="orderDetail.jsp?oderID=<%= orderCancel.get(i).getId() %>"><%= orderCancel.get(i).getId() %></a></td>
          <% DateFormat ts = new SimpleDateFormat("dd MMM yyyy h:mm a"); %>
          <td><%= ts.format(orderCancel.get(i).getDateOrder()) %></td>
          <td><%= orderCancel.get(i).getTtlcp() %></td>
        </tr>
        <% }
         } %>
      </tbody>
    </table>
  </div>
</div>

</div> 

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>