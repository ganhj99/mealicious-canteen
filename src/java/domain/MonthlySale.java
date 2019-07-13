
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class MonthlySale implements Serializable {
    private String mealName;
    private int cp;
    private int qtt;
    private int ttl;

    public MonthlySale() {
    }

    public MonthlySale(String mealName, int cp, int qtt, int ttl) {
        this.mealName = mealName;
        this.cp = cp;
        this.qtt = qtt;
        this.ttl = ttl;
    }

    public int getTtl() {
        return ttl;
    }

    public void setTtl(int ttl) {
        this.ttl = ttl;
    }

    public String getMealName() {
        return mealName;
    }

    public void setMealName(String mealName) {
        this.mealName = mealName;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }

    public int getQtt() {
        return qtt;
    }

    public void setQtt(int qtt) {
        this.qtt = qtt;
    }

    
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.mealName);
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
        final MonthlySale other = (MonthlySale) obj;
        if (!Objects.equals(this.mealName, other.mealName)) {
            return false;
        }
        return true;
    }   
    
}
