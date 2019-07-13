package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class MonthlySaleDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private Connection conn;
    private PreparedStatement stmt;

    public MonthlySaleDA() {
        createConnection();
    }
    
    public ArrayList<MonthlySale> getRecord(String mn, String yr) {
        String queryStr = "SELECT M.MEAL_NAME, OD.UNIT_CREDITPTS, SUM(OD.QUANTITY), SUM(OD.QUANTITY*OD.UNIT_CREDITPTS) FROM MEAL_ORDER MO, ORDER_DETAIL OD, MEAL M WHERE MO.ORDER_STATUS = 'Success' AND OD.ORDERMEAL_STATUS <> 'Cancel' AND MO.ORDER_ID = OD.ORDER_ID AND OD.MEAL_ID = M.MEAL_ID AND MONTH(OD.MEAL_COLLECTDATE) = ? AND YEAR(OD.MEAL_COLLECTDATE) = ? GROUP BY M.MEAL_NAME, OD.UNIT_CREDITPTS";
        ArrayList<MonthlySale> dp = new ArrayList<MonthlySale>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, mn);
            stmt.setString(2, yr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                dp.add(new MonthlySale(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4)));
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
