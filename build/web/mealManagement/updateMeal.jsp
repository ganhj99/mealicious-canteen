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
  
  <!-- Custom styles for this page -->
  <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

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
        <jsp:useBean id="recipeDA" class="da.RecipeDA" scope="application"></jsp:useBean>
        <% Meal meal = mealDA.getRecord(Integer.parseInt(request.getParameter("mealID"))); %>

        <!-- Begin Page Content -->
        <div class="container-fluid">

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Update Meal</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Meal Information</h6>
            </div>
            <!-- Meal Information-->
            <div class="card-body">
                <form class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4 pb-3">
                        <img class="card-img-top img-fluid" src="<%= meal.getImg() %>"/>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input class="form-control" type="text" disabled id="name" value="<%= meal.getName() %>" required="">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <input class="form-control" type="text" id="category" disabled value="<%= meal.getCategory().getName() %>" required="">
                            
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" disabled id="description"><%= meal.getDesc() %></textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="price">Credit Points</label>
                            <div class="input-group">
                                <input type="number" id="price" class="form-control" required="" value="<%= meal.getCp() %>">
                            <div class="input-group-append">
                                <span class="input-group-text">CP</span>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        
                    </div>
                    <div class="col-md-12 pt-2">
                        <label>Main Ingredient</label>
                        <table class="table table-sm table-hover">
                          
                            <tbody class="ingreTbody">
                                <% ArrayList<Recipe> recipe = new ArrayList<Recipe>(); %>
                                <% recipe = recipeDA.getAllMeal(meal.getId()); %>
                                <% for(int i=0;i<recipe.size();i++) { %>
                                <tr>
                                    <td><%= recipe.get(i).getSize() %></td>
                                    <td><%= recipe.get(i).getUnit() %></td>
                                    <td><%= recipe.get(i).getIngredient().getName() %></td>
                                </tr>
                                <% } %>
                          </tbody>
                        </table>
                    </div>
                    <div class="col-md-6 pt-3">
                        <div class="form-group">
                            <div class="custom-control custom-switch"> 
                                <input type="checkbox" class="custom-control-input" id="status">
                                <label class="custom-control-label" for="status">Make this meal Available</label>
                            </div>
                            <input type="hidden" class="stt" value="<%= meal.getStatus() %>">
                        </div>
                    </div>
                    <div class="col-md-12"><div></div></div>
                    <div class="col-12">
                        <hr class="mt-2 mb-3">
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                            <div></div>
                            <button id="addMeal" class="btn btn-style-1 btn-primary" type="button" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Successfuly update Meal.">Update Meal</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            </div>
            <!--div class="col-lg-5 mb-4">
                <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Meal Image</h6>
                </div>
                <div class="card-body">
                    <form class="row" action="../servlet/UploadImageInUpdate" method="post" enctype="multipart/form-data">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="image">Image</label>
                                <div class="custom-file">
                                    <input type="hidden" class="mealID" name="mealID" value="">
                                    <input type="file" class="custom-file-input" name="image" id="image" required="">
                                  <label class="custom-file-label" for="image">Choose file</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3"></div>
                        <div class="col-md-3">
                            <label> .</label>
                            <div class="d-flex flex-wrap justify-content-between align-items-center">
                                <div></div>
                                <input class="form-control upImg" style="background-color: rgb(78, 115, 223); color: white;" type="submit" value="Upload Image">
                            </div>
                        </div>  
                    </form>
                </div>
                </div>
            </div-->
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
  
      <!-- Logout Modal -->
      <%@include file="../include/infoModal.jsp" %>
  <!-- End of Logout Modal -->
  
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
  <script src="../js/demo/datatables-demo.js"></script>
   
  <script>
 $(document).ready(function(){
    if($('.stt').val() == 'Available'){
        $("#status").attr('checked', true);
    }

  $("#addMeal").click(function(){
    var mealid = "<%= meal.getId() %>";
    var price = $('#price').val();
    var status;
   
    if ($('#status').is(":checked"))
    {
        status = "Available";
    }
    else{
        status = "Unavailable";
    }
    
    $.ajax({
        type: 'post',
        url: '../include/updateMealInfo.jsp',
        data: {
            mid : mealid,
            pr : price,
            stt : status
        },
        success: function(data){
            //alert("Update Sucess");
            $('#infoModalLabel').addClass('fa-check-circle text-success');
            $('#infoModalTitle').text('Success!');
            $('#infoModalBodyText').html("You've successfully updated a new meal in Mealicious.");
            $('#infoModalBtn').addClass('btn-success');
            $('#infoModal').modal('show');
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("error");
        }
    });
  });
});
  </script>

</body>

</html>
