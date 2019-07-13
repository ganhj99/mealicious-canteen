<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>

<div class="tab-pane fade col-12 cancelledOrderDetail" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
<% ArrayList<OrderDetail> orderDetail3 = new ArrayList<OrderDetail>(); %>
<% orderDetail3.addAll(orderDetailDA.getAllOrder(orderID)); %>
<% for(int i=0; i<orderDetail3.size(); i++){ %>    
<% if("Cancel".equals(orderDetail3.get(i).getStatus())) {%>
<div class="wholeCart">
<div class="card shadow px-2 mb-2"> 
<div class="row my-2 cartItem">
    <div class="col-md-3">
            <img class="img-fluid" src="<%= orderDetail3.get(i).getMeal().getImg() %>" alt="">        
    </div>  
    <div class="col-md-9">
    <div class="card py-2 px-2">
        <div class="row">
            <h5 class="col-md-7 text-dark font-weight-bold mb-0"><%= orderDetail3.get(i).getMeal().getName() %></h5>
            <h6 class="col-md-2 pt-1 mb-0"><span class="creditpt"><%= orderDetail3.get(i).getCp() %></span> CP</h6>
            <h6 class="col-md-3 pt-1 mb-0">Subtotal: <strong><span class="subTotal"><%= orderDetail3.get(i).getCp() * orderDetail3.get(i).getQtt() %></span> CP</strong></h6>
        </div>
    </div>
    <div class="card">
        <form class="row py-1 px-1">
           <div class="col-md-4">
                <div class="form-group">
                <label for="Quantity">Quatity</label>
                <input class="form-control form-control-sm quantity" disabled type="number" value="<%= orderDetail3.get(i).getQtt() %>" required="" min="1">
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                <label for="OrderDate">Date</label>
                <input class="form-control form-control-sm orderDate" disabled type="date" value="<%= orderDetail3.get(i).getDateCollect() %>" required="">
                </div>
            </div>  
            <div class="col-md-4">
                <div class="form-group">
                <label for="mealSession">Session</label>
                <input class="form-control form-control-sm mealSession" disabled type="text" value="<%= orderDetail3.get(i).getSession() %>" required="">
                </div>
            </div>
        </form>
    </div>
    </div>       
  </div>
  </div>
 </div>
<% } 
 } %>
<hr>
</div>

 

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>