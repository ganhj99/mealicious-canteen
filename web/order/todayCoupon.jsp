<%@page import="java.util.ArrayList"%>
<%@page import="domain.*"%>
<%@page import="da.*"%>
<%@page import="java.sql.Date"%>
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
            <h1 class="h3 mb-0 text-gray-800">Today's Available Coupon</h1>
          </div>
           <div class="d-sm-flex align-items-start justify-content-between mb-4">
            <span class="d-none d-md-block">Please select the meal session that you want to redeem for today.</span>
          </div>
           
           
           <jsp:useBean id="studControl" class="control.MaintainStudentControl" scope="application"></jsp:useBean> 
           <jsp:useBean id="orderDetailDA" class="da.OrderDetailDA" scope="application"></jsp:useBean> 
           <%   Student stud = studControl.selectRecordByUserId(currentUserId);
                ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
                orderDetail.addAll(orderDetailDA.getAllOrderByDateAndStudIdAndStatus(new Date(System.currentTimeMillis()), stud.getId(), "Success"));
           %>
          
          <div id="accordion" class="animated--grow-in">
              <div class="card">
                <div class="card-header py-3" id="headingBreakfast">
                  <h5 class="mb-0">
                    <button class="btn btn-link m-0 font-weight-bold text-primary" data-toggle="collapse" data-target="#collapseBreakfast" aria-expanded="true" aria-controls="collapseBreakfast" style="text-decoration: none">
                      Breakfast Session (7:00 AM to 11:00 AM)
                    </button>
                  </h5>
                </div>
                <div id="collapseBreakfast" class="collapse" aria-labelledby="headingBreakfast" data-parent="#accordion">
                  <div class="card-body">
                      <div class="row">
                          <%  for(int i=0; i<orderDetail.size(); i++){ 
                            if("Breakfast".equalsIgnoreCase(orderDetail.get(i).getSession())){
                      %>
                      <div class='col-md-4 col-xs-12'><img src='../servlet/BarcodeServlet?code=<%=orderDetail.get(i).getCoupon() %>' class='img-fluid text-gray-800'/></div>
                      <div class='col-md-8 col-xs-12'>
                          <span class="font-weight-bold">Meal Name:</span> <%=orderDetail.get(i).getMeal().getName() %><br>
                          <span class="d-none d-md-block"><span class="font-weight-bold">Meal Description:</span> <%=orderDetail.get(i).getMeal().getDesc() %> <br></span>
                          <span class="font-weight-bold">Quantity:</span> <%=orderDetail.get(i).getQtt() %><br>
                          <span class="font-weight-bold">Status: </span> <%=orderDetail.get(i).getStatus() %><br>
                      </div>
                          <% } }%>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card">
                <div class="card-header py-3" id="headingLunch">
                  <h5 class="mb-0">
                    <button class="btn btn-link m-0 font-weight-bold text-primary" data-toggle="collapse" data-target="#collapseLunch" aria-expanded="true" aria-controls="collapseLunch" style="text-decoration: none">
                      Lunch Session (11:00 AM to 3:00 PM)
                    </button>
                  </h5>
                </div>

                <div id="collapseLunch" class="collapse" aria-labelledby="headingLunch" data-parent="#accordion">
                  <div class="card-body">
                      
                      <div class="row">
                          <%  for(int i=0; i<orderDetail.size(); i++){ 
                            if("Lunch".equalsIgnoreCase(orderDetail.get(i).getSession())){
                      %><%if(i!=0){%><hr><%}%><div class='row'>
                      <div class='col-md-4 col-xs-12'><img src='../servlet/BarcodeServlet?code=<%=orderDetail.get(i).getCoupon() %>' class='img-fluid text-gray-800'/></div>
                      <div class='col-md-8 col-xs-12'>
                          <span class="font-weight-bold">Meal Name:</span> <%=orderDetail.get(i).getMeal().getName() %><br>
                          <span class="d-none d-md-block"><span class="font-weight-bold">Meal Description:</span> <%=orderDetail.get(i).getMeal().getDesc() %> <br></span>
                          <span class="font-weight-bold">Quantity:</span> <%=orderDetail.get(i).getQtt() %><br>
                          <span class="font-weight-bold">Status: </span> <%=orderDetail.get(i).getStatus() %><br>
                      </div>
                      </div>
                          <% } }%>
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
  <script src="../js/bootstrap-formhelpers-phone.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../js/sb-admin-2.min.js"></script>	

</body>

</html>
