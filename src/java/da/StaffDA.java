package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;

public class StaffDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"STAFF\"";
    private Connection conn;
    private PreparedStatement stmt;
    private WebUserDA webUserDA = new WebUserDA();

    public StaffDA() {
        createConnection();
    }
    
    public Staff getRecord(int id) { 
        String queryStr = "SELECT * FROM " + tableName + " WHERE USER_ID = ?";
        Staff staff = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                staff = new Staff(rs.getInt("STAFF_ID"), rs.getString("STAFF_POSITION"), rs.getString("STAFF_STATUS"), rs.getDate("START_DATE"), rs.getDate("END_DATE"), webUser);
            }
        } catch (SQLException ex) {
        }
        return staff;
    }
    
    public Staff getRecordByStaffId(int staffId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE STAFF_ID = ?";
        Staff staff = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                staff = new Staff(rs.getInt("STAFF_ID"), rs.getString("STAFF_POSITION"), rs.getString("STAFF_STATUS"), rs.getDate("START_DATE"), rs.getDate("END_DATE"), webUser);
            }
        } catch (SQLException ex) {
        }
        return staff;
    }
    
    public void addRecord(Staff staff) {
        String insertStr = "INSERT INTO NBUSER.STAFF(STAFF_POSITION, STAFF_STATUS, START_DATE, END_DATE, USER_ID) VALUES(?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, staff.getPosition());
            stmt.setString(2, staff.getStatus());
            stmt.setDate(3, staff.getDateStart());
            stmt.setDate(4, staff.getDateEnd());
            stmt.setInt(5, staff.getWebUser().getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<Staff> getAllStaff() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Staff> staffList = new ArrayList<Staff>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                staffList.add(new Staff(rs.getInt("STAFF_ID"), rs.getString("STAFF_POSITION"), rs.getString("STAFF_STATUS"), rs.getDate("START_DATE"), rs.getDate("END_DATE"), webUser));
            }
        } catch (SQLException ex) {
        }
        
        return staffList;
    }
    
    public void modRecord(Staff staff){
        String updateStr = "UPDATE " + tableName + " SET STAFF_POSITION = ?, STAFF_STATUS = ?, START_DATE = ?, END_DATE = ?, USER_ID = ? WHERE STAFF_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, staff.getPosition());
            stmt.setString(2, staff.getStatus());
            stmt.setDate(3, staff.getDateStart());
            stmt.setDate(4, staff.getDateEnd());
            stmt.setInt(5, staff.getWebUser().getId());
            stmt.setInt(6, staff.getId());
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
