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

        <!-- Begin Page Content -->
        <div class="container-fluid">
            
        <jsp:useBean id="mealDA" class="da.MealDA" scope="application"></jsp:useBean>  

           <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Meal List</h1>
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
            <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <div class="row">
             
             <% ArrayList<Meal> meal = new ArrayList<Meal>(); %>
             <% meal = mealDA.getMeals(1); %>
             <% for (int i = 0; i < meal.size(); i++) { %> 
                    
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <a href="updateMeal.jsp?mealID=<%= meal.get(i).getId() %>" ><img class="card-img-top img-fluid" src="<%= meal.get(i).getImg() %>"/></a>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= meal.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <a href="updateMeal.jsp?mealID=<%= meal.get(i).getId() %>" ><span class="text-gray-800 font-weight-bold card-title"><%= meal.get(i).getName() %></span></a><br>
                                <span class="text-s"><%= String.format("%.2f", meal.get(i).getCalorie()) %> calories</span>
                                
                            </div>
                            
                        </div>
                        
                    </div>
                     
                  <% } %>
                    
                </div>
            </div>
          <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
              <div class="row">
             
             <% ArrayList<Meal> noodle = new ArrayList<Meal>(); %>
             <% noodle = mealDA.getMeals(2); %>
             <% for (int i = 0; i < noodle.size(); i++) { %> 
                    
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <a href="updateMeal.jsp?mealID=<%= noodle.get(i).getId() %>" ><img class="card-img-top img-fluid" src="<%= noodle.get(i).getImg() %>"/></a>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= noodle.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <a href="updateMeal.jsp?mealID=<%= noodle.get(i).getId() %>" ><span class="text-gray-800 font-weight-bold card-title"><%= noodle.get(i).getName() %></span></a><br>
                                <span class="text-s"><%= String.format("%.2f", noodle.get(i).getCalorie()) %> calories</span>
                                
                            </div>
                            
                        </div>
                        
                    </div>
                     
                  <% } %>
                    
                </div>
          </div>
          <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
              <div class="row">
             
             <% ArrayList<Meal> dessert = new ArrayList<Meal>(); %>
             <% dessert = mealDA.getMeals(3); %>
             <% for (int i = 0; i < dessert.size(); i++) { %> 
                    
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <a href="updateMeal.jsp?mealID=<%= dessert.get(i).getId() %>" ><img class="card-img-top img-fluid" src="<%= dessert.get(i).getImg() %>"/></a>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= dessert.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <a href="updateMeal.jsp?mealID=<%= dessert.get(i).getId() %>" ><span class="text-gray-800 font-weight-bold card-title"><%= dessert.get(i).getName() %></span></a><br>
                                <span class="text-s"><%= String.format("%.2f", dessert.get(i).getCalorie()) %> calories</span>
                                
                            </div>
                            
                        </div>
                        
                    </div>
                     
                  <% } %>
                    
                </div>
          </div>
          <div class="tab-pane fade" id="pills-beverages" role="tabpanel" aria-labelledby="pills-beverages-tab">
              <div class="row">
             
             <% ArrayList<Meal> beverage = new ArrayList<Meal>(); %>
             <% beverage = mealDA.getMeals(4); %>
             <% for (int i = 0; i < beverage.size(); i++) { %> 
                    
                    <div class="col-lg-3 py-2">
                        <div class="card shadow view overlay zoom">
                            <a href="updateMeal.jsp?mealID=<%= beverage.get(i).getId() %>" ><img class="card-img-top img-fluid" src="<%= beverage.get(i).getImg() %>"/></a>
                            
                                <div class="card-img-overlay text-right">
                                    <span class="bg-gradient-primary rounded text-white p-1"><%= beverage.get(i).getCp()%> points</span>
                                </div>
                                <div class="mask flex-center">
                        </div>
                            <div class="card-body">
                                <a href="updateMeal.jsp?mealID=<%= beverage.get(i).getId() %>" ><span class="text-gray-800 font-weight-bold card-title"><%= beverage.get(i).getName() %></span></a><br>
                                <span class="text-s"><%= String.format("%.2f", beverage.get(i).getCalorie()) %> calories</span>
                                
                            </div>
                            
                        </div>
                        
                    </div>
                     
                  <% } %>
                    
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
