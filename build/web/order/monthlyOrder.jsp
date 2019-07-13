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
        
     <%-- Get current session user information --%>
    

        <!-- Begin Page Content -->
        <jsp:useBean id="studentDA" class="da.StudentDA" scope="application"></jsp:useBean>
        <jsp:useBean id="orderDA" class="da.OrderDA" scope="application"></jsp:useBean>
        <jsp:useBean id="studControl" class="control.MaintainStudentControl" scope="application"></jsp:useBean>
        <%  Student stud = studControl.selectRecordByUserId(currentUserId);
            String studID = stud.getId(); %>
        <div class="container-fluid">

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Make Weekly, Monthly Order</h1>
          </div>

          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            

            <!-- Latest Transaction Record -->
                <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header pt-3">
              
             <form class="row">
              <div class="col-md-6">    
                  <h6 class="m-0 p-2 font-weight-bold text-primary">Date Preparation</h6>
                <div class="form-group m-0">
                    <input class="form-control" type="week" id="datePrepare" required="">
                </div>
              </div>
              <div class="col-md-6">  
                  <h6 class="m-0 p-2 font-weight-bold text-primary">Apply To</h6>
                <div class="form-group m-0">
                    <input class="form-control" type="week" id="weekOrder" required="">
                </div>
              </div>
                 <div class="col-md-7"></div>
              <div class="col-md-2 pb-1 pt-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div></div>
                        <button id="addWeekOrder" class="btn btn-style-1 btn-primary" type="button" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Your order add successfuly.">This week</button>
                    </div>
                </div>
               <div class="col-md-3 pb-1 pt-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div></div>
                        <button id="addMonthOrder" class="btn btn-style-1 btn-primary" type="button" data-toast="" data-toast-position="topRight" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Your order add successfuly.">Following 3 weeks</button>
                    </div>
                </div>
              </form>
            </div>
            <div class="card-body">
              <div class="table-responsive orderDateTable">
                  <% int ttl = 0; %>
                <table class="table table-bordered" id="dataTable-orderH-cancel" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Order ID</th>
                      <th>Order Date & Time</th>
                      <th>Total Amount(CP)</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Order ID</th>
                      <th>Order Date & Time</th>
                      <th>Total Amount(CP)</th>
                    </tr>
                  </tfoot>
                  <tbody class="cancelTable">
                    
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
    $('#orderSession').change(function () {
        var ly = $(this).val();

        if( ly == "Weekly"){
            $("#weekOrder").removeAttr('disabled');
            $("#monthOrder").attr("disabled", 'disabled');
        }
        else if(ly == "Monthly"){
            $("#weekOrder").attr("disabled", 'disabled');
            $("#monthOrder").removeAttr('disabled');
        }
    });

});
  </script>

  
<script type="text/javascript">     
function getFirstDateOfWeek(w, y) {
    var d = (1 + (w - 1) * 7); // 1st of January + 7 days for each week
    d = d-1;
    return new Date(y, 0, d);
}

function getLastDateOfWeek(w, y) {
    var d = (1 + (w - 1) * 7); // 1st of January + 7 days for each week
    d = d+5;
    return new Date(y, 0, d);
}
</script>

<script>
$(document).ready(function(){
    $('#datePrepare').change(function () {
        var wk =  $(this).val();
        var wek = wk.substring(6);
        var yr = wk.substring(0, 4);
        var dt = getFirstDateOfWeek(wek, yr);
        var ldt = getLastDateOfWeek(wek, yr);
        var studID = "<%= studID %>";
        
        $.ajax({
        type: 'post',
        url: '../include/test.jsp',
        data: {
            dt : dt,
            ldt : ldt,
            sid : studID
        },
        success: function(data){
            $('.orderDateTable').replaceWith(data);;
        }
        });
    });
});
  </script>
  
  <script>
$(document).ready(function(){
    $('#addWeekOrder').click(function () {
        var studID = "<%= studID %>";
        
        var wks =  $("#datePrepare").val();
        var weks = wks.substring(6);
        var yrs = wks.substring(0, 4);
        var dt = getFirstDateOfWeek(weks, yrs);
        var ldt = getLastDateOfWeek(weks, yrs);
        
        var wka =  $("#weekOrder").val();
        var weka = wka.substring(6);
        var yra = wka.substring(0, 4);
        
        var yr = yra - yrs;
        var wk = weka - weks;
        yr = yr * 52;
        var dy = (wk + yr) * 7 ;
        
        if(dy < 1){
            $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Error!');
            $('#infoModalBodyText').html("Cannot choose week that previous than selected week or same week");
            $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
            $('#infoModal').modal('show');
        }
        else{
        $.ajax({
        type: 'post',
        url: '../include/makeWeeklyOrder.jsp',
        data: {
            dt : dt,
            ldt : ldt,
            sid : studID,
            dy : dy
        },
        success: function(data){
            if(data=="Nice"){
                $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
                $('#infoModalTitle').text('Great!');
                $('#infoModalBodyText').html("You've successfully add a weekly order");
                $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
                $('#infoModal').modal('show');
            }
            else{
                $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("Credit point no enough, Total is " + data);
                $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
                $('#infoModal').modal('show');
            }
        }
        });
    }
    });
});
  </script>
  
  <script>
$(document).ready(function(){
    $('#addMonthOrder').click(function () {
        var studID = "<%= studID %>";
        
        var wks =  $("#datePrepare").val();
        var weks = wks.substring(6);
        var yrs = wks.substring(0, 4);
        var dt = getFirstDateOfWeek(weks, yrs);
        var ldt = getLastDateOfWeek(weks, yrs);
        
        var wka =  $("#weekOrder").val();
        var weka = wka.substring(6);
        var yra = wka.substring(0, 4);
        
        var yr = yra - yrs;
        var wk = weka - weks;
        yr = yr * 52;
        var dy = (wk + yr) * 7 ;

        if(dy < 1){
            $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Error!');
            $('#infoModalBodyText').html("Cannot choose week that previous than selected week or same week");
            $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
            $('#infoModal').modal('show');
        }
        else{
        $.ajax({
        type: 'post',
        url: '../include/makeMonthlyOrder.jsp',
        data: {
            dt : dt,
            ldt : ldt,
            sid : studID,
            dy : dy
        },
        success: function(data){
            if(data=="Nice"){
                $('#infoModalLabel').removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
                $('#infoModalTitle').text('Great!');
                $('#infoModalBodyText').html("You've successfully add a monthly order");
                $('#infoModalBtn').removeClass('btn-danger').addClass('btn-success');
                $('#infoModal').modal('show');
            }
            else{
                $('#infoModalLabel').removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("Credit point no enough, Total is " + data);
                $('#infoModalBtn').removeClass('btn-success').addClass('btn-danger');
                $('#infoModal').modal('show');
            }
        }
        });
    }
    });
});
  </script>

</body>

</html>
