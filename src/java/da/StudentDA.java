package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class StudentDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"STUDENT\"";
    private Connection conn;
    private PreparedStatement stmt;
    private WebUserDA webUserDA = new WebUserDA();

    public StudentDA() {
        createConnection();
    }
    
    public Student getRecord(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE USER_ID = ?";
        Student student = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                student = new Student(rs.getString("STUD_ID"), rs.getInt("CREDIT_BALANCE"), webUser);
            }
        } catch (SQLException ex) {
        }
        return student;
    }
    
    public Student getRecordByStudId(String studId) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE STUD_ID = ?";
        Student student = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                student = new Student(rs.getString("STUD_ID"), rs.getInt("CREDIT_BALANCE"), webUser);
            }
        } catch (SQLException ex) {
        }
        return student;
    }

    
    public void addRecord(Student student) {
        String insertStr = "INSERT INTO " + tableName + " (STUD_ID, CREDIT_BALANCE, USER_ID) VALUES(?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, student.getId());
            stmt.setInt(2, student.getCpBalance());
            stmt.setInt(3, student.getWebUser().getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
        }
    }
    
    public ArrayList<Student> getAllStudent() {
        String queryStr = "SELECT * FROM " + tableName;
        ArrayList<Student> studentList = new ArrayList<Student>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                WebUser webUser = webUserDA.getRecord(rs.getInt("USER_ID"));
                studentList.add(new Student(rs.getString("STUD_ID"), rs.getInt("CREDIT_BALANCE"), webUser));
            }
        } catch (SQLException ex) {
        }
        
        return studentList;
    }
    
    public void modRecord(Student student){
        String updateStr = "UPDATE " + tableName + " SET CREDIT_BALANCE = ?, USER_ID = ? WHERE STUD_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, student.getCpBalance());
            stmt.setInt(2, student.getWebUser().getId());
            stmt.setString(3, student.getId());
            stmt.executeUpdate();
        }
        catch(SQLException ex){
        }
    }
    
    public void modCP(int cp, String sid){
        String updateStr = "UPDATE " + tableName + " SET CREDIT_BALANCE = ? WHERE STUD_ID = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, cp);
            stmt.setString(2, sid);
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
