<%-- 
    Document   : topbar
    Created on : Mar 30, 2019, 7:16:54 PM
    Author     : USER
--%>

<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

  <!-- Sidebar Toggle (Topbar) -->
  <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
    <i class="fa fa-bars"></i>
  </button>

  <!-- Topbar Navbar -->
  <ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown no-arrow mx-1">
        <div class="nav-link dropdown-toggle" href="#">
            <span class="mr-2 d-none d-lg-inline text-gray-600 small">Last Login: 
            <%@ page import="control.*, domain.*, java.text.*" %>
            <% if(true){ MaintainWebUserControl webUserControlTopbar = new MaintainWebUserControl();
               WebUser webUserTopbar = webUserControlTopbar.selectRecordWithUserId(currentUserId); 
               DateFormat dateFormatTopbar = new SimpleDateFormat("dd MMM yyyy h:mm a");
            %><% if (webUserTopbar.getLastLogin() != null){ %>
            <%= dateFormatTopbar.format(webUserTopbar.getLastLogin()) %>
            <% } else { %>
<%= "Not available" %>
<%}} %></span>
        </div>
    </li>
    
      
    <div class="topbar-divider d-none d-sm-block"></div>

    <!-- Nav Item - User Information -->
    <li class="nav-item dropdown no-arrow">
      <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="mr-2 d-none d-lg-inline text-gray-900 normal font-weight-bold"><%= currentUsername %>   </span>
          <% if("Student".equalsIgnoreCase(currentUserRole)){ MaintainStudentControl studentControlTopbar = new MaintainStudentControl();
               Student studentTopbar = studentControlTopbar.selectRecordByUserId(currentUserId);
            %>
          <span class="text-xs bg-gradient-info rounded text-white p-1">
              <i class="fas fa-coins"></i>
            <%= studentTopbar.getCpBalance() %>
            </span><% } %>
      </a>
      <!-- Dropdown - User Information -->
      <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
        <a class="dropdown-item" href="../portal/<%if("Student".equalsIgnoreCase(currentUserRole)){%>student<%}else if("Staff".equalsIgnoreCase(currentUserRole)){%>staff<%}%>Profile.jsp">
          <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
          Profile
        </a>
        <% if("Student".equalsIgnoreCase(currentUserRole)){ %>
        <a class="dropdown-item" href="../order/cart.jsp">
          <i class="fas fa-shopping-cart fa-sm fa-fw mr-2 text-gray-400"></i>
          Cart
        </a>
        <% } %>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
          Logout
        </a>
      </div>
    </li>

  </ul>

</nav>
