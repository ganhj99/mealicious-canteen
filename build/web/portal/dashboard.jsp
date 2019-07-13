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

</head>

<body id="page-top">
    
    <%@include file="../include/restrictNonUserAccess.jsp" %>
    
    <%-- Get current session user information --%>
    <%@include file="../include/getCurrentSessionUserDetails.jsp" %>
    
    <%-- Get student details from currentUserId --%>
    <%@ page import="control.MaintainWebUserControl, domain.Student, domain.WebUser, da.StudentDA" %>
    <%  MaintainWebUserControl webUserControl = new MaintainWebUserControl();
        StudentDA studentDA = new StudentDA();        
        WebUser webUser = null;
        Student student = null;
        
        if (webUserControl.selectRecordWithUserId(currentUserId) != null){
            webUser = webUserControl.selectRecordWithUserId(currentUserId);
            student = studentDA.getRecord(currentUserId);
        } else {
            // REDIRECT TO OTHER PAGE 
        }
    %>

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
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-12 col-md-12 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-lg font-weight-bold text-primary mb-1 text-center">Greetings!</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800 text-center mb-2">Welcome to Mealicious.</div>
                      <div class="h6 mb-0 text-gray-800 text-center">You can select any actions you would like to perform in Mealicious from the sidebar.</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa- fa-2x text-gray-300"></i>
                    </div>
                  </div>
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
  
  <!-- Success Modal-->
  <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog /*modal-dialog-centered*/" role="document">
      <div class="modal-content text-center">
        <div class="modal-body">
            <div class="col-md-12 text-success">
            <h1 class="modal-title fas fa-check-circle fa-5x text-success" id="successModalLabel"></h1>
            </div>
            <h4 id="successModalTitle" class="modal-title">Great!</h4>
            <p id="successModalBodyText" class="mb-3"></p>
            <div class="mb-3">
            <div class="col-3"></div>
            <button class="btn btn-success col-6" type="button" data-dismiss="modal">OK</button>
            <div class="col-3"></div>
            </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Info Modal -->
      <%@include file="../include/infoModal.jsp" %>
  <!-- End of Info Modal -->
  
  <!-- Spinner Modal -->
      <%@include file="../include/spinnerModal.jsp" %>
  <!-- End of Spinner Modal -->
  
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
    $(document).ready(function () {
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
        
        
        $('#updateProfileBtn').click(function(){
            $.ajax({
		type: 'post',
		url: '../include/updatePhone.jsp',
		data: {
                    phone: $('#phone').val()
		},
		success: function(data){
                    $('#successModalTitle').text($('#updateProfileBtn').attr('data-toast-title'));
                    $('#successModalBodyText').text($('#updateProfileBtn').attr('data-toast-message'));
                    $('#successModal').modal('show');
		}
            });
        });
        
        $('#changePasswordBtn').click(function(){
            $.ajax({
		type: 'post',
		url: '../include/updatePassword.jsp',
		data: {
                    password: $('#password').val(),
                    CfmPassword: $('#cfmPassword').val()
		},
		success: function(data){
                    $('#successModalTitle').text($('#changePasswordBtn').attr('data-toast-title'));
                    $('#successModalBodyText').text($('#changePasswordBtn').attr('data-toast-message'));
                    $('#successModal').modal('show');
		}
            });
        });
        
        $('#verifyEmailExcBtn').click(function(){
            $.ajax({
		type: 'post',
		url: '../include/verifyEmail.jsp',
		data: {
                    email: $('#currentEmail').val()
		},
		success: function(data){
                    $('#successModalTitle').text($('#verifyEmailBtn').attr('data-toast-title'));
                    $('#successModalBodyText').text($('#verifyEmailBtn').attr('data-toast-message'));
                    $('#successModal').modal('show');
		}
            });
        });
        
        $('#verifyEmailBtn').click(function(){
            if($('#currentEmail').val() == $('#newEmail').val()){
                alert('Same email detected.');
            } else if ($('#newEmail').val() == "" || !validateEmail($('#newEmail').val())){
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("You have entered an invalid email address.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
            } else{ 
                $('#spinnerModal').modal('show');
                $.ajax({
                    type: 'post',
                    url: '../include/verifyEmail.jsp',
                    data: {
                        email: $('#newEmail').val()
                    },
                    success: function(data){
                        $('#spinnerModal').modal('hide');
                        $('#successModalTitle').text($('#verifyEmailBtn').attr('data-toast-title'));
                        $('#successModalBodyText').text($('#verifyEmailBtn').attr('data-toast-message'));
                        $('#successModal').modal('show');
                        $('#emailVerifyStatusToolTip').attr('data-original-title', 'Click To Verify Email');
                        $('#emailVerifyStatus').removeClass('text-success fa-check').addClass('text-danger fa-exclamation');
                        $('#currentEmail').val($('#newEmail').val());
                    }
                });
            }
        });
    });
    
    function validateEmail(email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }
    

  </script>
  
</body>

</html>
