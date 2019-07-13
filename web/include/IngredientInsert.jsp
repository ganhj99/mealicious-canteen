<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  IngredientDA ingredientDA = new IngredientDA();

    String name = request.getParameter("name");
    
    Double fat = Double.parseDouble(request.getParameter("fat"));
    
    Double carb = Double.parseDouble(request.getParameter("carb"));
    
    Double prot = Double.parseDouble(request.getParameter("prot"));
    
    Double size = Double.parseDouble(request.getParameter("size"));
    
    String unit = request.getParameter("unit");
   
    Ingredient ingredient = new Ingredient(name, fat, carb, prot, size, unit);
    ingredientDA.addRecord(ingredient);
%>

<%@include file="../include/ingredientTable.jsp" %> 