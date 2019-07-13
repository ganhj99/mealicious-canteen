
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;


public class CartDetail implements Serializable {
    private Cart cart;
    private Meal meal;
    private String session;
    private int qtt;
    private int cp;
    private Date dateOrder;

    public CartDetail() {
    }

    public CartDetail(Cart cart, Meal meal, String session, int qtt, int cp, Date dateOrder) {
        this.cart = cart;
        this.meal = meal;
        this.session = session;
        this.qtt = qtt;
        this.cp = cp;
        this.dateOrder = dateOrder;
    }

    public Date getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(Date dateOrder) {
        this.dateOrder = dateOrder;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public Meal getMeal() {
        return meal;
    }

    public void setMeal(Meal meal) {
        this.meal = meal;
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

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.cart);
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
        final CartDetail other = (CartDetail) obj;
        if (!Objects.equals(this.cart, other.cart)) {
            return false;
        }
        return true;
    }   
    
}
