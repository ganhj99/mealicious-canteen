package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class CategoryDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"CATEGORY\"";
    private Connection conn;
    private PreparedStatement stmt;

    public CategoryDA() {
        createConnection();
    }
    
    public Category getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CAT_ID = ?";
        Category category = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                category = new Category(rs.getInt("CAT_ID"), rs.getString("CAT_NAME"));
            }
        } catch (SQLException ex) {
        }
        return category;
    } 
    
    public Category getNameRecord(String name) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CAT_NAME = ?";
        Category category = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                category = new Category(rs.getInt("CAT_ID"), rs.getString("CAT_NAME"));
            }
        } catch (SQLException ex) {
        }
        return category;
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
