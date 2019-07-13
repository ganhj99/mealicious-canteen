package da;

import domain.*;
import static java.lang.System.out;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class RecipeDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"RECIPE\"";
    private Connection conn;
    private PreparedStatement stmt;
    private MealDA mealDA = new MealDA();
    private IngredientDA ingredientDA = new IngredientDA();

    public RecipeDA() {
        createConnection();
    }
    
    public void addRecord(Recipe recipe) {
        String insertStr = "INSERT INTO NBUSER.RECIPE (MEAL_ID, INGREDIENT_ID, RECIPE_SIZE, RECIPE_UNIT) VALUES (?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setInt(1, recipe.getMeal().getId());
            stmt.setInt(2, recipe.getIngredient().getId());
            stmt.setDouble(3, recipe.getSize());
            stmt.setString(4, recipe.getUnit());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public Recipe getRecord(int id, int id2) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE MEAL_ID = ? and INGREDIENT_ID = ?";
        Recipe recipe = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setInt(2, id2);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Meal meal =mealDA.getRecord(rs.getInt("MEAL_ID"));
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                recipe = new Recipe(meal, ingredient, rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return recipe;
    }
    
    public ArrayList<Recipe> getAllMeal(int oid){
        String q = "SELECT * FROM " + tableName + " WHERE MEAL_ID = ?";
        ArrayList<Recipe> recipe = new ArrayList<Recipe>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setInt(1, oid);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Meal meal = mealDA.getRecord(oid);
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                recipe.add(new Recipe(meal, ingredient, rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT")));
            }
        }catch(SQLException ex){
            out.println("Fail"+ex);
        }
        return recipe;
    }
      
    public ArrayList<Recipe> dailyPreparation(Date date){
        String q = "SELECT R.* FROM ORDER_DETAIL OD, MEAL_ORDER MO, MEAL M, RECIPE R, INGREDIENT I WHERE MO.ORDER_ID = OD.ORDER_ID AND OD.MEAL_ID = M.MEAL_ID AND M.MEAL_ID = R.MEAL_ID AND R.INGREDIENT_ID = I.INGREDIENT_ID AND MO.ORDER_STATUS = 'Success' AND OD.MEAL_COLLECTDATE = ?";
        ArrayList<Recipe> recipe = new ArrayList<Recipe>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setDate(1, date);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                recipe.add(new Recipe(meal, ingredient, rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT")));
            }
        }catch(SQLException ex){
            out.println("Fail"+ex);
        }
        return recipe;
    }
   
    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

}
