package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class WeeklyCalorieDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private Connection conn;
    private PreparedStatement stmt;

    public WeeklyCalorieDA() {
        createConnection();
    }
    
    public ArrayList<WeeklyCalorie> getRecord(String sid, Date date, Date date2) {
        String queryStr = "SELECT OD.MEAL_COLLECTDATE, SUM(M.MEAL_CALORIES * OD.QUANTITY) FROM ORDER_DETAIL OD, MEAL_ORDER MO, MEAL M WHERE MO.ORDER_ID = OD.ORDER_ID AND OD.MEAL_ID = M.MEAL_ID AND MO.ORDER_STUD = ? AND MO.ORDER_STATUS = 'Success' AND OD.ORDERMEAL_STATUS <> 'Cancel' AND OD.MEAL_COLLECTDATE BETWEEN ? AND ? GROUP BY OD.MEAL_COLLECTDATE";
        ArrayList<WeeklyCalorie> wc = new ArrayList<WeeklyCalorie>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, sid);
            stmt.setDate(2, date);
            stmt.setDate(3, date2);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                wc.add(new WeeklyCalorie(rs.getDate(1), rs.getDouble(2)));
            }
        } catch (SQLException ex) {
        }
        return wc;
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
