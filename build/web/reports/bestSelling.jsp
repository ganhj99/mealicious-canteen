<%@page import="java.text.SimpleDateFormat"%>
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

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Best Selling Report</h1>
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
                    <label for='month'>Please select a month</label>
                    <input class="form-control" type="month" id="month" required="">
                </div>
              </div>
                 <div class="col-md-3">    
                <div class="form-group m-0">
                    <label for='ranking'>Please select the number of ranks</label>
                    <select class="form-control" required name="ranking" id="ranking">
                        <option disabled selected>--Please select--</option>
                        <option value="5">Top 5</option>
                        <option value="7">Top 7</option>
                        <option value="10">Top 10</option>
                    </select>
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
                <%@include file="../include/dataTableMonthlyBestSelling.jsp" %>
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

  
  <script src="../vendor/chart.js/Chart.min.js"></script>
  
<script>
      $(document).ready(function(){
        $('#month').change(function () {
	$.ajax({
		type: 'post',
		url: '../include/dataTableMonthlyBestSelling.jsp',
		data: {
                    ranking: $('#ranking').val(),
                    year: $('#month').val().substring(0,4),
                    month: $('#month').val().substring(5)
		},
		success: function(data){
                    if(data== 'false'){
                        $('#infoModalLabel').addClass('fa-times-circle text-danger');
                        $('#infoModalTitle').text('Error!');
                        $('#infoModalBodyText').html("No record has been found. <br>Please try again by selecting other month.");
                        $('#infoModalBtn').addClass('btn-danger');
                        $('#infoModal').modal('show');
                        $('#month').val('');
                        $(".table-responsive").replaceWith('<div class="table-responsive text-center"><b>No record has been found.</b> <br>Please try again by selecting other month.</div>');
                    } else {
                        $(".table-responsive").replaceWith(data);
                    }
		}
	});
});

$('#ranking').change(function () {
	$.ajax({
		type: 'post',
		url: '../include/dataTableMonthlyBestSelling.jsp',
		data: {
                    ranking: $('#ranking').val(),
                    year: $('#month').val().substring(0,4),
                    month: $('#month').val().substring(5)
		},
		success: function(data){
                    if(data== 'false'){
                        $('#infoModalLabel').addClass('fa-times-circle text-danger');
                        $('#infoModalTitle').text('Error!');
                        $('#infoModalBodyText').html("No record has been found. <br>Please try again by selecting other month.");
                        $('#infoModalBtn').addClass('btn-danger');
                        $('#infoModal').modal('show');
                        $('#month').val('');
                        $(".table-responsive").replaceWith('<div class="table-responsive text-center"><b>No record has been found.</b> <br>Please try again by selecting other month.</div>');
                    } else {
                        $(".table-responsive").replaceWith(data);
                    }
		}
	});
});

$('#printReport').click(function () {
    window.open('../print/printMonthlyBestSelling.jsp?ranking='+ $('#ranking').val() + '&year=' + $('#month').val().substring(0,4) + '&month=' + $('#month').val().substring(5));
});


});
  </script>
  
</body>

</html>

