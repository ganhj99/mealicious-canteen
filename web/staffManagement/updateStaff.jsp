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
    
    <%-- Get staff Id from URL query --%>
    <%@ page import="control.MaintainStaffControl, domain.Staff, java.sql.Date" %>
    <%  Integer userId = Integer.parseInt(request.getParameter("userId"));
        MaintainStaffControl staffControl = new MaintainStaffControl();
        Staff staff = staffControl.selectRecord(userId);
        String initialPosition = staff.getPosition();
        String initialStatus = staff.getStatus();
        Date initialEndDate = staff.getDateEnd();
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
            <h1 class="h3 mb-0 text-gray-800">Update Staff Account</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-12 mb-4">
            <div class="card shadow mb-4">
            <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary"><%= staff.getWebUser().getRealName() %>'s Personal Information</h6>
            </div>
            <!-- Personal Information-->
            <div class="card-body">
            <form class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="staffId">Staff ID</label>
                        <input class="form-control" type="text" id="staffId" name="staffId" value="<%= staff.getId() %>" disabled="">
                        <input class="form-control" type="hidden" id="staffUserId" name="staffUserId" value="<%= staff.getWebUser().getId() %>">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input class="form-control" type="text" id="username" name="username" value="<%= staff.getWebUser().getUsername() %>"  disabled="">
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="form-group">
                        <label for="realName">Real Name</label>
                        <input class="form-control" type="text" id="realName" name="realName" value="<%= staff.getWebUser().getRealName() %>" disabled="">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="position">Position</label>
                        <select class="form-control" id="position" name="position">
                          <option value="Admin">Admin</option>
                          <option value="Manager">Manager</option>
                          <option value="Cashier">Cashier</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select class="form-control" id="status" name="status">
                          <option value="New">New</option>
                          <option value="Active">Active</option>
                          <option value="Quit">Quit</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input class="form-control" type="date" id="startDate" name="startDate" value="<%= staff.getDateStart() %>" disabled="">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input class="form-control" id="endDate" name="endDate" type="date" value="<%= staff.getDateEnd() %>"  disabled="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" class="form-control bfh-phone" required="required" disabled value="<%= staff.getWebUser().getPhone() %>" data-format="+60dddddddddd">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="currentEmail">Current E-mail Address</label>
                        <div class="input-group">
                        <input class="form-control" type="email" id="currentEmail" name="currentEmail" value="<%= staff.getWebUser().getEmail() %>" disabled="">
                        <div class="input-group-append" id="emailVerifyStatusToolTip" data-toggle="tooltip" data-placement="top" data-original-title="<% if(staff.getWebUser().getEmailVerify()){ %>Verified<% }else{%>Unverified<%}%>">
                            <span class="input-group-text"><i id="emailVerifyStatus" class="fas <% if(staff.getWebUser().getEmailVerify()){ %>fa-check text-success<% }else{%>fa-exclamation text-danger <%}%>"></i></span>
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
                                <%  if (staff.getWebUser().getLastUpdate() != null){ %>
                                <%= dateFormatTopbar.format(staff.getWebUser().getLastUpdate()) %>
                                <%  } else { %>
                                <%= "Not Available" %>
                                <% } %>
                            </span></div>
                        <div>
                        <a href="#" class="btn btn-style-1 btn-secondary" id="backToStaffListBtn" type="button">Back to Staff List</a>
                        <button class="btn btn-style-1 btn-primary" id="updateStaffBtn" type="button" data-toast-title="Success!" data-toast-message=" has been updated successfully.">Update This Staff</button>
                        </div>
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
  
  <!-- Success Modal -->
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
            <button class="btn btn-success col-6" type="button" id="successModalBtn" data-dismiss="modal">OK</button>
            <div class="col-3"></div>
            </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Ok Cancel Modal -->
  <%@include file="../include/okCancelModal.jsp" %>
  <!-- End of Info Modal -->
  
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
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
        
        var position = "<%= initialPosition %>";
        if("Admin" == position ){ 
            $('#position').val("Admin");
        } else if("Manager" == position ){
            $('#position').val("Manager");
        } else if("Cashier" == position ){
            $('#position').val("Cashier");
        }
        
        var staffStatus = "<%= initialStatus %>";
        if("New" == staffStatus ){ 
            $('#status').val("New");
        } else if("Active" == staffStatus ){
            $('#status option[value="New"]').attr("disabled", true);
            $('#status').val("Active");
        } else if("Quit" == staffStatus ){
            $('#status option[value="New"]').attr("disabled", true);
            $('#status').val("Quit");
        }
        
        var endDate = "<%= initialEndDate %>";
        $('#backToStaffListBtn').click(function () {
            if(endDate == "null"){
                endDate = "";
            }
            if($('#position').val() != "<%= initialPosition %>" ||
                $('#status').val() != "<%= initialStatus %>" ||
                $('#endDate').val() != endDate){
               $('#okCancelModalLabel').addClass('fa-exclamation-circle text-warning');
               $('#okCancelModalTitle').text('Are you sure you want to leave this page?');
               $('#okCancelModalBodyText').html("You have unsaved changes. <br>If you leave this page, these changes will be lost.");
               $('#okCancelModalOkBtn').addClass('btn-warning').attr('href', '../staffManagement/staffList.jsp')
               $('#okCancelModalCancelBtn').addClass('btn-secondary');
               $('#okCancelModal').modal('show');
            } else { window.location.replace("../staffManagement/staffList.jsp");}
        });
        
        $('#status').change(function () {
            if($('#status').val() == "New"){
                $('#endDate').val(null);
                $('#endDate').attr("disabled", true);
            } else if($('#status').val() == "Active"){
                $('#endDate').val(null);
                $('#endDate').attr("disabled", true);
            } else if($('#status').val() == "Quit"){
                $('#endDate').removeAttr("disabled");
            }
        });
        
        $('#position').change(function () {
            if($('#position').val() == "Admin"){ 
                $('#infoModalLabel').addClass('fa-info-circle text-info');
                $('#infoModalTitle').text('');
                $('#infoModalBodyText').html("You're updating this staff to an admin position.<br>Please bear in mind that they'll have the same permissions as you do to make changes to Mealicious.");
                $('#infoModalBtn').addClass('btn-info');
                $('#infoModal').modal('show');
            }
        });
        
        $('#updateStaffBtn').click(function(){
            if($('#status').val() == "Quit" && $('#endDate').val() == null){ 
                $('#infoModalLabel').addClass('fa-times-circle text-danger');
                $('#infoModalTitle').text('Error!');
                $('#infoModalBodyText').html("Looks like one of the required field is missing.<br>Please try again.");
                $('#infoModalBtn').addClass('btn-danger');
                $('#infoModal').modal('show');
            } else{
                $.ajax({
                    type: 'post',
                    url: '../include/updateStaffAcc.jsp',
                    data: {
                        staffUserId: $('#staffUserId').val(),
                        staffId: $('#staffId').val(),
                        position: $('#position').val(),
                        status: $('#status').val(),
                        endDate: $('#endDate').val()
                    },
                    success: function(data){
                        if(data == "00") { 
                            $('#infoModalLabel').addClass('fa-info-circle text-info');
                            $('#infoModalTitle').text('');
                            $('#infoModalBodyText').html("No changes will be made as we did not detected any changes.");
                            $('#infoModalBtn').addClass('btn-info');
                            $('#infoModal').modal('show');
                        } else{
                            $('#successModalTitle').text($('#updateStaffBtn').attr('data-toast-title'));
                            $('#successModalBodyText').text("Staff Account " + $('#username').val() + $('#updateStaffBtn').attr('data-toast-message'));
                            $('#successModal').modal('show');
                        }
                    }
                });
            }
        });
        $('#successModalBtn').click(function(){
            location.reload(true);
        });
    });
  </script>
</body>

</html>
