<%-- 
    Document   : sidebar
    Created on : Mar 30, 2019, 7:22:55 PM
    Author     : USER
--%>

<style>
    .sidebar-text-shadow{        
        text-shadow:0px 0px 3px #000;
    }
</style>
<%@page import="control.*, domain.*"%>


<% String requestURI = request.getRequestURI(); %>

<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar" style="background-image: url('../img/food-bg-sidebar.jpg'); ">

  <!-- Sidebar - Brand -->
  <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
    <div class="sidebar-brand-icon rotate-n-15">
      <i class="fas fa-laugh-wink" style="text-shadow: 0px 0px 1px rgba(150, 150, 150, 1);"></i>
    </div>
    <div class="sidebar-brand-text mx-3" style="text-shadow: 0px 0px 1px rgba(150, 150, 150, 1);">Mealicious</div>
  </a>

  <!-- Divider -->
  <hr class="sidebar-divider my-0">

  <li class="nav-item <% if(requestURI.equals(request.getContextPath()+"/portal/dashboard.jsp")){ %> active <% } %>">
    <a class="nav-link" href="../portal/dashboard.jsp">
      <i class="fas fa-fw fa-tachometer-alt sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Dashboard</span></a>
  </li>

  <!-- Divider -->
  <hr class="sidebar-divider">

  <!-- Heading -->
  <div class="sidebar-heading sidebar-text-shadow">
    Interface
  </div>

  <% if("Student".equals(currentUserRole)){ %>
  <!-- Nav Item - Order Collapse Menu (STUDENT ONLY) -->
  <li class="nav-item <% if(requestURI.matches("(.*)/order/(.*)")){ %> active <% } %>">
    <a class="nav-link <% if(requestURI.matches("(.*)/order/(.*)")){ %> show <% } else { %> collapsed <% } %>" href="#" data-toggle="collapse" data-target="#collapseOrder" aria-expanded="true" aria-controls="collapseOrder">
      <i class="fas fa-fw fa-utensils sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Order</span>
    </a>
    <div id="collapseOrder" class="collapse <% if(requestURI.matches("(.*)/order/(.*)")){ %> show <% } %>" aria-labelledby="headingOrder" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
          <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/order/todayCoupon.jsp")){ %> active <% } %>" href="../order/todayCoupon.jsp">Today's Coupon</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/order/displayMeal.jsp")){ %> active <% } %>" href="../order/displayMeal.jsp">Make Pre-Order</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/order/orderHistory.jsp")){ %> active <% } %>" href="../order/orderHistory.jsp">Order History</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/order/monthlyOrder.jsp")){ %> active <% } %>" href="../order/monthlyOrder.jsp">Make Weekly/Monthly Order</a>
      </div>
    </div>
  </li>
  <% } %>
  
  <% if("Staff".equals(currentUserRole) && "Admin".equals(currentStaffPost)){ %>
  <!-- Nav Item - Staff Management Collapse Menu (Admin ONLY)-->
  <li class="nav-item <% if(requestURI.matches("(.*)/staffManagement/(.*)")){ %> active <% } %>">
    <a class="nav-link <% if(requestURI.matches("(.*)/staffManagement/(.*)")){ %> show <% } else { %> collapsed <% } %>" href="#" data-toggle="collapse" data-target="#collapseStaffManagement" aria-expanded="true" aria-controls="collapseStaffManagement">
      <i class="fas fa-fw fa-user-edit sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Staff Management</span>
    </a>
    <div id="collapseStaffManagement" class="collapse <% if(requestURI.matches("(.*)/staffManagement/(.*)")){ %> show <% } %>" aria-labelledby="headingStaffManagement" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/staffManagement/registerStaff.jsp")){ %> active <% } %>" href="../staffManagement/registerStaff.jsp">Staff Registration</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/staffManagement/staffList.jsp")){ %> active <% } %>" href="../staffManagement/staffList.jsp">Staff List</a>
      </div>
    </div>
  </li>
  <% } %>
  
  <% if("Staff".equals(currentUserRole) && "Manager".equals(currentStaffPost)){ %>
  <!-- Nav Item - Meal Management Collapse Menu (Manager ONLY)-->
  <li class="nav-item <% if(requestURI.matches("(.*)/mealManagement/(.*)")){ %> active <% } %>">
    <a class="nav-link <% if(requestURI.matches("(.*)/mealManagement/(.*)")){ %> show <% } else { %> collapsed <% } %>" href="#" data-toggle="collapse" data-target="#collapseMealManagement" aria-expanded="true" aria-controls="collapseMealManagement">
      <i class="fas fa-fw fa-wrench sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Meal Management</span>
    </a>
    <div id="collapseMealManagement" class="collapse <% if(requestURI.matches("(.*)/mealManagement/(.*)")){ %> show <% } %>" aria-labelledby="headingMealManagement" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/mealManagement/addMeal.jsp")){ %> active <% } %>" href="../mealManagement/addMeal.jsp">Create New Meal</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/mealManagement/mealList.jsp")){ %> active <% } %>" href="../mealManagement/mealList.jsp">Update Meal</a> <%--FROM MEAL LISTING -> UPDATE MEAL--%>
      </div>
    </div>
  </li>
  <% } %>

  <% if("Staff".equals(currentUserRole) && ("Manager".equals(currentStaffPost) || "Cashier".equals(currentStaffPost))){ %>
  <!-- Nav Item - Meal Redeemption (Cashier and Manager ONLY)-->
  <li class="nav-item <% if(requestURI.equals(request.getContextPath()+"/mealRedeemption/redeemFood.jsp")){ %> active <% } %>">
    <a class="nav-link" href="../mealRedeemption/redeemFood.jsp">
      <i class="fas fa-fw fa-barcode sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Meal Redeemption</span></a>
  </li>
  <% } %>
    
  <% if("Staff".equals(currentUserRole) && ("Manager".equals(currentStaffPost) || "Cashier".equals(currentStaffPost))){ %>
  <!-- Nav Item - Top Up (Manager & Cashier ONLY) -->
  <li class="nav-item <% if(requestURI.equals(request.getContextPath()+"/creditPoint/topup.jsp")){ %> active <% } %>">
    <a class="nav-link" href="../creditPoint/topup.jsp">
      <i class="fas fa-fw fa-coins sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Topup Credit Point</span></a>
  </li>
  <% } %>
  
  <% if("Staff".equals(currentUserRole) && "Manager".equals(currentStaffPost)){ %>
    <!-- Nav Item - Reports Collapse Menu (Manager ONLY)-->
  <li class="nav-item <% if(requestURI.matches("(.*)/reports/(.*)")){ %> active <% } %>">
    <a class="nav-link <% if(requestURI.matches("(.*)/reports/(.*)")){ %> show <% } else { %> collapsed <% } %>" href="#" data-toggle="collapse" data-target="#collapseReports" aria-expanded="true" aria-controls="collapseReports">
      <i class="fas fa-fw fa-chart-area sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Reports</span>
    </a>
    <div id="collapseReports" class="collapse <% if(requestURI.matches("(.*)/reports/(.*)")){ %> show <% } %>" aria-labelledby="headingReports" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/foodPreparation.jsp")){ %> active <% } %>" href="../reports/foodPreparation.jsp">Daily Food Preparation</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/bestSelling.jsp")){ %> active <% } %>" href="../reports/bestSelling.jsp">Monthly Best Selling</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/monthlyTopupSummary.jsp")){ %> active <% } %>" href="../reports/monthlyTopupSummary.jsp">Monthly Topup Summary</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/monthlySaleSummary.jsp")){ %> active <% } %>" href="../reports/monthlySaleSummary.jsp">Monthly Sales Summary</a>
      </div>
    </div>
  </li>
  <% } %>
  
  <% if("Student".equals(currentUserRole)){ %>
  <!-- Nav Item - Reports Collapse Menu (Student ONLY)-->
  <li class="nav-item <% if(requestURI.matches("(.*)/reports/(.*)")){ %> active <% } %>">
    <a class="nav-link <% if(requestURI.matches("(.*)/reports/(.*)")){ %> show <% } else { %> collapsed <% } %>" href="#" data-toggle="collapse" data-target="#collapseReports" aria-expanded="true" aria-controls="collapseReports">
      <i class="fas fa-fw fa-chart-area sidebar-text-shadow"></i>
      <span class="sidebar-text-shadow">Reports</span>
    </a>
    <div id="collapseReports" class="collapse <% if(requestURI.matches("(.*)/reports/(.*)")){ %> show <% } %>" aria-labelledby="headingReports" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/weeklyCalorieIntake.jsp")){ %> active <% } %>" href="../reports/weeklyCalorieIntake.jsp">Weekly Calorie Intake</a>
        <a class="collapse-item <% if(requestURI.equals(request.getContextPath()+"/reports/monthlyTopupTransaction.jsp")){ %> active <% } %>" href="../reports/monthlyTopupTransaction.jsp">Monthly Topup Transaction</a>
      </div>
    </div>
  </li>
  <% } %>
  <!-- Divider -->
  <hr class="sidebar-divider">

  <!-- Sidebar Toggler (Sidebar) -->
  <div class="text-center d-none d-md-inline">
    <button class="rounded-circle border-0 sidebar-text-shadow" id="sidebarToggle"></button>
  </div>

</ul>