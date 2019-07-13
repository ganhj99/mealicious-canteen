package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class DailyPreparationDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private Connection conn;
    private PreparedStatement stmt;

    public DailyPreparationDA() {
        createConnection();
    }
    
    public ArrayList<DailyPreparation> getRecord(Date date) {
        String queryStr = "SELECT I.INGREDIENT_NAME, SUM(R.RECIPE_SIZE), R.RECIPE_UNIT FROM ORDER_DETAIL OD, MEAL_ORDER MO, MEAL M, RECIPE R, INGREDIENT I WHERE MO.ORDER_ID = OD.ORDER_ID AND OD.MEAL_ID = M.MEAL_ID AND M.MEAL_ID = R.MEAL_ID AND R.INGREDIENT_ID = I.INGREDIENT_ID AND MO.ORDER_STATUS = 'Success' AND OD.ORDERMEAL_STATUS <> 'Cancel' AND OD.MEAL_COLLECTDATE = ? GROUP BY I.INGREDIENT_NAME, R.RECIPE_UNIT";
        ArrayList<DailyPreparation> dp = new ArrayList<DailyPreparation>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setDate(1, date);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                dp.add(new DailyPreparation(rs.getString(1), rs.getDouble(2), rs.getString(3)));
            }
        } catch (SQLException ex) {
        }
        return dp;
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
