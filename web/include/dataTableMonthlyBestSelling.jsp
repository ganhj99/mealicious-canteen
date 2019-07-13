<%-- 
    Document   : dataTableMonthlyTopup
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.ArrayList, java.sql.*" %>

<%  // Get month & year from url parameter
    String month = request.getParameter("month");
    String year = request.getParameter("year");
    int ranking;
    if(request.getParameter("ranking")!=null){
        ranking = Integer.valueOf(request.getParameter("ranking"));
    } else {
        ranking = 5;
    }
 %>
 <% //CreateConnection
     String host = "jdbc:derby://localhost:1527/mealiciousDB";
     String user = "nbuser";
     String password = "nbuser";
     Connection conn = null;
     PreparedStatement stmt;
     try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
        }
%>
<%  //Get record from database using multitable query
     String queryStr = "SELECT M.MEAL_NAME,SUM(OD.QUANTITY), M.MEAL_CREDITPTS " +
                        "FROM ORDER_DETAIL OD, MEAL_ORDER MO, MEAL M " +
                        "WHERE MO.ORDER_ID = OD.ORDER_ID " +
                        "    AND OD.MEAL_ID = M.MEAL_ID " +
                        "    AND MO.ORDER_STATUS = 'Success' " +
                        "    AND OD.ORDERMEAL_STATUS <> 'Cancel' "+
                        "    AND MONTH(OD.MEAL_COLLECTDATE) = ? AND YEAR(OD.MEAL_COLLECTDATE) = ? " +
                        "GROUP BY M.MEAL_NAME, M.MEAL_CREDITPTS " +
                        "ORDER BY SUM(OD.QUANTITY) DESC " + 
                        "FETCH FIRST " + ranking + " ROWS ONLY";
     try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, month);
            stmt.setString(2, year);
            ResultSet rs = stmt.executeQuery(); %>

    
<div class="table-responsive">
<table class="table table-bordered" id="dataTableBestSelling" width="100%" cellspacing="0">
  <thead>
    <tr>
        <th>Ranking</th>
      <th>Meal Name</th>
      <th>Credit Points</th>
      <th>Total Number Of Orders</th>
    </tr>
  </thead>
  <tbody>
    <% int i = 1; %>
    <% while (rs.next()) {%>
    <tr>
        <td><%= i %></td>
      <td><%= rs.getString(1) %></td>
      <td><%= String.valueOf(rs.getInt(3)) %></td>
      <td><%= String.valueOf(rs.getInt(2)) %></td>
    </tr>
     <% i++; }%>
    <% if (i==1){ %>
    <tr>
        <td colspan="4" class="text-center">No records found for this month. Please try again.</td>
    </tr>
    <% } %>
  </tbody>
</table>
</div>

<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>

<% } catch (SQLException ex) {
out.print(ex);
        }
%>