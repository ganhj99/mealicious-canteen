<%-- 
    Document   : dataTableTodayTopupRecord
    Created on : Apr 8, 2019, 12:36:16 AM
    Author     : USER
--%>

<%@page import="domain.*"%>
<%@page import="da.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page trimDirectiveWhitespaces="true" %>

<div class="table-responsive ingredientTable">
<table class="table table-bordered" id="dataTable3" width="100%" cellspacing="0">
  <thead>
    <tr>
      <th></th>
      <th>Ingredient Name</th>
      <th>Servings</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <th></th>
      <th>Ingredient Name</th>
      <th>Servings</th>
    </tr>
  </tfoot>
  <tbody>

    <% ArrayList<Ingredient> ingre = new ArrayList<Ingredient>(); %>
    <% ingre.addAll(ingredientDA.getAllIngredients()); %>
    <% for(int i=0;i<ingre.size();i++){ %>
    <tr>
      <td>
        <button type="button" class="close addRecipe" aria-label="Close" data-toggle="tooltip" title="Add Ingredient">
            <i class="fas fa-plus-circle" aria-hidden="true"></i>
          </button>
      </td>
      <td><%= ingre.get(i).getName() %></td>
      <td>
          <input type="hidden" class="ingreID" value="<%= ingre.get(i).getId() %>">
          <input type="hidden" class="ingreUnit" value="<%= ingre.get(i).getUnit() %>">
          <input type="hidden" class="ingreName" value="<%= ingre.get(i).getName() %>">

        <div class="form-group input-group-sm">
            <div class="input-group">
            <input type="number" id="recipe-size" class="form-control ingreSize" >
            <div class="input-group-append">
                <span class="input-group-text"><%= ingre.get(i).getUnit() %></span>
            </div>
            </div>
        </div>
      </td>
    </tr>
    <% } %>

  </tbody>
</table>
</div>
    
  <script>
 $(document).ready(function(){  
     
  $("#dataTable3").on('click','.addRecipe',function (){
    var ingreID = $(this).parent().siblings().find(".ingreID").val(); 
    var ingreName = $(this).parent().siblings().find(".ingreName").val(); 
    var ingreUnit = $(this).parent().siblings().find(".ingreUnit").val(); 
    var ingreSize = $(this).parent().siblings().find(".ingreSize").val(); 
    
    $.ajax({
    type: 'post',
    url: '../include/pendingRecipeInsert.jsp',
    data: {
        iid : ingreID,
        unit : ingreUnit,
        size : ingreSize
    },
    success: function(data){
        //alert("Insert Success");
        $('#infoModalLabel').addClass('fa-check-circle text-success');
        $('#infoModalTitle').text('Great!');
        $('#infoModalBodyText').html("You've added a recipe to this new meal.");
        $('#infoModalBtn').addClass('btn-success');
        $('#infoModal').modal('show');
        $('.ingreList').prepend("<tr><td><button type='button' style='font-size: 0.9rem;padding: 0;\n\
        border: 0;' class='btn removeIngre' data-toggle='tooltip' title='Remove Ingredient'><i class='fas fa-minus-circle' \n\
        aria-hidden='true'></i></button></td><td><input type='hidden' class='PendingID' value='" + data + "'>" + ingreSize + "</td><td>" + ingreUnit + "</td><td>" + ingreName + "</td></tr>");
    
        $(".removeIngre").click(function(){
        var pendingID = $(this).parent().siblings().find(".PendingID").val(); 
        $(this).parent().parent().fadeOut("slow",function(){
            $(this).parent().parent().remove();
        });
        
        $.ajax({
            type: 'post',
            url: '../include/removeIngredient.jsp',
            data: {
                pid : pendingID
            },
            success: function(data){
            }
            });
         });
    }
    });
  })
});
  </script>
  
<script src='../vendor/datatables/jquery.dataTables.min.js'></script>
<script src='../vendor/datatables/dataTables.bootstrap4.min.js'></script>
<script src='../js/demo/datatables-demo.js'></script>
