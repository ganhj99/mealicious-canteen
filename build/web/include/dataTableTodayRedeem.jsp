<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="da.OrderDetailDA, da.OrderDA , domain.OrderDetail, domain.Order, java.util.ArrayList" %>
<%@ page import="java.sql.Date, java.text.*" %>
<%  OrderDetailDA orderDetailDA = new OrderDetailDA();
    ArrayList<OrderDetail> redeemList = new ArrayList<OrderDetail>();
    redeemList.addAll(orderDetailDA.getAllOrderByDateAndStatus(new Date(System.currentTimeMillis()), "Redeemed")); %>

<div class="table-responsive">
<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th>Coupon Code</th>
      <th>Meal Redeemed At</th>
      <th>Student ID</th>
      <th>Name</th>
      <th>Meal Name</th>
      <th>Session</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <th>Coupon Code</th>
      <th>Meal Redeemed At</th>
      <th>Student ID</th>
      <th>Name</th>
      <th>Meal Name</th>
      <th>Session</th>
    </tr>
  </tfoot>
  <tbody>
      <% for(int i=0; i<redeemList.size(); i++){ %>
    <tr>
      <td>
         <%=  redeemList.get(i).getCoupon() %>
      </td>
      <td>
          <% DateFormat dateFormatTopbar = new SimpleDateFormat("dd MMM yyyy h:mm:ss a"); %>
            <%  if (redeemList.get(i).getRedeem() != null){ %>
            <%= dateFormatTopbar.format(redeemList.get(i).getRedeem()) %>
            <%  } else { %>
            <%= "Not Available" %>
            <% } %>
            </td>
      <td><%=  redeemList.get(i).getOrder().getStudent().getId() %></td>
      <td><%=  redeemList.get(i).getOrder().getStudent().getWebUser().getRealName() %></td>
      <td><%=  redeemList.get(i).getMeal().getName() %></td>
      <td><%=  redeemList.get(i).getSession() %></td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>
