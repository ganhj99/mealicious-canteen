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

<body style="background-image: url('../img/food-bg.jpg'); ">
    
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
                    <h4>Forgot your password?</h4>
                    <p>Enter your username & email address and we will send you instructions on how to reset your password.</p>
                </div>
            <form class="row" action="../servlet/ResetPassword" method="post">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="form-label-group">
                        <label for="username">Enter username</label>
                        <input type="text" id="username" name="username" class="form-control" required="required" autofocus="autofocus">
                        </div>
                    </div>
                </div>
            <div class="col-md-12">
                    <div class="form-group">
                    <div class="form-label-group">
                    <label for="email">Enter email address</label>
                    <input type="email" id="email" name="email" class="form-control" required="required">
                    </div>
                    </div>
            </div>
               <%--<div class="col-12 align-content-center"> 
                   <div class="g-recaptcha" data-sitekey="6Lc2sZoUAAAAAB-wViiCXCc5f2nqLAWhyV7UXgRk"></div>
               </div>--%>
                <div class="col-12">
                    <div class="d-flex flex-wrap justify-content-between align-items-center mt-4">
                        
                        <button class="btn btn-style-1 btn-primary col-md-12" type="submit">Send Me Email</button>
                    </div>
                </div>
                </form>
                <div class="text-center">
          <a class="d-block small mt-3" href="../portal/login.jsp">Login Page</a>
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
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
          if(msg == 'invalid'){
            $('#infoModalLabel').addClass('fa-times-circle text-danger');
            $('#infoModalTitle').text('Error!');
            $('#infoModalBodyText').html("Sorry, you have entered an invalid username or password.<br>Please try again.");
            $('#infoModalBtn').addClass('btn-danger');
            $('#infoModal').modal('show');
        } 
    });
      
  </script>
</body>

</html>
