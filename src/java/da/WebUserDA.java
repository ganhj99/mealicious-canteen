package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class WebUserDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"WEB_USER\"";
    private Connection conn;
    private PreparedStatement stmt;

    public WebUserDA() {
        createConnection();
    }
    
    public WebUser getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE USER_ID = ?";
        WebUser webUser = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                webUser = new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getTimestamp("LAST_UPDATE"), rs.getTimestamp("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE"));
            }
        } catch (SQLException ex) {
        }
        return webUser;
    }
    
    public WebUser getRecordByUsername(String username) { // Get WebUser username for login.
        String queryStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ?";
        WebUser webUser = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                webUser = new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getTimestamp("LAST_UPDATE"), rs.getTimestamp("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE"));
            }
        } catch (SQLException ex) {
        }
        return webUser;
    }
    
    public WebUser getRecordByEmail(String email) { // Get WebUser username for login.
        String queryStr = "SELECT * FROM " + tableName + " WHERE EMAIL = ?";
        WebUser webUser = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                webUser = new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getTimestamp("LAST_UPDATE"), rs.getTimestamp("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE"));
            }
        } catch (SQLException ex) {
        }
        return webUser;
    }
    
    public WebUser getRecord(String username, String email) { // Get WebUser username & email, for password recovery.
        String queryStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ? AND EMAIL = ?";
        WebUser webUser = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, username);
            stmt.setString(2, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                webUser = new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getTimestamp("LAST_UPDATE"), rs.getTimestamp("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE"));
            }
        } catch (SQLException ex) {
        }
        return webUser;
    }
    
    public void addRecord(WebUser webUser) { 
        String insertStr = "INSERT INTO " + tableName + "(USERNAME, REAL_NAME, PHONE, EMAIL, EMAIL_VERIFYSTATUS, DATE_JOINED, LAST_UPDATE, LAST_LOGIN, PASS_ENCRYPTED, PASS_SALT, USER_ROLE) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, webUser.getUsername());
            stmt.setString(2, webUser.getRealName());
            stmt.setString(3, webUser.getPhone());
            stmt.setString(4, webUser.getEmail());
            stmt.setBoolean(5, webUser.getEmailVerify());
            stmt.setDate(6, webUser.getDateJoin());
            stmt.setTimestamp(7, webUser.getLastUpdate());
            stmt.setTimestamp(8, webUser.getLastLogin());
            stmt.setString(9, webUser.getPass());
            stmt.setString(10, webUser.getPassSalt());
            stmt.setString(11, webUser.getRole());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<WebUser> getAllWebUser() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<WebUser> webUser = new ArrayList<WebUser>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                webUser.add(new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getTimestamp("LAST_UPDATE"), rs.getTimestamp("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE")));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return webUser;
    }
    
//    public ArrayList<WebUser> getWebUsersStaff(String role) {
//        String queryStr = "SELECT * FROM " + tableName + " WHERE USER_ROLE = ?";
//        ArrayList<WebUser> webUser = new ArrayList<WebUser>();
//        try {       
//            stmt = conn.prepareStatement(queryStr);
//            stmt.setString(1, role);
//            ResultSet rs = stmt.executeQuery();
//            while(rs.next()){
//                webUser.add(new WebUser(rs.getInt("USER_ID"), rs.getString("USERNAME"), rs.getString("REAL_NAME"), rs.getString("PHONE"), rs.getString("EMAIL"), rs.getBoolean("EMAIL_VERIFYSTATUS"), rs.getDate("DATE_JOINED"), rs.getDate("LAST_UPDATE"), rs.getDate("LAST_LOGIN"), rs.getString("PASS_ENCRYPTED"), rs.getString("PASS_SALT"), rs.getString("USER_ROLE")));
//            }
//        } catch (SQLException ex) {
//        }
//        return webUser;
//    }
    
    public void modRecord(WebUser webUser){
        String updateStr = "UPDATE " + tableName + " SET USERNAME = ?, REAL_NAME = ?, PHONE = ?, EMAIL = ?, EMAIL_VERIFYSTATUS = ?, DATE_JOINED = ?, LAST_UPDATE = ?, LAST_LOGIN = ?, PASS_ENCRYPTED = ?, PASS_SALT = ?, USER_ROLE = ? WHERE USER_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, webUser.getUsername());
            stmt.setString(2, webUser.getRealName());
            stmt.setString(3, webUser.getPhone());
            stmt.setString(4, webUser.getEmail());
            stmt.setBoolean(5, webUser.getEmailVerify());
            stmt.setDate(6, webUser.getDateJoin());
            stmt.setTimestamp(7, webUser.getLastUpdate());
            stmt.setTimestamp(8, webUser.getLastLogin());
            stmt.setString(9, webUser.getPass());
            stmt.setString(10, webUser.getPassSalt());
            stmt.setString(11, webUser.getRole());
            stmt.setInt(12, webUser.getId());
            stmt.executeUpdate();
        }
        catch(SQLException ex){
        }
    }
    
    public void delRecord(int id){
        String deleteStr = "DELETE FROM " + tableName + " WHERE USER_ID = ?";
        try{                     
                    stmt = conn.prepareStatement(deleteStr);
                    stmt.setInt(1, id);
                    stmt.executeUpdate();                      
        }
        catch(SQLException ex){
        }
    }
   
    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
            }
        }
    }

}
