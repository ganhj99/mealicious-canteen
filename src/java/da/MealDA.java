package da;

import domain.*;
import static java.lang.System.out;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class MealDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"MEAL\"";
    private Connection conn;
    private PreparedStatement stmt;
    private CategoryDA categoryDA = new CategoryDA();

    public MealDA() {
        createConnection();
    }
    
    public Meal getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE MEAL_ID = ?";
        Meal meal = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Category category = categoryDA.getRecord(rs.getInt("CAT_ID"));
                meal = new Meal(rs.getInt("MEAL_ID"),  rs.getString("MEAL_NAME"), rs.getString("MEAL_DESCRIPTION"), rs.getString("MEAL_IMAGE"), rs.getInt("MEAL_CREDITPTS"), rs.getString("MEAL_STATUS"), rs.getDouble("MEAL_CALORIES"), category);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return meal;
    }
    
    public void addRecord(Meal meal) {
        String insertStr = "INSERT INTO NBUSER.MEAL (MEAL_NAME, MEAL_DESCRIPTION, MEAL_IMAGE, MEAL_CREDITPTS, MEAL_STATUS, MEAL_CALORIES, CAT_ID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, meal.getName());
            stmt.setString(2, meal.getDesc());
            stmt.setString(3, meal.getImg());
            stmt.setInt(4, meal.getCp());
            stmt.setString(5, meal.getStatus());
            stmt.setDouble(6, meal.getCalorie());
            stmt.setInt(7, meal.getCategory().getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<Meal> getAllMeals() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Meal> meal = new ArrayList<Meal>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Category category = categoryDA.getRecord(rs.getInt("CAT_ID"));
                meal.add(new Meal(rs.getInt("MEAL_ID"),  rs.getString("MEAL_NAME"), rs.getString("MEAL_DESCRIPTION"), rs.getString("MEAL_IMAGE"), rs.getInt("MEAL_CREDITPTS"), rs.getString("MEAL_STATUS"), rs.getDouble("MEAL_CALORIES"), category));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return meal;
    }
    
    public ArrayList<Meal> getMeals(int catId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CAT_ID = ?";
        ArrayList<Meal> meal = new ArrayList<Meal>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, catId);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Category category = categoryDA.getRecord(rs.getInt("CAT_ID"));
                meal.add(new Meal(rs.getInt("MEAL_ID"),  rs.getString("MEAL_NAME"), rs.getString("MEAL_DESCRIPTION"), rs.getString("MEAL_IMAGE"), rs.getInt("MEAL_CREDITPTS"), rs.getString("MEAL_STATUS"), rs.getDouble("MEAL_CALORIES"), category));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return meal;
    }
    
    public Meal getLastMeal() {
        String queryStr = "SELECT * FROM " + tableName;
        Meal meal = null;
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Category category = categoryDA.getRecord(rs.getInt("CAT_ID"));
                meal = new Meal(rs.getInt("MEAL_ID"),  rs.getString("MEAL_NAME"), rs.getString("MEAL_DESCRIPTION"), rs.getString("MEAL_IMAGE"), rs.getInt("MEAL_CREDITPTS"), rs.getString("MEAL_STATUS"), rs.getDouble("MEAL_CALORIES"), category);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return meal;
    }
    
    public void modRecord(int id, int pr, String stt){
        String updateStr = "UPDATE " + tableName + " SET MEAL_CREDITPTS = ?, MEAL_STATUS = ? WHERE MEAL_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, pr);
            stmt.setString(2, stt);
            stmt.setInt(3, id);
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void delRecord(int id){
        String deleteStr = "DELETE FROM " + tableName + " WHERE MEAL_ID = ?";
        try{                     
                    stmt = conn.prepareStatement(deleteStr);
                    stmt.setInt(1, id);
                    stmt.executeUpdate();                      
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
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
