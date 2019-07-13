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
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>   
</head>

<body id="page-top">
 <%-- Get current session user information --%>
    <%@include file="../include/getCurrentSessionUserDetails.jsp" %>
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <%@include file="include/sidebar.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <%@include file="include/topbar.jsp" %>
        <!-- End of Topbar -->
        
        <!-- Begin Page Content -->
        <div class="container-fluid">

           <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Cart
        <small>Details</small>
      </h1>
      
        
        <% for(int i=0; i<5; i++){ %>       
        <div class="row my-2">
            <div class="col-md-3">
                <div class="card shadow px-2"> 
                    <img class="img-fluid" src="img/test.png" alt="">
                </div> 
            </div>  
            <div class="col-md-9">
            <div class="card shadow py-2 px-2">
                <div class="row">
                   <h5 class="col-md-6 text-dark font-weight-bold mb-0">Fried Rice</h5>
                   <h6 class="col-md-2 pt-1 mb-0">100 CP</h6>
                   <h6 class="col-md-3 pt-1 mb-0">Subtotal: <strong>200 CP</strong></h6>
                   <a class="col-md-1"><img class="img-fluid" src="img/cancel.png" alt=""></a>
                </div>
            </div>
            <div class="card shadow">
                <form class="row py-1 px-1">
                   <div class="col-md-4">
                        <div class="form-group">
                        <label for="Quantity">Quatity</label>
                        <input class="form-control form-control-sm" type="number" id="quantity" value="1" required="" min="1">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="OrderDate">Date</label>
                        <input class="form-control form-control-sm" type="date" id="orderDate" required="">
                        </div>
                    </div>  
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="mealSession">Session</label>
                        <select class="form-control form-control-sm" id="mealSession">
                          <option value="Breakfast">Breakfast</option>
                          <option value="Lunch">Lunch</option>
                        </select>
                        </div>
                    </div>
                </form>
            </div>
            </div>       
          </div>
          
        <% } %>
        

      <!-- /.row -->

      <hr>


    </div>
    <!-- /.container -->
          
          <!-- content end -->
          </div>

            
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <%@include file="include/footer.jsp" %>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="js/bootstrap-formhelpers-phone.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>
	

</body>

</html>
