<%-- 
    Document   : cartInsert
    Created on : Apr 5, 2019, 2:18:03 AM
    Author     : user
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="da.*"%>
<%@page import="domain.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%  MealDA mealDA = new MealDA();
    CategoryDA categoryDA = new CategoryDA();
    PendingRecipeDA pendingRecipeDA = new PendingRecipeDA();
    RecipeDA recipeDA = new RecipeDA();

    String name = request.getParameter("name");
    
    Category category = categoryDA.getNameRecord(request.getParameter("cat"));
    
    String desc = request.getParameter("desc");
    
    int pr = Integer.parseInt(request.getParameter("pr"));
    
    String img = ".." + request.getParameter("img").substring(49);
    
    String stt = request.getParameter("stt");
    
    ArrayList<PendingRecipe> pendingRecipe = new ArrayList<PendingRecipe>(); 
    pendingRecipe.addAll(pendingRecipeDA.getAllPendingRecipes());
    
    double calorie = 0;
    for (int i = 0; i < pendingRecipe.size(); i++) { 
        calorie += ((pendingRecipe.get(i).getIngredient().calCalorie() / pendingRecipe.get(i).getIngredient().getSize()) * pendingRecipe.get(i).getSize());
    }
    
    Meal meal = new Meal(name, desc, img, pr, stt, calorie, category);
    mealDA.addRecord(meal);
    meal = mealDA.getLastMeal();
    
    Recipe recipe = null;

    for (int i = 0; i < pendingRecipe.size(); i++) { 
        recipe = new Recipe(meal, pendingRecipe.get(i).getIngredient(), pendingRecipe.get(i).getSize(), pendingRecipe.get(i).getUnit());
        recipeDA.addRecord(recipe);
    }
    
    pendingRecipeDA.delAll();
%>