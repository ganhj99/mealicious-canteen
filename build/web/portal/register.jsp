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
  <link href="../css/sb-admin-2.css" rel="stylesheet">

</head>

<body style="background-image: url('../img/food-bg.jpg');">

    
    <!--Container-->
    <div class="container">

           <!-- Page Heading -->
          <div class="align-items-center mb-3 mt-5 text-center text-white">
            
            
        <div class="rotate-n-15">
          <h1 class="fas fa-laugh-wink"></h1>
        </div>
            <h1 class="mx-3">Mealicious</h1>
      
          </div>

          <!-- Content Row -->
          <div class="row">
        <div class="col-lg-2 mb-4">
        </div>
            <!-- Content Column -->
            <div class="col-lg-8 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h4 class="m-0">Student Registration</h4>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row" method="post" action="../servlet/ValidateRegister">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="studentId">Student ID</label>
                        <input type="text" id="studentId" name="studentId" class="form-control"  required="required" autofocus="autofocus">
                        <div id="studentIdValidStatus"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" class="form-control" required="required">
                        <div id="usernameValidStatus"></div>
                </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="realName">Real Name</label>
                        <input type="text" id="realName" name="realName" class="form-control"  required="required">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" class="form-control"  required="required">
                        <div id="passwordValidStatus"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="cfmPassword">Confirm Password</label>
                        <input type="password" id="cfmPassword" name="cfmPassword" class="form-control"  required="required">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" id="phone" name="phone" class="form-control bfh-phone"  required="required" data-format="+60dddddddddd">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="email">Email address</label>
                        <input type="email" id="email" name="email" class="form-control"  required="required">
                        <div id="emailValidStatus"></div>
                    </div>
                </div>

                <div class="col-12">
                    <div class="d-flex flex-wrap justify-content-between align-items-center mt-4">
                        <input class="btn btn-style-1 btn-primary col-md-12" type="submit" value="Register">
                    </div>
                </div>
                </form>
                <div class="text-center">
          <a class="d-block small mt-3" href="../portal/login.jsp">Login Page</a>
          <a class="d-block small" href="../portal/forgotPassword.jsp">Forgot Password?</a>
        </div>
            </div>
            </div>
            </div>

            </div>
            </div>

  <!-- Bootstrap core JavaScript-->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="../js/bootstrap-formhelpers-phone.js"></script>
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
        
        $('#studentId').keyup(function(){
            $.ajax({
		type: 'post',
		url: '../include/isStudentIdAvailable.jsp',
		data: {
                    studentId: $('#studentId').val()
		},
		success: function(data){ // false = username n/a or has been taken // true = username available
                    if(data == 'true'){
                        $('#studentId').removeClass('is-invalid').addClass('is-valid');
                    } else {
                        $('#studentId').removeClass('is-valid').addClass('is-invalid');
                        $('#studentIdValidStatus').replaceWith('<div id="studentIdValidStatus" class="invalid-feedback">'+ data + '</div>');
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
