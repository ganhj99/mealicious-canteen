<%@page import="java.util.ArrayList"%>
<%@page import="domain.*"%>
<%@page import="da.*"%>
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
<jsp:useBean id="mealDA" class="da.MealDA" scope="application"></jsp:useBean>
<jsp:useBean id="cartDA" class="da.CartDA" scope="application"></jsp:useBean>
<jsp:useBean id="cartDetailDA" class="da.CartDetailDA" scope="application"></jsp:useBean>
<jsp:useBean id="studControl" class="control.MaintainStudentControl" scope="application"></jsp:useBean>
        <%  Student stud = studControl.selectRecordByUserId(currentUserId);
            String studID = stud.getId(); %>
        <%      Cart cart = cartDA.checkRecord(stud.getId());    
                if(cart == null){
                    cartDA.addRecord(stud.getId());
                    cart = cartDA.checkRecord(stud.getId());  
                }  %>    

        <!-- Begin Page Content -->
        <div class="container-fluid">

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Make Pre-Order</h1>
          </div>

          <!-- Content Row -->
          <ul class="nav nav-pills mb-3 nav-justified card-header py-3 animated--grow-in" id="pills-tab" role="tablist">
          <li class="nav-item align-items-center">
            <a class="nav-link active mb-0" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Rice</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-0" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Noodles</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-0" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Dessert</a>
          </li>
          <li class="nav-item">
            <a class="nav-link mb-0" id="pills-contact-tab" data-toggle="pill" href="#pills-beverages" role="tab" aria-controls="pills-beverages" aria-selected="false">Beverages</a>
          </li>
          </ul>
          
        <div class="tab-content mb-4 card-body animated--grow-in col-12 pt-0" id="pills-tabContent">
            <div class="tab-pane fade show active col-12" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <div class="row">
             
             <% ArrayList<Meal> meal = new ArrayList<Meal>(); %>
             <% meal = mealDA.getMeals(1); %>
             <% for (int i = 0; i < meal.size(); i++) { 
                    if("Available".equals(meal.get(i).getStatus())){ %>
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <img class="card-img-top img-fluid" src="<%= meal.get(i).getImg() %>"/>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= meal.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <span class="text-gray-800 font-weight-bold card-title"><%= meal.get(i).getName() %></span><br>
                                <span class="text-s"><%= meal.get(i).getCalorie() %> calories</span>
                                
                            </div>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-6 p-0">
                                        
                                        <a href="../meal/mealDetail.jsp?mealid=<%= meal.get(i).getId() %>&mealSes=Breakfast"><input type="submit" name="submit" value="Breakfast" class="btn btn-info col-12"/></a>
                                        
                                    </div>
                                    <div class="col-md-6 p-0">
                                        
                                        <a href="../meal/mealDetail.jsp?mealid=<%= meal.get(i).getId() %>&mealSes=Lunch"><input type="submit" name="submit" value="Lunch" class="btn btn-warning col-12" /></a>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <% }
                    } %>
                    
                </div>
            </div>
          <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
              <div class="row">
             
             <% ArrayList<Meal> noodle = new ArrayList<Meal>(); %>
             <% noodle = mealDA.getMeals(2); %>
             <% for (int i = 0; i < noodle.size(); i++) { 
                    if("Available".equals(noodle.get(i).getStatus())){ %>
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <img class="card-img-top img-fluid" src="<%= noodle.get(i).getImg() %>"/>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= noodle.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <span class="text-gray-800 font-weight-bold card-title"><%= noodle.get(i).getName() %></span><br>
                                <span class="text-s"><%= noodle.get(i).getCalorie() %> calories</span>
                                
                            </div>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= noodle.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Breakfast" />
                                        <input type="submit" name="submit" value="Breakfast" class="btn btn-info col-12"/>
                                        </form>
                                    </div>
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= noodle.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Lunch" />
                                        <input type="submit" name="submit" value="Lunch" class="btn btn-warning col-12" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <% }
                    } %>
                    
                </div>
          </div>
          <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
              <div class="row">
             
             <% ArrayList<Meal> dessert = new ArrayList<Meal>(); %>
             <% dessert = mealDA.getMeals(3); %>
             <% for (int i = 0; i < dessert.size(); i++) { 
                    if("Available".equals(dessert.get(i).getStatus())){ %>
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <img class="card-img-top img-fluid" src="<%= dessert.get(i).getImg() %>"/>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= dessert.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <span class="text-gray-800 font-weight-bold card-title"><%= dessert.get(i).getName() %></span><br>
                                <span class="text-s"><%= dessert.get(i).getCalorie() %> calories</span>
                                
                            </div>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= dessert.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Breakfast" />
                                        <input type="submit" name="submit" value="Breakfast" class="btn btn-info col-12"/>
                                        </form>
                                    </div>
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= dessert.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Lunch" />
                                        <input type="submit" name="submit" value="Lunch" class="btn btn-warning col-12" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <% }
                    } %>
                    
                </div>
          </div>
          <div class="tab-pane fade" id="pills-beverages" role="tabpanel" aria-labelledby="pills-beverages-tab">
              <div class="row">
             
             <% ArrayList<Meal> beverage = new ArrayList<Meal>(); %>
             <% beverage = mealDA.getMeals(4); %>
             <% for (int i = 0; i < beverage.size(); i++) { 
                    if("Available".equals(beverage.get(i).getStatus())){ %>
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <img class="card-img-top img-fluid" src="<%= beverage.get(i).getImg() %>"/>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= beverage.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <span class="text-gray-800 font-weight-bold card-title"><%= beverage.get(i).getName() %></span><br>
                                <span class="text-s"><%= beverage.get(i).getCalorie() %> calories</span>
                                
                            </div>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= beverage.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Breakfast" />
                                        <input type="submit" name="submit" value="Breakfast" class="btn btn-info col-12"/>
                                        </form>
                                    </div>
                                    <div class="col-md-6 p-0">
                                        <form action="../meal/mealDetail.jsp" method="post">
                                            <input type="hidden" name="mealid" value="<%= beverage.get(i).getId() %>" />
                                            <input type="hidden" name="mealSes" value="Lunch" />
                                        <input type="submit" name="submit" value="Lunch" class="btn btn-warning col-12" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <% }
                    } %>
                    
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
