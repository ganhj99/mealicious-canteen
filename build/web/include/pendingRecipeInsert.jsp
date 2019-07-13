<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  PendingRecipeDA pendingRecipeDA = new PendingRecipeDA();
    IngredientDA ingredientDA = new IngredientDA();
     
    int iid = Integer.parseInt(request.getParameter("iid"));
    Ingredient ingredient = ingredientDA.getRecord(iid);
    
    Double size = Double.parseDouble(request.getParameter("size"));
    
    String unit = request.getParameter("unit");
    
    PendingRecipe pr = new PendingRecipe(ingredient, size, unit);
    pendingRecipeDA.addRecord(pr);
    
    pr = pendingRecipeDA.getLastPendingRecipes();
    
    int prID = pr.getId();
%>

<% out.print(prID); %>