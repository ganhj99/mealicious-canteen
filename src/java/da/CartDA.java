package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class CartDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"CART\"";
    private Connection conn;
    private PreparedStatement stmt;
    private StudentDA studentDA = new StudentDA();

    public CartDA() {
        createConnection();
    }
    
    public void addRecord(String id) {
        String insertStr = "INSERT INTO " + tableName + " (ORDER_STUD) VALUES(?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public Cart getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CART_ID = ?";
        Cart cart = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Student student = studentDA.getRecordByStudId(rs.getString("ORDER_STUD"));
                cart = new Cart(id, student);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return cart;
    }
    
    public Cart checkRecord(String studid) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ORDER_STUD = ?";
        Cart cart = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studid);
            ResultSet rs = stmt.executeQuery();         
            if (rs.next()) {
                Student student = studentDA.getRecordByStudId(studid);
                cart = new Cart(rs.getInt("CART_ID"), student);  
            }
            else{
                return null;
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return cart;
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
