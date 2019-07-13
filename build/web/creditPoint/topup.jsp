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

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Top Up Credit Points</h1>
          </div>

          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Reload Student Credit Points</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="studentId">Student ID</label>
                        <input class="form-control" type="text" id="studentId" value="" required="">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="topupCashAmt">Topup Amount</label>
                        <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="topupCashAmtPrepend">RM</span>
                        </div>
                            <select class="form-control" id="topupCashAmt">
                          <option value="10">10.00</option>
                          <option value="20">20.00</option>
                          <option value="50">50.00</option>
                          <option value="100">100.00</option>
                        </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="topupCPAmt">Credit Points</label>
                        <div class="input-group">
                        <input type="number" id="topupCPAmt" class="form-control" disabled="disabled">
                        <div class="input-group-append">
                            <span class="input-group-text" id="topupCashAmtPrepend2">CP</span>
                        </div>
                        </div>
                        <div class="tooltip">dfefef</div>
                    </div>
                </div>
                <div class="col-12">
                    <hr class="mt-2 mb-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div><span>RM 1.00 is equivalent to 10 Credit Points</span></div>
                        <button class="btn btn-style-1 btn-primary" id="reloadCreditPointBtn" type="button" data-toast-title="Success!" data-toast-message=" has been credited successfully.">Reload</button>
                    </div>
                </div>
                </form>
            </div>
            </div>

            <!-- Latest Transaction Record -->
                <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Today's Reload Transaction Record (<% DateFormat dateFormat = new SimpleDateFormat("dd MMMMM yyyy"); %><%= dateFormat.format(new Date(System.currentTimeMillis())) %>)</h6>
            </div>
            <div class="card-body">
              <%-- DataTableTodayTopupRecord --%>
              <%@include file="../include/dataTableTodayTopupRecord.jsp" %>
              <%-- End of DataTableTodayTopupRecord --%>
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
  
   <!-- Info Modal-->
  <%@include file="../include/infoModal.jsp" %>

  <!-- Logout Modal-->
  <%@include file="../include/logoutModal.jsp" %>

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
        $('#topupCashAmt').change(function () {
	$.ajax({
		type: 'post',
		url: '../include/exchangeRmToCp.jsp',
		data: {
                    ringgit: $('#topupCashAmt').val()
		},
		success: function(data){
                    $('#topupCPAmt').val(data);
		}
	});
}).trigger('change');

        $('#reloadCreditPointBtn').click(function(){
            $.ajax({
		type: 'post',
		url: '../include/topupToStudentAcc.jsp',
		data: {
                    studentId: $('#studentId').val(),
                    topupAmt: $('#topupCPAmt').val()
		},
		success: function(data){
                    $('.table-responsive').replaceWith(data);
                    $('#infoModalLabel').addClass('fa-check-circle text-success');
            $('#infoModalBtn').addClass('btn-success');
                    $('#infoModalTitle').text($('#reloadCreditPointBtn').attr('data-toast-title'));
                    $('#infoModalBodyText').text("Student ID " + $('#studentId').val() + " with " + $('#topupCPAmt').val() + " CP" + $('#reloadCreditPointBtn').attr('data-toast-message'));
                    $('#infoModal').modal('show');
		}
            });
        });
});
  </script>
</body>

</html>
