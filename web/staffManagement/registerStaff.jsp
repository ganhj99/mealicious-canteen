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
            <h1 class="h3 mb-0 text-gray-800">Register A Staff Account</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Staff Information</h6>
            </div>
            <!-- Staff Information-->
            <div class="card-body">
            <form class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input class="form-control" type="text" id="username" name="username" value="" required="">
                        <div id="usernameValidStatus"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="realName">Real Name</label>
                        <input class="form-control" type="text" id="realName" name="realName" value="" required="">
                        <div id="realNameValidStatus"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="position">Position</label>
                        <select class="form-control" id="position" name="position">
                          <option disabled="" selected="true">--Select--</option>
                          <option value="Admin">Admin</option>
                          <option value="Manager">Manager</option>
                          <option value="Cashier">Cashier</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="hireDate">Hire Date</label>
                        <input class="form-control" type="date" id="hireDate" name="hireDate" value="" required="">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input class="form-control bfh-phone" type="text" id="phone" name="phone" value="" required="" data-format="+60dddddddddd">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="email">Current E-mail Address</label>
                        <input class="form-control" type="email" id="email" name="email" value="" required="">
                        <div id="emailValidStatus"></div>
                    </div>
                </div>
                <div class="col-12"><div></div></div>
                <div class="col-12">
                    <hr class="mt-2 mb-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div>A default password will be generated based on the staff's phone number with country code. Eg: +60123456789</div>
                        <button class="btn btn-style-1 btn-primary" id="createStaffBtn" type="button" data-toast-title="Success!" data-toast-message=" has been created successfully.">Create Staff Account</button>
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
        
        $('#position').change(function () {
            if($('#position').val() == "Admin"){ // Alert user if admin is selected
                //alert("You're adding a new admin position, please bear in mind that they'll have the same permissions as you do to make changes to Mealicious.");
                $('#infoModalLabel').addClass('fa-info-circle text-info');
                $('#infoModalTitle').text('');
                $('#infoModalBodyText').html("You're adding a new admin position.<br>Please bear in mind that they'll have the same permissions as you do to make changes to Mealicious.");
                $('#infoModalBtn').addClass('btn-info');
                $('#infoModal').modal('show');
            }
        });
        
        $('#createStaffBtn').click(function(){
            var username = $('#username').val();
            var realName = $('#realName').val();
            var position = $('#position').val();
            var hireDate = $('#hireDate').val();
            var phone = $('#phone').val();
            var email = $('#email').val();
            if(username==null || realName==null || position==null || hireDate=="" || phone=="+60" || email==""){
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("Looks like one of the required field is missing.<br>Please try again.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
            } else{
                $.ajax({
                    type: 'post',
                    url: '../include/createStaffAcc.jsp',
                    data: {
                        username: $('#username').val(),
                        realName: $('#realName').val(),
                        position: $('#position').val(),
                        hireDate: $('#hireDate').val(),
                        phone: $('#phone').val(),
                        email: $('#email').val()
                    },
                    success: function(data){
                        $('#successModalTitle').text($('#createStaffBtn').attr('data-toast-title'));
                        $('#successModalBodyText').text("Staff Account " + $('#username').val() + $('#createStaffBtn').attr('data-toast-message'));
                        $('#successModal').modal('show');
                    }
                });
            }
        });
        
        $('#username').keyup(function(){
            $.ajax({
		type: 'post',
		url: '../include/isUsernameAvailable.jsp',
		data: {
                    username: $('#username').val()
		},
		success: function(data){ // false = username n/a or has been taken // true = username available
                    if(data == 'true'){
                        $('#username').removeClass('is-invalid').addClass('is-valid');
                    } else {
                        $('#username').removeClass('is-valid').addClass('is-invalid');
                        $('#usernameValidStatus').replaceWith('<div id="usernameValidStatus" class="invalid-feedback">'+ data + '</div>');
                    }
		}
            });
        });
        
        $('#email').keyup(function(){
            $.ajax({
		type: 'post',
		url: '../include/isEmailAvailable.jsp',
		data: {
                    email: $('#email').val()
		},
		success: function(data){ // false = email n/a or has been taken // true = email available
                    if(data == 'true'){
                        $('#email').removeClass('is-invalid').addClass('is-valid');
                    } else {
                        $('#email').removeClass('is-valid').addClass('is-invalid');
                        $('#emailValidStatus').replaceWith('<div id="emailValidStatus" class="invalid-feedback">'+ data + '</div>');
                    }
		}
            });
        });
        
        $('#password, #cfmPassword').on('keyup', function () {
            if ($('#password').val().length < 6 || $('#password').val().length > 14) {
                $('#password').removeClass('is-valid').addClass('is-invalid');
                $('#cfmPassword').removeClass('is-valid').addClass('is-invalid');
                $('#passwordValidStatus').replaceWith('<div id="passwordValidStatus" class="invalid-feedback">'+ 'Password must be 6 - 14 characters long.' + '</div>');
                $('#changePasswordBtn').attr('disabled', true);
            } else if ($('#password').val() == $('#cfmPassword').val()){
                $('#password').removeClass('is-invalid').addClass('is-valid');
                $('#cfmPassword').removeClass('is-invalid').addClass('is-valid');
                $('#changePasswordBtn').removeAttr('disabled');
            } else {
                $('#password').removeClass('is-valid').addClass('is-invalid');
                $('#cfmPassword').removeClass('is-valid').addClass('is-invalid');
                $('#passwordValidStatus').replaceWith('<div id="passwordValidStatus" class="invalid-feedback">'+ 'Password Not Matched.' + '</div>');
                $('#changePasswordBtn').attr('disabled', true);
            }
        });
        
    });
    
    

  </script>
</body>

</html>
