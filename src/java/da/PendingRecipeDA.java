package da;

import domain.*;
import static java.lang.System.out;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class PendingRecipeDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"PENDING_RECIPE\"";
    private Connection conn;
    private PreparedStatement stmt;
    private IngredientDA ingredientDA = new IngredientDA();

    public PendingRecipeDA() {
        createConnection();
    }
    
    public PendingRecipe getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE PENDING_ID = ?";
        PendingRecipe pendingRecipe = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                pendingRecipe = new PendingRecipe(rs.getInt("PENDING_ID"), ingredient , rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return pendingRecipe;
    }
    
    public void addRecord(PendingRecipe pendingRecipe) {
        String queryStr = "SELECT * FROM " + tableName;
        String updateStr = "UPDATE " + tableName + " SET RECIPE_SIZE = ? WHERE PENDING_ID = ?";
        String insertStr = "INSERT INTO NBUSER.PENDING_RECIPE (INGREDIENT_ID, RECIPE_SIZE, RECIPE_UNIT) VALUES (?, ?, ?)";
        ArrayList<PendingRecipe> allPendingRecipe = new ArrayList<PendingRecipe>();
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                allPendingRecipe.add(new PendingRecipe(rs.getInt("PENDING_ID"), ingredient , rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT")));
            }
            int conf = 0;
            for(int i=0;i<allPendingRecipe.size();i++){
                if(allPendingRecipe.get(i).getIngredient().getId()==pendingRecipe.getIngredient().getId()){
                    try{            
                        stmt = conn.prepareStatement(updateStr);
                        stmt.setDouble(1, pendingRecipe.getSize() + allPendingRecipe.get(i).getSize());
                        stmt.setInt(2, allPendingRecipe.get(i).getId());
                        stmt.executeUpdate();              
                    }
                    catch(SQLException ex){
                        JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
                    }
                    conf = 1;
                }
            }
            if(conf==0){
                stmt = conn.prepareStatement(insertStr);
                stmt.setInt(1, pendingRecipe.getIngredient().getId());
                stmt.setDouble(2, pendingRecipe.getSize());
                stmt.setString(3, pendingRecipe.getUnit());
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<PendingRecipe> getAllPendingRecipes() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<PendingRecipe> pendingRecipe = new ArrayList<PendingRecipe>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                pendingRecipe.add(new PendingRecipe(rs.getInt("PENDING_ID"), ingredient , rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT")));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return pendingRecipe;
    }
   
    public PendingRecipe getLastPendingRecipes() {
        String queryStr = "SELECT * FROM " + tableName;
        PendingRecipe pendingRecipe = null;
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Ingredient ingredient = ingredientDA.getRecord(rs.getInt("INGREDIENT_ID"));
                pendingRecipe = new PendingRecipe(rs.getInt("PENDING_ID"), ingredient , rs.getDouble("RECIPE_SIZE"), rs.getString("RECIPE_UNIT"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return pendingRecipe;
    }
    
    public void modRecord(int id, String name, String desc, double price, int catid){
        String updateStr = "UPDATE " + tableName + " SET PROD_NAME = ?, PROD_DESC = ?, PROD_PRICE = ?, CAT_ID = ? WHERE PROD_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, name);
            stmt.setString(2, desc);
            stmt.setDouble(3, price);
            stmt.setInt(4, catid);
            stmt.setInt(5, id);
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void delRecord(int id){
        String deleteStr = "DELETE FROM " + tableName + " WHERE PENDING_ID = ?";
        try{                     
            stmt = conn.prepareStatement(deleteStr);
            stmt.setInt(1, id);
            stmt.executeUpdate();                      
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void delAll() {
        String queryStr = "DELETE FROM NBUSER.PENDING_RECIPE";
       
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.executeUpdate();
            
        } catch (SQLException ex) {
        }
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
