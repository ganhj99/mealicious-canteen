package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;

public class TopupDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"TOPUP\"";
    private Connection conn;
    private PreparedStatement stmt;
    private StudentDA studentDA = new StudentDA();
    private StaffDA staffDA = new StaffDA();

    public TopupDA() {
        createConnection();
    }
    
    public Topup getRecord(int id) { 
        String queryStr = "SELECT * FROM " + tableName + " WHERE TOPUP_ID = ?";
        Topup topup = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Student student = studentDA.getRecordByStudId(rs.getString("TOPUP_STUD"));
                Staff staff = staffDA.getRecordByStaffId(rs.getInt("TOPUP_STAFF"));
                topup = new Topup(rs.getInt("TOPUP_ID"), rs.getTimestamp("TOPUP_DATE"), rs.getInt("TOPUP_AMT"), student, staff);
            }
        } catch (SQLException ex) {
        }
        return topup;
    }
    
    public void addRecord(Topup topup) {
        String insertStr = "INSERT INTO " + tableName + "(TOPUP_DATE, TOPUP_AMT, TOPUP_STUD, TOPUP_STAFF) VALUES(?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setTimestamp(1, topup.getTopupDate());
            stmt.setInt(2, topup.getTopupAmt());
            stmt.setString(3, topup.getStudent().getId());
            stmt.setInt(4, topup.getStaff().getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<Topup> getAllTopup() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Topup> topupList = new ArrayList<Topup>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Student student = studentDA.getRecordByStudId(rs.getString("TOPUP_STUD"));
                Staff staff = staffDA.getRecordByStaffId(rs.getInt("TOPUP_STAFF"));
                topupList.add(new Topup(rs.getInt("TOPUP_ID"), rs.getTimestamp("TOPUP_DATE"), rs.getInt("TOPUP_AMT"), student, staff));
            }
        } catch (SQLException ex) {
        }
        
        return topupList;
    }
    
    public ArrayList<Topup> getAllTodayRecord(Timestamp todayDate) {/////////////
        String queryStr = "SELECT * FROM " + tableName + " WHERE DATE(TOPUP_DATE) = ?";
        ArrayList<Topup> topupList = new ArrayList<Topup>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setTimestamp(1, todayDate);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Student student = studentDA.getRecordByStudId(rs.getString("TOPUP_STUD"));
                Staff staff = staffDA.getRecordByStaffId(rs.getInt("TOPUP_STAFF"));
                topupList.add(new Topup(rs.getInt("TOPUP_ID"), rs.getTimestamp("TOPUP_DATE"), rs.getInt("TOPUP_AMT"), student, staff));
            }
        } catch (SQLException ex) {
        }
        
        return topupList;
    }
   
    
    public ArrayList<Topup> getAllMonthRecordForStud(String studId, String month, String year) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE TOPUP_STUD = ? AND MONTH(TOPUP_DATE) = ? AND YEAR(TOPUP_DATE) = ?";
        ArrayList<Topup> topupList = new ArrayList<Topup>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studId);
            stmt.setString(2, month);
            stmt.setString(3, year);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Student student = studentDA.getRecordByStudId(rs.getString("TOPUP_STUD"));
                Staff staff = staffDA.getRecordByStaffId(rs.getInt("TOPUP_STAFF"));
                topupList.add(new Topup(rs.getInt("TOPUP_ID"), rs.getTimestamp("TOPUP_DATE"), rs.getInt("TOPUP_AMT"), student, staff));
            }
        } catch (SQLException ex) {
        }
        
        return topupList;
    }
    
    public ArrayList<Topup> getAllMonthRecordForStaff(String month, String year) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE MONTH(TOPUP_DATE) = ? AND YEAR(TOPUP_DATE) = ?";
        ArrayList<Topup> topupList = new ArrayList<Topup>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, month);
            stmt.setString(2, year);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Student student = studentDA.getRecordByStudId(rs.getString("TOPUP_STUD"));
                Staff staff = staffDA.getRecordByStaffId(rs.getInt("TOPUP_STAFF"));
                topupList.add(new Topup(rs.getInt("TOPUP_ID"), rs.getTimestamp("TOPUP_DATE"), rs.getInt("TOPUP_AMT"), student, staff));
            }
        } catch (SQLException ex) {
        }
        
        return topupList;
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
