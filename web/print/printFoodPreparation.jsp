<%-- 
    Document   : printMonthlyBestSelling
    Created on : Apr 17, 2019, 10:59:15 PM
    Author     : USER
--%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<
<%@page import="java.time.Month"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.ArrayList, java.sql.*, java.time.*, java.text.*" %>

  <!-- Custom fonts for this template-->
  <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../css/sb-admin-2.min.css" rel="stylesheet">
  
  <!-- Custom styles for this page -->
  <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<title>Mealicious</title>
<body>
    <div class="text-center">
          <h1 class="fas fa-laugh-wink mt-2 rotate-n-15"></h1>
            <h1>Mealicious</h1>
          </div>
<%  DailyPreparationDA dailyPreparationDA = new DailyPreparationDA();
    
    String startDate = request.getParameter("dt");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = sdf1.parse(startDate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
      
%>
<% DateFormat dateFormatPrint = new SimpleDateFormat("dd MMMMM yyyy"); %>
    <h2 class="h2 text-center">Daily Food Preparation Report for <%= dateFormatPrint.format(sqlStartDate) %></h2>
    <div class="container-fluid">
        <%@include file="../include/dailyPreparationTable.jsp" %>
    </div>
    <script>
        window.print();
        setTimeout(function(){ window.close(); }, 100);
    </script>
</body>