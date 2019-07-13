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
  
  <!-- Custom styles for this page -->
  <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
        <jsp:useBean id="categoryDA" class="da.CategoryDA" scope="application"></jsp:useBean> 
        <jsp:useBean id="mealDA" class="da.MealDA" scope="application"></jsp:useBean> 
        <jsp:useBean id="ingredientDA" class="da.IngredientDA" scope="application"></jsp:useBean> 
        <jsp:useBean id="pendingRecipeDA" class="da.PendingRecipeDA" scope="application"></jsp:useBean> 
        
        <!-- Begin Page Content -->
        <div class="container-fluid">

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">New Meal</h1>
          </div>

          <!-- Content Row -->
          <div class="row">
            <!-- Content Column -->
            <div class="col-lg-7 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Meal Information</h6>
            </div>
            <!-- Meal Information-->
            <div class="card-body">
                <form class="row" id="addMealForm" enctype="multipart/form-data" method="post" action="../servlet/UploadImageFile">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input class="form-control" type="text" id="name" name="name" value="" required="">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select class="form-control" id="category" name="category">
                              <option value="Rice">Rice</option>
                              <option value="Noodle">Noodle</option>
                              <option value="Dessert">Dessert</option>
                              <option value="Beverages">Beverages</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" value="" id="description" name="description"></textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="price">Credit Points</label>
                            <div class="input-group">
                                <input type="number" id="price"  name="price" required="" min="1" class="form-control">
                            <div class="input-group-append">
                                <span class="input-group-text">CP</span>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                                <label for="image">Image</label>
                                <div class="custom-file">    
                                    <input type="file" class="custom-file-input" name="image" id="image" required="">
                                  <label class="custom-file-label" for="image">Choose file</label>
                                </div>
                            </div>
                    </div>
                    <div class="col-md-12 pt-2">
                        <label>Main Ingredient</label>
                        <table class="table table-sm table-hover ingreList">
                            <tbody class="ingreTbody"></tbody>
                        </table>
                    </div>
                    <div class="col-md-6 pt-3">
                        <div class="form-group">
                            <div class="custom-control custom-switch">
                                <input type="checkbox" checked class="custom-control-input" id="status" name="status" value="Available">
                                <label class="custom-control-label" for="status">Make this meal Available</label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12"><div></div></div>
                    <div class="col-12">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <div></div>
                            <button id="addMeal" class="btn btn-style-1 btn-primary" type="submit" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Successfuly add Meal.">Add Meal</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
                
                
            </div>
          
          
              <!-- Content Column -->
            <div class="col-lg-5 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Main Ingredient</h6>
            </div>
          
            <!-- Main Ingredient -->
            <div class="card-body">
            <form class="row">
                <div class="col-md-12">
                <p>Below are the currently available main ingredients from database.</p>
                
                <%@include file="../include/ingredientTable.jsp" %> 
                
                
                <div class="col-12"><div></div></div>
                    <div class="col-12 pt-4">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <div></div>
                            <button class="btn btn-style-1 btn-primary" type="button" data-toggle="modal" data-target="#newIngredientModal">Add New Ingredient</button>
                        </div>
                    </div>
                </div>
            </form>
                
                
          
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
  
  
  
    <!-- New Ingredient Modal-->
  <div class="modal fade" id="newIngredientModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">New Ingredient</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
            <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="ingredient-name">Ingredient Name</label>
                    <input class="form-control" type="text" id="ingredient-name" value="" required="">
                </div>
            </div>
            </div>
            <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="sample-size">Sample Size</label>
                    <input class="form-control" type="email" id="sample-size" value="" required="">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="sample-unit">Sample Unit</label>
                    <input class="form-control" type="email" id="sample-unit" value="" required="">
                </div>
            </div>
            </div>
            <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="fats">Fats</label>
                    <div class="input-group">
                        <input class="form-control" type="number" id="fats" value="" required="">
                        <div class="input-group-append">
                            <span class="input-group-text" id="topupCashAmtPrepend2">grams</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="carbohydrates">Carbohydrates</label>
                    <div class="input-group">
                        <input class="form-control" type="number" id="carbohydrates" value="" required="">
                        <div class="input-group-append">
                            <span class="input-group-text" id="topupCashAmtPrepend2">grams</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="protein">Protein</label>
                    <div class="input-group">
                        <input class="form-control" type="number" id="protein" value="" required="">
                        <div class="input-group-append">
                            <span class="input-group-text" id="topupCashAmtPrepend2">grams</span>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" id="addIngre" href="#">Add</a>
        </div>
      </div>
    </div>
  </div>
  
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
  
  <!-- Page level plugins -->
  <script src="../vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="../vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  
 
  <script>
 $(document).ready(function(){
  $("#addMeal").click(function(){
    var mealName = $('#name').val();
    var category = $('#category').val();
    var description = $('#description').val();
    var img = $('#image').val();
    var price = $('#price').val();
    var status;
    if ($('#status').is(":checked"))
    {
        status = "Available";
    }
    else{
        status = "Unavailable";
    }
    
    var form = $('#addMealForm');
    var data = new FormData(form);
    $.ajax({
    type: 'post',
    enctype: 'multipart/form-data',
    url: '../servlet/UploadImageFile',
    data: data,
    processData: false, //prevent jQuery from automatically transforming the data into a query string
    contentType: false,
    cache: false,
    dataType:'json',
    success: function(data){
        //alert("Insert Success");
        $('#infoModalLabel').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've successfully added a new meal (" + $('#name').val() + ") to Mealicious.");
        $('#infoModalBtn').addClass('btn-success');
        $('#infoModal').modal('show');
        
        
        $(".ingreSize").each(function(){
                $(this).val("");
           });
    },
    error: function (jqXHR, textStatus, errorThrown) {
            //alert("Insert Fail");
            $('#infoModalLabel').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Error!');
            $('#infoModalBodyText').html("An error has occured.<br>No changes will be made. Please try again later.");
            $('#infoModalBtn').addClass('btn-danger');
            $('#infoModal').modal('show');
        }
    });
  });
});
  </script>
  
  
  <script>
 $(document).ready(function(){
  $("#addIngre").click(function(){
    var ingreName = $('#ingredient-name').val();
    var ssize = $('#sample-size').val();
    var sunit = $('#sample-unit').val();
    var fats = $('#fats').val();
    var carbs = $('#carbohydrates').val();
    var protein = $('#protein').val();
    
    $.ajax({
    type: 'post',
    url: '../include/IngredientInsert.jsp',
    data: {
        name : ingreName,
        size : ssize,
        unit : sunit,
        fat : fats,
        carb : carbs,
        prot : protein
    },
    success: function(data){
        //alert("Insert Success");
        $('#infoModalLabel').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've added a new main ingredient to Mealicious database.");
        $('#infoModalBtn').addClass('btn-success');
        $('#infoModal').modal('show');
        $('.ingredientTable').replaceWith(data);
    },
    error: function (jqXHR, textStatus, errorThrown) {
            //alert("Insert Fail");
            $('#infoModalLabel').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Error!');
            $('#infoModalBodyText').html("An error has occured.<br>No changes will be made. Please try again later.");
            $('#infoModalBtn').addClass('btn-danger');
            $('#infoModal').modal('show');
        }
    });
  });
});
  </script>
  
    <script>
      $(document).ready(function () {
          function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
          }
          
          
          var msg = getParameterByName('msg');
          if(msg == 'addMealSuccess'){
            var mealName = getParameterByName('mealName');
            var price = getParameterByName('price');
            $('#infoModalLabel').addClass('fa-check-circle text-success');
            $('#infoModalTitle').text('Success');
            $('#infoModalBodyText').html("You have successfully added a new meal with name " + mealName + " that costs " + price + " points.");
            $('#infoModalBtn').addClass('btn-success');
            $('#infoModal').modal('show');
        } else if(msg == 'invalidAddMeal'){
            $('#infoModalLabel').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Invalid Entry');
            $('#infoModalBodyText').html("Sorry, you have entered an invalid meal details. <br>No meals has been added. Please try again.");
            $('#infoModalBtn').addClass('btn-danger');
            $('#infoModal').modal('show');
        } 
    });
      
  </script>

</body>

</html>
