package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class CartDetailDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"CART_DETAIL\"";
    private Connection conn;
    private PreparedStatement stmt;
    private CartDA cartDA = new CartDA();
    private MealDA mealDA = new MealDA();

    public CartDetailDA() {
        createConnection();
    }
    
    public void addRecord(CartDetail cartDetail) {
        String queryStr = "SELECT * FROM " + tableName;
        String updateStr = "UPDATE " + tableName + " SET QUANTITY = ? WHERE CART_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND ORDER_DATE = ?";
        ArrayList<CartDetail> cartAllDetail = new ArrayList<CartDetail>();
        String insertStr = "INSERT INTO NBUSER.CART_DETAIL (CART_ID, MEAL_ID, MEAL_SESSION, QUANTITY, UNIT_CREDITPTS, ORDER_DATE) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Cart cart =cartDA.getRecord(rs.getInt("CART_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                cartAllDetail.add(new CartDetail(cart, meal, rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getDate("ORDER_DATE")));
            }
            int conf = 0;
            for(int i=0;i<cartAllDetail.size();i++){
                if(cartDetail.getCart().getId()==cartAllDetail.get(i).getCart().getId() && cartDetail.getMeal().getId()==(cartAllDetail.get(i).getMeal().getId()) && cartDetail.getSession().equals(cartAllDetail.get(i).getSession()) && cartDetail.getDateOrder().equals(cartAllDetail.get(i).getDateOrder())){
                    try{            
                        stmt = conn.prepareStatement(updateStr);
                        stmt.setInt(1, cartDetail.getQtt() + cartAllDetail.get(i).getQtt());
                        stmt.setInt(2, cartDetail.getCart().getId());
                        stmt.setInt(3, cartDetail.getMeal().getId());
                        stmt.setString(4, cartDetail.getSession());
                        stmt.setDate(5, cartDetail.getDateOrder());
                        stmt.executeUpdate();           
                    }
                    catch(SQLException ex){
                        JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
                    }
                    conf = 1;
                }
            }
            
            if(conf==0){
            stmt = conn.prepareStatement(insertStr);
            stmt.setInt(1, cartDetail.getCart().getId());
            stmt.setInt(2, cartDetail.getMeal().getId());
            stmt.setString(3, cartDetail.getSession());
            stmt.setInt(4, cartDetail.getQtt());
            stmt.setInt(5, cartDetail.getCp());
            stmt.setDate(6, cartDetail.getDateOrder());
            stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public CartDetail getRecord(int id, int id2) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CART_ID = ? and MEAL_ID = ?";
        CartDetail cartDetail = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setInt(2, id2);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Cart cart =cartDA.getRecord(rs.getInt("CART_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                cartDetail = new CartDetail(cart, meal, rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getDate("ORDER_DATE"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return cartDetail;
    }
    
    public ArrayList<CartDetail> getCartDetails(int id) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE CART_ID = ?";
        ArrayList<CartDetail> cartDetail = new ArrayList<CartDetail>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Cart cart =cartDA.getRecord(rs.getInt("CART_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                cartDetail.add(new CartDetail(cart, meal, rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getDate("ORDER_DATE")));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return cartDetail;
    }
    
    public void delRecord(int cid, int mid, String ses, Date date){
        String deleteStr = "DELETE FROM " + tableName + " WHERE CART_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND ORDER_DATE = ?";
        try{                     
                    stmt = conn.prepareStatement(deleteStr);
                    stmt.setInt(1, cid);
                    stmt.setInt(2, mid);
                    stmt.setString(3, ses);
                    stmt.setDate(4, date);
                    stmt.executeUpdate();                      
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void delAll(int id){
        String deleteStr = "DELETE FROM " + tableName + " WHERE CART_ID = ?";
        try{                     
                    stmt = conn.prepareStatement(deleteStr);
                    stmt.setInt(1, id);
                    stmt.executeUpdate();                      
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modQtt(int qtt, int cid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET QUANTITY = ? WHERE CART_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND ORDER_DATE = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, qtt);
            stmt.setInt(2, cid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modDate(Date nd, int cid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET ORDER_DATE = ? WHERE CART_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND ORDER_DATE = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setDate(1, nd);
            stmt.setInt(2, cid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modSession(String nses, int cid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET MEAL_SESSION = ? WHERE CART_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND ORDER_DATE = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, nses);
            stmt.setInt(2, cid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
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
