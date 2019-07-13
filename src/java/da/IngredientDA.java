package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class IngredientDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"INGREDIENT\"";
    private Connection conn;
    private PreparedStatement stmt;

    public IngredientDA() {
        createConnection();
    }
    
    public Ingredient getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE INGREDIENT_ID = ?";
        Ingredient ingredient = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ingredient = new Ingredient(rs.getInt("INGREDIENT_ID"), rs.getString("INGREDIENT_NAME"), rs.getDouble("FATS"), rs.getDouble("CARBS"), rs.getDouble("PROTEIN"), rs.getDouble("SAMPLE_SIZE"), rs.getString("SAMPLE_UNIT"));
            }
        } catch (SQLException ex) {
        }
        return ingredient;
    }
    
    public void addRecord(Ingredient ingredient) {
        String insertStr = "INSERT INTO NBUSER.INGREDIENT (INGREDIENT_NAME, FATS, CARBS, PROTEIN, SAMPLE_SIZE, SAMPLE_UNIT) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, ingredient.getName());
            stmt.setDouble(2, ingredient.getFat());
            stmt.setDouble(3, ingredient.getCarb());
            stmt.setDouble(4, ingredient.getProtein());
            stmt.setDouble(5, ingredient.getSize());
            stmt.setString(6, ingredient.getUnit());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<Ingredient> getAllIngredients() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Ingredient> ingredient = new ArrayList<Ingredient>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                ingredient.add(new Ingredient(rs.getInt("INGREDIENT_ID"), rs.getString("INGREDIENT_NAME"), rs.getDouble("FATS"), rs.getDouble("CARBS"), rs.getDouble("PROTEIN"), rs.getDouble("SAMPLE_SIZE"), rs.getString("SAMPLE_UNIT")));
            }
        } catch (SQLException ex) {
        }
        return ingredient;
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
