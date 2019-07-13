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

  <!-- Custom styles for this template-->
  <link href="../css/sb-admin-2.css" rel="stylesheet">

</head>

<body style="background-image: url('../img/food-bg.jpg');">
    
    <%@ page import="io.jsonwebtoken.Claims, domain.JWTUtils, domain.WebUser, da.WebUserDA, java.util.Date" %>
    <%  Claims claims = null;
        try{
            String jwt = request.getParameter("jwt");
            claims = JWTUtils.decodeJWT(jwt); 
        } catch (Exception ex){
            out.println("Error!");
            //issuedAt = claims.getIssuedAt();
            //subject = claims.getSubject();
            //username = claims.get("username", String.class);
            //email = claims.get("email", String.class);
            //encryptedPass = claims.get("encryptedPass", String.class);
            //expDate = claims.getExpiration();
            
            //!!!! NEED TO USER PASSENCRYPTED TO CHECK WITH DATABASE TABLE, if(same) then can reset, else redirect to login/show error
        }
    %>
    
    
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
                  <h4 class="m-0">Reset Password</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
                <div class="text-center mb-4">
                    <span>Enter your new password and remember it.</span>
                </div>
            <form class="row" method='post' action='../servlet/AuthResetPassword'>
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="form-label-group">
                        <input type="hidden" name='userId' value='<%= claims.getId() %>'>
                        <label for="usernme">Username</label>
                        <input class="form-control" type="text" id="username" name='username' value='<%= claims.get("username", String.class) %>' disabled="">
                    </div>
                    </div>
                </div>
                
            <div class="col-md-6">
                    <div class="form-group">
                        <div class="form-label-group">
                        <label for="password">New Password</label>
                        <input class="form-control" type="password" id="password" name='password' required >
                        <div id="passwordValidStatus"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="form-label-group">
                        <label for="cfmPassword">Confirm Password</label>
                        <input class="form-control" type="password" id="cfmPassword" name='cfmPassword' required>
                        </div>
                    </div>
                </div>
                

                <div class="col-12">
                    <div class="d-flex flex-wrap justify-content-between align-items-center mt-4">
                        
                        <button class="btn btn-style-1 btn-primary col-md-12" type="submit" disabled='true' id='resetPasswordBtn'>Reset Password</button>
                    </div>
                </div>
                </form>
                
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
  <script>
      $(document).ready(function () {
      $('#password, #cfmPassword').on('keyup', function () {
            if ($('#password').val().length < 6 || $('#password').val().length > 14) {
                $('#password').removeClass('is-valid').addClass('is-invalid');
                $('#cfmPassword').removeClass('is-valid').addClass('is-invalid');
                $('#passwordValidStatus').replaceWith('<div id="passwordValidStatus" class="invalid-feedback">'+ 'Password must be 6 - 14 characters long.' + '</div>');
                $('#resetPasswordBtn').attr('disabled', true);
            } else if ($('#password').val() == $('#cfmPassword').val()){
                $('#password').removeClass('is-invalid').addClass('is-valid');
                $('#cfmPassword').removeClass('is-invalid').addClass('is-valid');
                $('#resetPasswordBtn').removeAttr('disabled');
            } else {
                $('#password').removeClass('is-valid').addClass('is-invalid');
                $('#cfmPassword').removeClass('is-valid').addClass('is-invalid');
                $('#passwordValidStatus').replaceWith('<div id="passwordValidStatus" class="invalid-feedback">'+ 'Password Not Matched.' + '</div>');
                $('#resetPasswordBtn').attr('disabled', true);
            }
        });
    });
        
      </script>
</body>

</html>
