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
    <%@include file="../include/restrictLoginUserAccess.jsp" %>
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
        <div class="col-lg-3 mb-4">
        </div>
            <!-- Content Column -->
            <div class="col-lg-6 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h4 class="m-0">Login</h4>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row" method='post' action='../servlet/ProcessLogin'>
                
                
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="username">Username</label>
              <input type="text" id="username" name="username" class="form-control"  required="required" autofocus="autofocus">
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="password">Password</label>
              <input type="password" id="password" name="password" class="form-control"  required="required">
                </div>
                </div>
                <div class="col-12 my-2 mb-3 d-flex justify-content-around align-items-center">
                <div class="custom-control-inline"><span class="font-weight-normal">Login as a </span></div>
                <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" id="asAStudent" name="userRole" value="Student" class="custom-control-input" required>
                    <label class="custom-control-label px-1" for="asAStudent">Student</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" id="asAStaff" name="userRole" value="Staff" class="custom-control-input" required>
                    <label class="custom-control-label px-1" for="asAStaff">Staff</label>
                </div>
                </div>
                

                <div class="col-12">
                    <div class="d-flex flex-wrap justify-content-between align-items-center ">
                        
                        <button class="btn btn-style-1 btn-primary col-md-12" type="submit">Login Now</button>
                    </div>
                </div>
                </form>
                <div class="text-center">
                    
                    <a class="d-block small mt-3" href="../portal/register.jsp">Register an Account</a>
                    <a class="d-block small" href="../portal/forgotPassword.jsp">Forgot Password?</a>
        </div>
            </div>
            </div>
            </div>

            </div>
            </div>
<%@include file="../include/infoModal.jsp" %>
  <!-- Bootstrap core JavaScript-->
  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
  <script>
      $(document).ready(function () {
          function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
          }
          
          var msg = getParameterByName('msg');
          if(msg == 'invalidLogin'){
            $('#infoModalLabel').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Invalid Login');
            $('#infoModalBodyText').html("Sorry, you have entered an invalid login username or password.<br>Please try again.");
            $('#infoModalBtn').addClass('btn-danger');
            $('#infoModal').modal('show');
        } else if(msg == 'resetPassSuccess'){
            $('#infoModalLabel').addClass('fa-check-circle text-success');
            $('#infoModalTitle').text('Success');
            $('#infoModalBodyText').html("Congratulations, you have just reset your password.<br>You can now login to your account.");
            $('#infoModalBtn').addClass('btn-success');
            $('#infoModal').modal('show');
        } else if(msg == 'logout'){
            $('#infoModalLabel').addClass('fa-info-circle text-info');
            $('#infoModalTitle').text('Logout Success');
            $('#infoModalBodyText').html("You have just logged out from Mealicious.");
            $('#infoModalBtn').addClass('btn-info');
            $('#infoModal').modal('show');
        } else if(msg == 'registerSuccess'){
            $('#infoModalLabel').addClass('fa-check-circle text-success');
            $('#infoModalTitle').text('Register Success');
            $('#infoModalBodyText').html("You can now log in to Mealicious.");
            $('#infoModalBtn').addClass('btn-success');
            $('#infoModal').modal('show');
        }
    });
      
  </script>
</body>

</html>
