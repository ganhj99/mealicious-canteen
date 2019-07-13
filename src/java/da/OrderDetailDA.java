package da;

import domain.*;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.*;

public class OrderDetailDA {

    private String host = "jdbc:derby://localhost:1527/mealiciousDB";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "NBUSER.\"ORDER_DETAIL\"";
    private Connection conn;
    private PreparedStatement stmt;
    private OrderDA orderDA = new OrderDA();
    private MealDA mealDA = new MealDA();

    public OrderDetailDA() {
        createConnection();
    }
    
    public void addRecord(CartDetail cartDetail, int id, Timestamp ts, String coupon) {
        String insertStr = "INSERT INTO NBUSER.ORDER_DETAIL (ORDER_ID, MEAL_ID, MEAL_COLLECTDATE, MEAL_SESSION, QUANTITY, UNIT_CREDITPTS, ORDERMEAL_STATUS, REDEEM_TIME, COUPON_CODE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setInt(1, id);
            stmt.setInt(2, cartDetail.getMeal().getId());
            stmt.setDate(3, cartDetail.getDateOrder());
            stmt.setString(4, cartDetail.getSession());
            stmt.setInt(5, cartDetail.getQtt());
            stmt.setInt(6, cartDetail.getCp());
            stmt.setString(7, "Pending");
            stmt.setTimestamp(8, ts);
            stmt.setString(9, coupon);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void addNewRecord(OrderDetail orderDetail, String studid, Date date, Date date2) {
        String queryStr = "SELECT OD.* FROM MEAL_ORDER MO, ORDER_DETAIL OD WHERE MO.ORDER_STATUS = 'Success' AND OD.ORDERMEAL_STATUS <> 'Cancel' AND MO.ORDER_ID = OD.ORDER_ID AND MO.ORDER_STUD = ? AND MEAL_COLLECTDATE BETWEEN ? AND ?";
        String updateStr = "UPDATE " + tableName + " SET QUANTITY = ? WHERE ORDER_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        ArrayList<OrderDetail> orderAllDetail = new ArrayList<OrderDetail>();
        String insertStr = "INSERT INTO NBUSER.ORDER_DETAIL (ORDER_ID, MEAL_ID, MEAL_COLLECTDATE, MEAL_SESSION, QUANTITY, UNIT_CREDITPTS, ORDERMEAL_STATUS, REDEEM_TIME, COUPON_CODE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studid);
            stmt.setDate(2, date);
            stmt.setDate(3, date2);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderAllDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
            int conf = 0;
            for(int i=0;i<orderAllDetail.size();i++){
                if(orderDetail.getOrder().getId()==orderAllDetail.get(i).getOrder().getId() && orderDetail.getMeal().getId()==(orderAllDetail.get(i).getMeal().getId()) && orderDetail.getSession().equals(orderAllDetail.get(i).getSession()) && orderDetail.getDateCollect().equals(orderAllDetail.get(i).getDateCollect())){
                    try{            
                        stmt = conn.prepareStatement(updateStr);
                        stmt.setInt(1, orderDetail.getQtt() + orderAllDetail.get(i).getQtt());
                        stmt.setInt(2, orderDetail.getOrder().getId());
                        stmt.setInt(3, orderDetail.getMeal().getId());
                        stmt.setString(4, orderDetail.getSession());
                        stmt.setDate(5, orderDetail.getDateCollect());
                        stmt.setString(6, "Pending");
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
            stmt.setInt(1, orderDetail.getOrder().getId());
            stmt.setInt(2, orderDetail.getMeal().getId());
            stmt.setDate(3, orderDetail.getDateCollect());
            stmt.setString(4, orderDetail.getSession());
            stmt.setInt(5, orderDetail.getQtt());
            stmt.setInt(6, orderDetail.getCp());
            stmt.setString(7, orderDetail.getStatus());
            stmt.setTimestamp(8, orderDetail.getRedeem());
            stmt.setString(9, orderDetail.getCoupon());
            stmt.executeUpdate();
            }
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public OrderDetail getRecord(int id, int id2) {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ORDER_ID = ? and MEAL_ID = ?";
        OrderDetail orderDetail = null;
        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setInt(1, id);
            stmt.setInt(2, id2);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order =orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail = new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }
    
    public ArrayList<OrderDetail> getAllOrder(int oid){
        String q = "SELECT * FROM " + tableName + " WHERE ORDER_ID = ?";
        ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setInt(1, oid);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(oid);
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
        }catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }
    
    public ArrayList<OrderDetail> getOrderDetailByDate(String studid, Date date, Date date2) {
        String queryStr = "SELECT OD.* FROM MEAL_ORDER MO, ORDER_DETAIL OD WHERE MO.ORDER_STATUS = 'Success' AND OD.ORDERMEAL_STATUS <> 'Cancel' AND MO.ORDER_ID = OD.ORDER_ID AND MO.ORDER_STUD = ? AND MEAL_COLLECTDATE BETWEEN ? AND ?";
        ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
        try {       
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, studid);
            stmt.setDate(2, date);
            stmt.setDate(3, date2);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }
    
    public ArrayList<OrderDetail> getAllOrderByDateAndStudIdAndStatus(Date collectDate, String studId, String orderStatus){/////////
        String q = "SELECT * FROM " + tableName + " OD, NBUSER.\"MEAL_ORDER\" MO" + " WHERE OD.ORDER_ID = MO.ORDER_ID AND OD.MEAL_COLLECTDATE = ? AND MO.ORDER_STUD = ? AND MO.ORDER_STATUS = ?";
        ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setDate(1, collectDate);
            stmt.setString(2, studId);
            stmt.setString(3, orderStatus);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
        }catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }

    public ArrayList<OrderDetail> getAllOrderByDateAndStatus(Date collectDate, String redeemStatus){
        String q = "SELECT * FROM " + tableName + " OD, NBUSER.\"MEAL_ORDER\" MO " + " WHERE OD.ORDER_ID = MO.ORDER_ID AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setDate(1, collectDate);
            stmt.setString(2, redeemStatus);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
        }catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }
    
    public ArrayList<OrderDetail> getAllMonthOrderByMeal(String month, String year, String mealId){
        String q = "SELECT * FROM " + tableName + " OD, NBUSER.\"MEAL_ORDER\" MO" + " WHERE MONTH(MEAL_COLLECTDATE) = ? AND YEAR(MEAL_COLLECTDATE) = ? AND MEAL_ID = ?";
        ArrayList<OrderDetail> orderDetail = new ArrayList<OrderDetail>();
        try{
            stmt = conn.prepareStatement(q);
            stmt.setString(1, month);
            stmt.setString(2, year);
            stmt.setString(3, mealId);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                Order order = orderDA.getRecord(rs.getInt("ORDER_ID"));
                Meal meal = mealDA.getRecord(rs.getInt("MEAL_ID"));
                orderDetail.add(new OrderDetail(order, meal, rs.getDate("MEAL_COLLECTDATE"), rs.getString("MEAL_SESSION"), rs.getInt("QUANTITY"), rs.getInt("UNIT_CREDITPTS"), rs.getString("ORDERMEAL_STATUS"), rs.getTimestamp("REDEEM_TIME"), rs.getString("COUPON_CODE")));
            }
        }catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return orderDetail;
    }

    public void modQtt(int qtt, int oid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET QUANTITY = ? WHERE ORDER_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, qtt);
            stmt.setInt(2, oid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.setString(6, "Pending");
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modDate(Date nd, int oid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET MEAL_COLLECTDATE = ? WHERE ORDER_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setDate(1, nd);
            stmt.setInt(2, oid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.setString(6, "Pending");
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modSession(String nses, int oid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET MEAL_SESSION = ? WHERE ORDER_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, nses);
            stmt.setInt(2, oid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.setString(6, "Pending");
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modStatus(String nstt, int oid, int mid, String ses, Date date){
        String updateStr = "UPDATE " + tableName + " SET ORDERMEAL_STATUS = ? WHERE ORDER_ID = ? AND MEAL_ID = ? AND MEAL_SESSION = ? AND MEAL_COLLECTDATE = ? AND ORDERMEAL_STATUS = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, nstt);
            stmt.setInt(2, oid);
            stmt.setInt(3, mid);
            stmt.setString(4, ses);
            stmt.setDate(5, date);
            stmt.setString(6, "Pending");
            stmt.executeUpdate();           
        }
        catch(SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void modStatusByCoupon(String couponCode, Timestamp redeemTime, String redeemStatus){
        String updateStr = "UPDATE " + tableName + " SET ORDERMEAL_STATUS = ?, REDEEM_TIME = ? WHERE COUPON_CODE = ?";
        try{            
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, redeemStatus);
            stmt.setTimestamp(2, redeemTime);
            stmt.setString(3, couponCode);
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
