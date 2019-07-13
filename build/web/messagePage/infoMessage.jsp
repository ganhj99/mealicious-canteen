<%-- 
    Document   : success
    Created on : Apr 7, 2019, 2:39:23 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
    <body class="modal-open" style="background-image: url('../img/food-bg.jpg');">
        <%  String msgType = request.getParameter("msgType"); //success,error,info
            String msgTitle = request.getParameter("msgTitle");
            String msgBody1 = request.getParameter("msgBody1"); //Each msgBody must end with a " "(space) character
            String msgBody2 = request.getParameter("msgBody2");
            String msgBody3 = request.getParameter("msgBody3");
            String msgBody4 = request.getParameter("msgBody4");
            String msgBody5 = request.getParameter("msgBody5");
            String modalLabel, btnStyle;
            
            if("Success".equalsIgnoreCase(msgType)){
                modalLabel = "fa-check-circle text-success";
                btnStyle = "btn-success";
            } else if("Error".equalsIgnoreCase(msgType)){
                modalLabel = "fa-times-circle text-danger";
                btnStyle = "btn-danger";
            } else if("Error".equalsIgnoreCase(msgType)){
                modalLabel = "fa-info-circle text-info";
                btnStyle = "btn-info";
            } else {
                modalLabel = "fa-laugh-wink rotate-n-15 text-primary";
                btnStyle = "btn-primary";
            }
            
            StringBuilder msgBody = new StringBuilder();
            if (msgBody1 != null){
                msgBody.append(msgBody1);}
            if (msgBody2 != null){
                msgBody.append(msgBody2);}
            if (msgBody3 != null){
                msgBody.append(msgBody3);} 
            if (msgBody4 != null){
                msgBody.append(msgBody4);} 
            if (msgBody5 != null){
                msgBody.append(msgBody5);} 
        %>
        <div id="wrapper" class="d-flex flex-column"></div>
        <!-- Info Modal -->
        <%@include file="../include/spinnerModal.jsp" %>
        <!-- End of Info Modal -->
        <!-- Info Modal -->
        <%@include file="../include/infoModal.jsp" %>
        <!-- End of Info Modal -->
        
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
                $('#spinnerModal').modal('show');
                setTimeout(function() {
                    $('#spinnerModal').modal('hide');
                    $('#infoModalDialog').addClass('modal-dialog-centered');
                    $('#infoModalLabel').addClass('<%= modalLabel %>');
                    $('#infoModalTitle').text('<%= msgTitle %>');
                    $('#infoModalBodyText').html('<%= msgBody %>');
                    $('#infoModalBtn').addClass('<%= btnStyle %>');
                    $('#infoModal').modal('show');
                }, 1200);
                
            });
        </script>
    </body>
</html>
