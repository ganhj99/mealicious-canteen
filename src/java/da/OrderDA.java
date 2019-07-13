package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class OrderDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"MEAL_ORDER\"";
    private Connection conn;
    private PreparedStatement stmt;
    private StudentDA studentDA = new StudentDA();
    private CartDetailDA cartDetailDA = new CartDetailDA();

    public OrderDA() {
        createConnection();
    }
    
    public void addRecord(Order order) {
        String insertStr = "INSERT INTO NBUSER.MEAL_ORDER (ORDER_DATE, ORDER_STATUS, TOTAL_CREDITPTS, ORDER_STUD) VALUES (?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setTimestamp(1, order.getDateOrder());
            stmt.setString(2, order.getStatus());
            stmt.setInt(3, order.getTtlcp());
            stmt.setString(4, order.getStudent().getId());
            stmt.executeUpdate();
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public ArrayList<Order> getAllOrder(String studid) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ORDER_STUD = ?";
        ArrayList<Order> order = new ArrayList<Order>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studid);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Student student = studentDA.getRecordByStudId(studid);
                order.add(new Order(rs.getInt("ORDER_ID"), rs.getTimestamp("ORDER_DATE"), rs.getString("ORDER_STATUS"), rs.getInt("TOTAL_CREDITPTS"), student));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return order;
    }
    
    public Order getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ORDER_ID = ?";
        Order order = new Order();
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                Student student = studentDA.getRecordByStudId(rs.getString("ORDER_STUD"));
                order = new Order(rs.getInt("ORDER_ID"), rs.getTimestamp("ORDER_DATE"), rs.getString("ORDER_STATUS"), rs.getInt("TOTAL_CREDITPTS"), student);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return order;
    }
    
    public Order getOrderId(String studid) {
        String queryStr = "SELECT * FROM NBUSER.\"MEAL_ORDER\" WHERE ORDER_STUD = ?";
        Order order = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Student student = studentDA.getRecordByStudId(studid);
                order = new Order(rs.getInt("ORDER_ID"), rs.getTimestamp("ORDER_DATE"), rs.getString("ORDER_STATUS"), rs.getInt("TOTAL_CREDITPTS"), student);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return order;
    }
    
    public void modRecord(int id){
        String updateStr = "UPDATE " + tableName + " SET ORDER_STATUS = ? WHERE ORDER_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, "Cancel");
            stmt.setInt(2, id);
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
