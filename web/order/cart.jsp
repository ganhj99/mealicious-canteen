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
 <%@include file="../include/restrictNonUserAccess.jsp" %>
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
<jsp:useBean id="cartDetailDA" class="da.CartDetailDA" scope="application"></jsp:useBean>
<% Student stud =  studControl.selectRecordByUserId(currentUserId); %>
<%      Cart cart = cartDA.checkRecord(stud.getId());    
        if(cart == null){
            cartDA.addRecord(stud.getId());
            cart = cartDA.checkRecord(stud.getId());  
        }  %>     
            
           <!-- Page Content -->
    

      <!-- Page Heading -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">My Shopping Cart</h1>
          </div>
      
         <% ArrayList<CartDetail> cartDetail = new ArrayList<CartDetail>(); %>
         <% cartDetail.addAll(cartDetailDA.getCartDetails(cart.getId())); %>
         <% int ttl = 0; %>
         <% for (int i = 0; i < cartDetail.size(); i++) { %> 
         <div class="wholeCart">
        <div class="card shadow px-2 mb-2"> 
        <div class="row my-2 cartItem">
            <div class="col-md-3">
                    <img class="img-fluid" src="<%= cartDetail.get(i).getMeal().getImg() %>" alt="">        
            </div>  
            <div class="col-md-9">
            <div class="card py-2 px-2">
                <div class="row">
                    <h5 class="col-md-6 text-dark font-weight-bold mb-0"><%= cartDetail.get(i).getMeal().getName() %></h5>
                    <h6 class="col-md-2 pt-1 mb-0"><span class="creditpt"><%= cartDetail.get(i).getCp() %></span> CP</h6>
                   <h6 class="col-md-3 pt-1 mb-0">Subtotal: <strong><span class="subTotal"></span> CP</strong></h6>
                   <button type="button" class="col-md-1 close cancelCart" aria-label="Close" data-toggle="tooltip" title="Cancel Order">
                        <i class="fa fa-times" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
            <div class="card">
                <form class="row py-1 px-1">
                   <div class="col-md-4">
                        <div class="form-group">
                        <label for="Quantity">Quatity</label>
                        <input class="form-control form-control quantity" type="number" value="<%= cartDetail.get(i).getQtt() %>" required="" min="1">
                        <input type="hidden" class="mealID" value="<%= cartDetail.get(i).getMeal().getId() %>">
                        <input type="hidden" class="mses" value="<%= cartDetail.get(i).getSession() %>">
                        <input type="hidden" class="odate" value="<%= cartDetail.get(i).getDateOrder() %>">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="OrderDate">Date</label>
                        <input class="form-control form-control orderDate" type="date" value="<%= cartDetail.get(i).getDateOrder() %>" required="">
                        </div>
                    </div>  
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="mealSession">Session</label>
                        <select class="form-control form-control mealSession">
                          <% if ("Breakfast".equals(cartDetail.get(i).getSession())){ %>
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
                </form>
            </div>
            </div>       
          </div>
          </div>
         </div>
          <% ttl = ttl + (cartDetail.get(i).getCp() *  cartDetail.get(i).getQtt());
          } %>
        <hr>
        <div class="row">
            <div class="col-md-9"></div>
            <h4 class="col-md-3 text-center">Total: <span class="ttlamt"><%= ttl %></span> CP</h4>
            <div class="col-md-9"></div>
            <button type="button" id="placeOrder" class="btn btn-primary btn-lg col-lg-3">Place Order</button>
        </div>




   
    <!-- /.container -->
          
          <!-- content end -->
          </div>

            
        <!-- /.container-fluid -->

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
  
      <!-- INfo Modal -->
      <%@include file="../include/infoModal.jsp" %>
  <!-- End of INfo Modal -->

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
    var cartid = "<%= cart.getId() %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    if(quantity < 1){
        $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
        $('#infoModalTitle').text('Error!');
        $('#infoModalBodyText').html("Quantity must greater than 0");
        $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
        $('#infoModal').modal('show');
    }
    else{
    $.ajax({
    type: 'post',
    url: '../include/updateCartQtt.jsp',
    data: {
        qtt : quantity,
        cid : cartid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        //alert("Uppdate Success");
        $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've successfully updated the quantity of a meal.");
        $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
        $('#infoModal').modal('show');
    }
    });
    }
  })
});
  </script>
  
  <script>
 $(document).ready(function(){
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1;
    var yyyy = today.getFullYear();
    dd = dd - 1 + 3;
     if(dd<10){
            dd='0'+dd
        } 
        if(mm<10){
            mm='0'+mm
        } 
    today = yyyy+'-'+mm+'-'+dd;
    $(".orderDate").each(function(){
        $(this).attr("min", today);
    });
    
  $(".orderDate").change(function(){
    var newDate = $(this).val();
    var cartid = "<%= cart.getId() %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    $.ajax({
    type: 'post',
    url: '../include/updateCartOrderDate.jsp',
    data: {
        newD : newDate,
        cid : cartid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        //alert("Uppdate Success");
        $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've successfully updated the order date of a meal.");
        $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
        $('#infoModal').modal('show');
    }
    });
    
  })
});
  </script>
  
  <script>
 $(document).ready(function(){
  $(".mealSession").change(function(){
    var newMealSession = $(this).val();
    var cartid = "<%= cart.getId() %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    $.ajax({
    type: 'post',
    url: '../include/updateCartSession.jsp',
    data: {
        nses : newMealSession,
        cid : cartid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){
        //alert("Uppdate Success");
        $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've successfully updated the meal session of a meal.");
        $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
        $('#infoModal').modal('show');
    }
    });
    
  })
});
  </script>
  
  <script>
 $(document).ready(function(){
  $(".cancelCart").click(function(){
    var cartid = "<%= cart.getId() %>";
    var mealid = $(this).parentsUntil("div.cartItem").find(".mealID").val();
    var mealSession = $(this).parentsUntil("div.cartItem").find(".mses").val(); 
    var orderDate = $(this).parentsUntil("div.cartItem").find(".odate").val();
    
    $(this).parentsUntil("div.wholeCart").fadeOut("slow",function(){
        $(this).parentsUntil("div.wholeCart").remove();
    });
    
    $.ajax({
    type: 'post',
    url: '../include/cancelCartDetail.jsp',
    data: {
        cid : cartid,
        mid : mealid,
        mses : mealSession,
        odate : orderDate
    },
    success: function(data){

    }
    });
    
  })
});
  </script>
  
  <script>
 $(document).ready(function(){
  $("#placeOrder").click(function(){
    var cartid = "<%= cart.getId() %>";
    var total = $('.ttlamt').text();
    var studcp = "<%= cart.getStud().getCpBalance() %>";

    if(studcp >= total){
        $.ajax({
        type: 'post',
        url: '../include/orderInsert.jsp',
        data: {
            cid : cartid,
            ttl : total
        },
        success: function(data){
            //alert("Place Success");
            $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
            $('#infoModalTitle').text('Success!');
            $('#infoModalBodyText').html("You've successfully placed an order. You can now view it in your Order History.");
            $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
            $('#infoModal').modal('show');
            $(".wholeCart").remove();
            $(".ttlamt").text("0");
        }
        });
    }
    else{
        $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
        $('#infoModalTitle').text('Error!');
        $('#infoModalBodyText').html("Credit point no enough");
        $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
        $('#infoModal').modal('show');
    }
  });
});
  </script>

</body>

</html>
