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
            <h1 class="h3 mb-0 text-gray-800">Profile</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-6 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">Personal Information</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row" method="post" action="">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="studentId">Student ID</label>
                        <input class="form-control" type="text" id="studentId" name="studentId" value="<%= student.getId() %>" disabled="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input class="form-control" type="text" id="username" name="username" value="<%= webUser.getUsername() %>" disabled="">
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="realName">Real Name</label>
                        <input class="form-control" type="text" id="realName" name="realName" value="<%= webUser.getRealName() %>" disabled="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" class="form-control bfh-phone" required="required" value="<%= webUser.getPhone() %>" data-format="+60dddddddddd">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="currentEmail">Current E-mail Address</label>
                        <div class="input-group">
                        <input class="form-control" type="email" id="currentEmail" name="currentEmail" value="<%= webUser.getEmail() %>" disabled="">
                        <div class="input-group-append" id="emailVerifyStatusToolTip" data-toggle="tooltip" data-placement="top" data-original-title="<% if(webUser.getEmailVerify()){ %>Email Verified<% }else{%>Click To Verify Email<%}%>">
                            <span class="input-group-text"><a id="verifyEmailExcBtn" href="#"><i id="emailVerifyStatus" class="fas <% if(webUser.getEmailVerify()){ %>fa-check text-success<% }else{%>fa-exclamation text-danger <%}%>"></i></a></span>
                        </div>
                        </div>
                    </div>
                </div>
                <div class="col-12"><div></div></div>
                <div class="col-12">
                    <hr class="mt-2 mb-3">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div><span>Last updated: 
                                <% DateFormat dateFormatTopbar = new SimpleDateFormat("dd MMM yyyy h:mm a"); %>
                                <%  if (webUser.getLastUpdate() != null){ %>
                                <%= dateFormatTopbar.format(webUser.getLastUpdate()) %>
                                <%  } else { %>
                                <%= "Not Available" %>
                                <% } %>
                            </span></div>
                        <input class="btn btn-style-1 btn-primary" id="updateProfileBtn" type="button" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Your profile has been updated successfuly." value="Update Profile"/>
                    </div>
                </div>
                </form>
            </div>
            </div>
            </div>
          
          
              <!-- Content Column -->
            <div class="col-lg-6 mb-4">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                          <h6 class="m-0 font-weight-bold text-primary">Password</h6>
                    </div>

                    <!-- Change Password-->
                    <div class="card-body">
                        <form class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password">New Password</label>
                                    <input class="form-control" type="password" id="password" name="password" required>
                                    <div id="passwordValidStatus"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="cfmPassword">Confirm Password</label>
                                    <input class="form-control" type="password" id="cfmPassword" name="cfmPassword" required>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex flex-wrap justify-content-between align-items-center">
                                    <div></div>
                                    <button disabled="true" class="btn btn-style-1 btn-primary" id="changePasswordBtn" type="button" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Success!" data-toast-message="Your password has been updated successfuly.">Change Password</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                          <h6 class="m-0 font-weight-bold text-primary">Email Address</h6>
                    </div>

                    <!-- Change Email-->
                    <div class="card-body">
                        <form class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="newEmail">New Email</label>
                                    <input class="form-control" type="email" id="newEmail" name="newEmail">
                                    <div id="newEmailValidStatus"></div>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="d-flex flex-wrap justify-content-between align-items-center">
                                    <div></div>
                                    <button disabled="true" class="btn btn-style-1 btn-primary" id="verifyEmailBtn" type="button" data-toast-type="success" data-toast-icon="fe-icon-check-circle" data-toast-title="Great!" data-toast-message="We've sent you a verification email. Please check your mail inbox.">Verify Email</button>
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
        
        $('#updateProfileBtn').click(function(){
            if($('#phone').val() == "+60" || $("#phone").val().replace(/ /g,'').length <=11){
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("You have entered an invalid phone number, no changes will be made.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
            }else{
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
        }
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
        
        $('#newEmail').keyup(function(){
            $.ajax({
		type: 'post',
		url: '../include/isEmailAvailable.jsp',
		data: {
                    email: $('#newEmail').val()
		},
		success: function(data){ // false = email n/a or has been taken // true = email available
                    if(data == 'true'){
                        $('#newEmail').removeClass('is-invalid').addClass('is-valid');
                        $('#verifyEmailBtn').removeAttr('disabled');
                    } else {
                        $('#newEmail').removeClass('is-valid').addClass('is-invalid');
                        $('#verifyEmailBtn').attr('disabled', true);
                        $('#newEmailValidStatus').replaceWith('<div id="newEmailValidStatus" class="invalid-feedback">'+ data + '</div>');
                    }
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
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("You have entered a same email address with our database, no changes will be made.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
            } else if ($('#newEmail').val() == "" || !validateEmail($('#newEmail').val()) || $('#newEmail').hasClass('is-invalid')){
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("You have entered an invalid email address or the email address your entered has been taken.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
                //alert('No new email detected.');
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
