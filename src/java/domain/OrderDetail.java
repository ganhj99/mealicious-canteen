
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;

public class OrderDetail implements Serializable {
    private Order order;
    private Meal meal;
    private Date dateCollect;
    private String session;
    private int qtt;
    private int cp;
    private String status;
    private Timestamp redeem;
    private String coupon;

    public OrderDetail() {
    }

    public OrderDetail(Order order, Meal meal, Date dateCollect, String session, int qtt, int cp, String status, Timestamp redeem, String coupon) {
        this.order = order;
        this.meal = meal;
        this.dateCollect = dateCollect;
        this.session = session;
        this.qtt = qtt;
        this.cp = cp;
        this.status = status;
        this.redeem = redeem;
        this.coupon = coupon;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Meal getMeal() {
        return meal;
    }

    public void setMeal(Meal meal) {
        this.meal = meal;
    }

    public Date getDateCollect() {
        return dateCollect;
    }

    public void setDateCollect(Date dateCollect) {
        this.dateCollect = dateCollect;
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }

    public int getQtt() {
        return qtt;
    }

    public void setQtt(int qtt) {
        this.qtt = qtt;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRedeem() {
        return redeem;
    }

    public void setRedeem(Timestamp redeem) {
        this.redeem = redeem;
    }

    public String getCoupon() {
        return coupon;
    }

    public void setCoupon(String coupon) {
        this.coupon = coupon;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.order);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final OrderDetail other = (OrderDetail) obj;
        if (!Objects.equals(this.order, other.order)) {
            return false;
        }
        return true;
    }   
    
}
