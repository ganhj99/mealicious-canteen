<%@page import="java.util.ArrayList"%>
<%@page import="domain.*"%>
<%@page import="da.*"%>

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
  <link href="../css/ja.css" rel="stylesheet">
  <link href="../css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
  
</head>

<body id="page-top">
<jsp:useBean id="mealDA" class="da.MealDA" scope="application"></jsp:useBean>  
<jsp:useBean id="studControl" class="control.MaintainStudentControl" scope="application"></jsp:useBean>
<jsp:useBean id="cartDA" class="da.CartDA" scope="application"></jsp:useBean>
<jsp:useBean id="cartDetailDA" class="da.CartDetailDA" scope="application"></jsp:useBean>
        <%-- Get current session user information --%>
    <%@include file="../include/getCurrentSessionUserDetails.jsp" %>
<% Student stud =  studControl.selectRecordByUserId(currentUserId); %>
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


<%      double fats = 0;
        double carbs = 0;
        double prot = 0;
        double calorie = 0;
        Cart cart = cartDA.checkRecord(stud.getId());    
        if(cart == null){
            cartDA.addRecord(stud.getId());
            cart = cartDA.checkRecord(stud.getId());  
        }  %> 
        <jsp:useBean id="recipeDA" class="da.RecipeDA" scope="application"></jsp:useBean> 
<% Meal meal = mealDA.getRecord(Integer.parseInt(request.getParameter("mealid"))); %>
      <% ArrayList<Recipe> recipe = new ArrayList<Recipe>(); %>
        <% recipe = recipeDA.getAllMeal(meal.getId()); %>
        <!-- Begin Page Content -->
        <div class="container-fluid">
<!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%= meal.getName() %></h1>
          </div>
  <div class="row">
      <div class="col-md-12">
  <!-- Portfolio Item Heading -->
  <div class="card shadow mb-4">
      <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Meal Information</h6>
            </div>

  <!-- Portfolio Item Row -->
  <div class="card-body">
  <div class="row">

    <div class="col-md-3">
      <img class="img-fluid" src="<%= meal.getImg() %>" alt="">
    </div>

    <div class="col-md-5">
        
      <h6 class="my-2 text-dark font-weight-bold">Category</h6>
      <p><%= meal.getCategory().getName() %></p>
      <h6 class="my-2 text-dark font-weight-bold">Description</h6>
      <p><%= meal.getDesc() %></p>
      </div>
      <div class="col-md-4">
          <h6 class="my-2 text-dark font-weight-bold">Main Ingredients</h6>
          <table class="table table-bordered text-sm">
          <thead>
            <tr>
                <th class="text-center p-2">#</th>
                <th class="p-2">Ingredient</th>
                <th class="p-2">Servings</th>
            </tr>
          </thead>
          <% for(int i=0;i<recipe.size();i++) { %>
          <tr>
              <td class="text-center p-2"><%= i+1 %></td>
              <td class="p-2"><%= recipe.get(i).getIngredient().getName() %></td>
              <td class="p-2"><%= recipe.get(i).getSize() %> <%= recipe.get(i).getUnit() %></td>
          </tr>
          <%  fats += recipe.get(i).getIngredient().getFat();
            carbs += recipe.get(i).getIngredient().getCarb();
            prot += recipe.get(i).getIngredient().getProtein();
            calorie += recipe.get(i).getIngredient().calCalorie();
            } %>
            </table>
      </div>
      
  </div> 
  </div>
  </div>
      </div>

  </div>
      
  <!-- /.row -->
  
  <div class="row">
  
      <div class="col-lg-6 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Add to cart</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
                <form class="row">
                    <% String ses = request.getParameter("mealSes"); %>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="cp">Credit Points</label>
                        <div class="input-group">
                        <input disabled="disabled" class="form-control" id="cp" type="number" value="<%= meal.getCp() %>">
                        <div class="input-group-append">
                            <span class="input-group-text" id="topupCashAmtPrepend2">CP</span>
                        </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input class="form-control" type="number" name="qtt" id="quantity" value="1" required="" min="1">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="session">Session</label>
                        <input class="form-control" type="text" name="meallsession" id="meallsession" value='<%= ses %>' disabled=''>
                    </div>
                </div>   
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="OrderDate">Date</label>
                        <input class="form-control" type="date" name="orderDate" id="orderDate" required="">
                    </div>
                </div>   
                <div class="col-6"><div></div></div>
                <div class="col-6"><div></div></div>
                <div class="col-12">
                    <hr class="mt-2 mb-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div id="haha"></div>
                        <button id="addtoca" class="btn btn-style-1 btn-primary" type="button" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Add to cart successfuly.">Add to cart</button>
                    </div>
                </div>
                </form>
            </div>
            </div>
            </div>
      
      <div class="col-lg-6 mb-4">
          <div class="card shadow">
              <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Macronutrient Ratio</h6>
                </div>
              <div class="card-body py-2">
              <div class="chart-pie">
                <canvas id="myPieChart"></canvas>
              </div>
              <hr>
              <div class="pb-2 text-center font-weight-bold"><%= meal.getCalorie() %> calories</div>
              </div>
          </div>
        </div>
     
  </div>
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

  <script src="../vendor/chart.js/Chart.min.js"></script>
  <!-- Custom scripts for all pages-->
    <script type="text/javascript">
		$(document).ready(function() {
                    // Set new default font family and font color to mimic Bootstrap's default styling
                    Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                    Chart.defaults.global.defaultFontColor = '#858796';

                    // Pie Chart Example
                    var ctx = document.getElementById("myPieChart");
                    var fat = parseFloat("<%= fats %>").toFixed(2);
                    var carb = parseFloat("<%= carbs %>").toFixed(2);;
                    var prot = parseFloat("<%= prot %>").toFixed(2);;
                    
                    var myPieChart = new Chart(ctx, {
                      type: 'doughnut',
                      data: {
                        labels: ["Fats", "Carbs", "Protein"],
                        datasets: [{
                          data: [fat, carb, prot],
                          backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
                          hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
                          hoverBorderColor: "rgba(234, 236, 244, 1)",
                        }],
                      },
                      options: {
                        maintainAspectRatio: false,
                        tooltips: {
                          backgroundColor: "rgb(255,255,255)",
                          bodyFontColor: "#858796",
                          borderColor: '#dddfeb',
                          borderWidth: 1,
                          xPadding: 15,
                          yPadding: 15,
                          displayColors: false,
                          caretPadding: 10,
                        },
                        legend: {
                          display: false
                        },
                        cutoutPercentage: 80,
                      },
                    });
                							
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
    $("#orderDate").attr("min", today);
     
  $("#addtoca").click(function(){
    var creditpt = $('#cp').val();
    var quantity = $('#quantity').val();
    var dateOrder = $('#orderDate').val();
    var cartid = "<%= cart.getId() %>";
    var mealid = "<%= meal.getId() %>";
    var mealsession = "<%= ses %>";

    if(quantity < 1){
        $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
        $('#infoModalTitle').text('Error!');
        $('#infoModalBodyText').html("Quantity must greater than 0");
        $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
        $('#infoModal').modal('show');
    }
    else if(dateOrder == ""){
        $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
        $('#infoModalTitle').text('Error!');
        $('#infoModalBodyText').html("Please select order date");
        $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
        $('#infoModal').modal('show');
    }
    else{
    $.ajax({
    type: 'post',
    url: '../include/cartInsert.jsp',
    data: {
        cp : creditpt,
        qtt : quantity,
        dorder : dateOrder,
        cid : cartid,
        mid : mealid,
        mss : mealsession
    },
    success: function(data){
        //alert("Insert Success");
        $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Success');
        $('#infoModalBodyText').html("You've just added an item to your cart.");
        $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
        $('#infoModal').modal('show');
    }
    });
    }
  });
});
  </script>
  
  

<!-- //script for responsive tabs -->		

</body>

</html>
