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
            <h1 class="h3 mb-0 text-gray-800">Food Redeemption</h1>
          </div>

          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Redeem Food With Coupon</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row"> 
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="couponCode">Coupon Code</label>
                        <input class="form-control" type="text" id="couponCode" value="" required="" autofocus="">
                    </div>
                    <div id="abc"> </div>
                </div>
                <div class="col-12">
                    <hr class="mt-2 mb-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div><span>The above field is supported by barcode scanner.</span></div>
                        <button class="btn btn-style-1 btn-primary" type="submit" id="redeemBtn">Redeem</button>
                    </div>
                </div>
                </form>
            </div>
            </div>

            <!-- Latest Transaction Record -->
                <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Today's Redeemption Transaction Record (<% DateFormat dateFormat = new SimpleDateFormat("dd MMMMM yyyy"); %><%= dateFormat.format(new Date(System.currentTimeMillis())) %>)
            </h6>
            </div>
            <div class="card-body">
              <%@include file="../include/dataTableTodayRedeem.jsp" %>
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
    $('#redeemBtn').on('click', function () {
        
        $.ajax({
            type: 'post',
            url: '../include/processMealRedeemption.jsp',
            data: {
                code: $('#couponCode').val()
            },
            success: function(data){
                $('#infoModalLabel').addClass('fa-check-circle text-success');
                $('#infoModalTitle').text('Success');
                $('#infoModalBodyText').html("Coupon " + $('#couponCode').val() + " has been successfully redeemed.<br>This window will be closed in 2 seconds...");
                $('#infoModalBtn').addClass('btn-success');
                $('#infoModal').modal('show');
                setTimeout(function() {
                    $('#infoModal').modal('hide');
                }, 2000);
                $('.table-responsive').replaceWith(data);
                $( "#couponCode" ).focus();
            }
        });
    });
    
    //Bind keypress event to textbox
    $('#couponCode').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
            event.preventDefault();
            $.ajax({
            type: 'post',
            url: '../include/processMealRedeemption.jsp',
            data: {
                code: $('#couponCode').val()
            },
            success: function(data){
                $('#infoModalLabel').addClass('fa-success-circle text-success');
                $('#infoModalTitle').text('Success');
                $('#infoModalBodyText').html($('#couponCode').val() + " has been successfully redeemed.<br>This window will be closed in 2 seconds...");
                $('#infoModalBtn').addClass('btn-success');
                $('#infoModal').modal('show');
                setTimeout(function() {
                    $('#infoModal').modal('hide');
                    $( "#couponCode" ).focus();
                }, 2000);
                $('.table-responsive').replaceWith(data);
                $( "#couponCode" ).val('');
            }
        });
        }
        //Stop the event from propogation to other handlers
        //If this line will be removed, then keypress event handler attached 
        //at document level will also be triggered
        event.stopPropagation();
    });
  </script>

</body>

</html>
