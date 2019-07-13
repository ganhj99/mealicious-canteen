<%@page import="java.util.ArrayList"%>
<%@page import="domain.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Mealicious</title>

  <!-- Custom fonts for this template-->
  <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="../css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>   
</head>

<body id="page-top">
      <%-- Get current session user information --%>
    <%@include file="../include/getCurrentSessionUserDetails.jsp" %>
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <%@include file="../include/sidebar.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <%@include file="../include/topbar.jsp" %>
        <!-- End of Topbar -->
        
        <!-- Begin Page Content -->
        <div class="container-fluid">
            
        <jsp:useBean id="mealDA" class="da.MealDA" scope="application"></jsp:useBean>  
        <jsp:useBean id="studControl" class="control.MaintainStudentControl" scope="application"></jsp:useBean>
        <jsp:useBean id="cartDA" class="da.CartDA" scope="application"></jsp:useBean>
        <jsp:useBean id="orderDA" class="da.OrderDA" scope="application"></jsp:useBean>
        <jsp:useBean id="orderDetailDA" class="da.OrderDetailDA" scope="application"></jsp:useBean>
        <% Student stud = studControl.selectRecordByUserId(currentUserId);%>
        <%      Cart cart = cartDA.checkRecord(stud.getId());    
                if(cart == null){
                    cartDA.addRecord(stud.getId());
                    cart = cartDA.checkRecord(stud.getId());  
                }  %>     

           <!-- Page Content -->

      <!-- Page Heading -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Order Details</h1>
          </div>

          <!-- Content Row -->
          <ul class="nav nav-pills mb-3 nav-justified card-header py-3 animated--grow-in" id="pills-tab" role="tablist">
          <li class="nav-item align-items-center">
            <a class="nav-link active mb-0" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Pending</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-0" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Redeemed</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-0" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Cancelled</a>
          </li>
          </ul>
        <div class="tab-content mb-4 card-body animated--grow-in col-12 pt-0" id="pills-tabContent">
        <div class="tab-pane fade show active col-12" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
        <% ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>(); %>
        <%  int orderID = Integer.parseInt(request.getParameter("orderID"));
            orderDetail.addAll(orderDetailDA.getAllOrder(orderID)); %>
        <% for(int i=0; i<orderDetail.size(); i++){ %>    
        <% if("Pending".equals(orderDetail.get(i).getStatus())) {%>
        <div class="wholeCart">
        <div class="card shadow px-2 mb-2"> 
        <div class="row my-2 cartItem">
            <div class="col-md-3">
                    <img class="img-fluid" src="<%= orderDetail.get(i).getMeal().getImg() %>" alt="">        
            </div>  
            <div class="col-md-9">
            <div class="card py-2 px-2">
                <div class="row">
                    <h5 class="col-md-6 text-dark font-weight-bold mb-0"><%= orderDetail.get(i).getMeal().getName() %></h5>
                    <h6 class="col-md-2 pt-1 mb-0"><span class="creditpt"><%= orderDetail.get(i).getCp() %></span> CP</h6>
                   <h6 class="col-md-3 pt-1 mb-0">Subtotal: <strong><span class="subTotal"></span> CP</strong></h6>
                   <button type="button" class="col-md-1 close cancelOrder" aria-label="Close" data-toggle="tooltip" title="Cancel Order">
                        <i class="fa fa-trash" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
            <div class="card">
                <form class="row py-1 px-1">
                   <div class="col-md-4">
                        <div class="form-group">
                        <label for="Quantity">Quantity</label>
                        <input class="form-control form-control-sm quantity" type="number" value="<%= orderDetail.get(i).getQtt() %>" required="" min="1">
                        <input type="hidden" class="mealID" value="<%= orderDetail.get(i).getMeal().getId() %>">
                        <input type="hidden" class="mses" value="<%= orderDetail.get(i).getSession() %>">
                        <input type="hidden" class="odate" value="<%= orderDetail.get(i).getDateCollect() %>">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="mealSession">Session</label>
                        <select class="form-control form-control-sm mealSession">
                          <% if ("Breakfast".equals(orderDetail.get(i).getSession())){ %>
                          <option selected value="Breakfast">Breakfast</option>
                          <option value="Lunch">Lunch</option>
                          <% } 
                            else{ %>
                          <option value="Breakfast">Breakfast</option>
                          <option selected value="Lunch">Lunch</option>
                           <% } %>
                        </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="OrderDate">Date</label>
                        <input class="form-control form-control-sm orderDate" disabled type="date" value="<%= orderDetail.get(i).getDateCollect() %>" required="">
                        </div>
                    </div>
                </form><div class='row'><div class="col-md-4"></div><div class="col-md-4"></div><div class="col-md-4">
                        <% DateFormat dateFormat = new SimpleDateFormat("dd MMMMM yyyy "); %>
                        <button id='viewCouponBtn' type='button' class='btn btn-primary col-12 viewCouponBtn' data-toast-icon="fe-icon-check-circle" 
                                data-toast-title="Success!" data-toast-collect-date="<%= dateFormat.format(orderDetail.get(i).getDateCollect()) %>" 
                                data-toast-session="<%= orderDetail.get(i).getSession() %>" 
                                data-toast-meal-name="<%= orderDetail.get(i).getMeal().getName() %>" 
                                data-toast-barcode="<img src='../servlet/BarcodeServlet?code=<%= orderDetail.get(i).getCoupon() %>' 
                                class='img-fluid text-gray-800'/>">View coupon</button>
                    </div></div>
                        
            </div>
            </div>       
          </div>
          </div>
         </div>
        <% } 
         } %>
        <hr>
        </div>
        
        <div class="tab-pane fade col-12" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
        <% ArrayList<OrderDetail> orderDetail2 = new ArrayList<OrderDetail>(); %>
        <% orderDetail2.addAll(orderDetailDA.getAllOrder(orderID)); %>
        <% for(int i=0; i<orderDetail2.size(); i++){ %>    
        <% if("Redeemed".equals(orderDetail2.get(i).getStatus())) {%>
        <div class="wholeCart">
        <div class="card shadow px-2 mb-2"> 
        <div class="row my-2 cartItem">
            <div class="col-md-3">
                    <img class="img-fluid" src="<%= orderDetail2.get(i).getMeal().getImg() %>" alt="">        
            </div>  
            <div class="col-md-9">
            <div class="card py-2 px-2">
                <div class="row">
                    <h5 class="col-md-7 text-dark font-weight-bold mb-0"><%= orderDetail2.get(i).getMeal().getName() %></h5>
                    <h6 class="col-md-2 pt-1 mb-0"><span class="creditpt"><%= orderDetail2.get(i).getCp() %></span> CP</h6>
                   <h6 class="col-md-3 pt-1 mb-0">Subtotal: <strong><span class="subTotal"></span> CP</strong></h6>

                </div>
            </div>
            <div class="card">
                <form class="row py-1 px-1">
                   <div class="col-md-4">
                        <div class="form-group">
                        <label for="Quantity">Quantity</label>
                        <input class="form-control form-control-sm quantity" disabled type="number" value="<%= orderDetail2.get(i).getQtt() %>" required="" min="1">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="OrderDate">Date</label>
                        <input class="form-control form-control-sm orderDate" disabled type="date" value="<%= orderDetail2.get(i).getDateCollect() %>" required="">
                        </div>
                    </div>  
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="mealSession">Session</label>
                        <input class="form-control form-control-sm mealSession" disabled type="text" value="<%= orderDetail2.get(i).getSession() %>" required="">
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
        
        <%@include file="../include/cancelledOrderList.jsp" %>

      <!-- /.row -->
        </div>
    </div>
    <!-- /.container -->


      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <%@include file="../include/footer.jsp" %>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>
  
    <!-- Info Modal -->
      <%@include file="../include/infoModal.jsp" %>
  <!-- End of Info Modal -->

    <!-- Logout Modal -->
      <%@include file="../include/logoutModal.jsp" %>
  <!-- End of Logout Modal -->

  <!-- Bootstrap core JavaScript-->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="../js/bootstrap-formhelpers-phone.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../js/sb-admin-2.min.js"></script>
  <script>
 $(document).ready(function(){
  $(".quantity").change(function(){
    var quantity = $(this).val();
    var creditpt = $(this).parentsUntil("div.cartItem").find("span.creditpt").text();
    var subTotal = quantity * creditpt;
    
    $(this).parentsUntil("div.cartItem").find("span.subTotal").html(subTotal);
    var ttlamt = 0;
    $('.subTotal').each(function(){
        ttlamt += parseInt($(this).text());
    });
    $('.ttlamt').html(ttlamt);

  }).trigger('change');
});
  </script>
  
  <script>
 $(document).ready(function(){
  $(".quantity").change(function(){
    var quantity = $(this).val();
    var orderid = "<%= orderID %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    $.ajax({
    type: 'post',
    url: '../include/updateOrderQtt.jsp',
    data: {
        qtt : quantity,
        cid : orderid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        alert("Uppdate qtt Success");
    }
    });
  })
});
  </script>
 
  <script>
 $(document).ready(function(){
  $(".orderDate").change(function(){
    var newDate = $(this).val();
    var orderid = "<%= orderID %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    $.ajax({
    type: 'post',
    url: '../include/updateOrderDateCollect.jsp',
    data: {
        newD : newDate,
        oid : orderid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        alert("Uppdate date Success");
    }
    });
    
  })
});
  </script> 
  
  <script>
 $(document).ready(function(){
  $(".mealSession").change(function(){
    var newMealSession = $(this).val();
    var orderid = "<%= orderID %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();

    $.ajax({
    type: 'post',
    url: '../include/updateOrderSession.jsp',
    data: {
        nses : newMealSession,
        oid : orderid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        alert("Uppdate ses Success");
    }
    });
    
  })
});
  </script>
  
  <script>
 $(document).ready(function(){
  $(".cancelOrder").click(function(){
    var orderid = "<%= orderID %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    dd = dd - 1 + 1;
     if(dd<10){
            dd='0'+dd
        } 
        if(mm<10){
            mm='0'+mm
        } 
    today = yyyy+'-'+mm+'-'+dd;
    
    if(orderDate > today){
    $(this).parentsUntil("div.wholeCart").fadeOut("slow",function(){
        $(this).parentsUntil("div.wholeCart").remove();
    });
    
    $.ajax({
    type: 'post',
    url: '../include/cancelOrderDetail.jsp',
    data: {
        oid : orderid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        $('.cancelledOrderDetail').replaceWith(data);
    }
    });
    }
    else{
        alert("Cancelation of an order must be one day before");
    }
  });
  
  //$('#viewCouponBtn').click(function(){
  //      $('#infoModalBodyText').html($('#viewCouponBtn').attr('data-toast-barcode') + '<hr><b>Meal Name</b>: ' +
  //      $('#viewCouponBtn').attr('data-toast-meal-name') + '<br><b>Collection Date</b>: ' +
  //      $('#viewCouponBtn').attr('data-toast-collect-date') + '<br><b>Session</b>: ' +
  //      $('#viewCouponBtn').attr('data-toast-session'));
  //      $('#infoModalBtn').addClass('btn-primary')
  //      $('#infoModal').modal('show');
  //  });
    
    
    $('.viewCouponBtn').click(function(){
        $('#infoModalBodyText').html($(this).attr('data-toast-barcode') + '<hr><b>Meal Name</b>: ' +
        $(this).attr('data-toast-meal-name') + '<br><b>Collection Date</b>: ' +
        $(this).attr('data-toast-collect-date') + '<br><b>Session</b>: ' +
        $(this).attr('data-toast-session'));
        $('#infoModalBtn').addClass('btn-primary')
        $('#infoModal').modal('show');
    });
    
    
    
});
  </script>
  
</body>

</html>
