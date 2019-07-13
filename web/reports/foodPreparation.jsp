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

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Food Preparation Report</h1>
          </div>

          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            

            <!-- Latest Transaction Record -->
                <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header pt-3">
             <form class="row">
              <div class="col-md-3">    
                <div class="form-group m-0">
                    <label for="datePrepare">Please select a preparation date</label>
                    <input class="form-control" type="date" id="datePrepare" required="">
                </div>
              </div>
               <div >
                   <div><label for='generateReport' style="color: rgb(248,249,252);" class="d-none d-sm-inline-block ">. </label></div>
                    <div>
                        <a class="btn btn-primary btn-icon-split" href="#" id="printReport">
                            <span class="icon text-white-50"><i class="fas fa-print"></i></span>
                            <span class="text">Print Report</span>
                        </a>
                    </div>
                </div>
              </form>
            </div>
            <div class="card-body">
              <div class="table-responsive dailyPreparationTable">
                <table class="table table-bordered" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th></th>
                      <th>Ingredient Name</th>
                      <th>Size</th>
                      <th>Unit</th>
                    </tr>
                    <tr>
                        <td colspan="4" class="text-center">No records found for this day. Please try again.</td>
                    </tr>
                  </thead>
                  <tbody>
                    
                  </tbody>
                </table>
              </div>
            </div>
          </div>
            

            </div>
          
          </div>
           
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

  <!-- Custom scripts for all pages-->
  <script src="../js/sb-admin-2.min.js"></script>
  
  <!-- Page level plugins -->
  <script src="../vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="../vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="../js/demo/datatables-demo.js"></script>
<script>
$(document).ready(function(){
    $('#datePrepare').change(function () {
        var dt = $(this).val();
        
        $.ajax({
        type: 'post',
        url: '../include/refreshDailyPreparation.jsp',
        data: {
            dt : dt
        },
        success: function(data){
            $('.dailyPreparationTable').replaceWith(data);;
        }
        });
    });
    
    $('#printReport').click(function () {
    window.open('../print/printFoodPreparation.jsp?dt=' + $('#datePrepare').val());
});

});
  </script>
  
</body>

</html>
