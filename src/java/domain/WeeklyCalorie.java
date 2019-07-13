
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;

public class WeeklyCalorie implements Serializable {
    private Date date;
    private double calorie;

    public WeeklyCalorie() {
    }

    public WeeklyCalorie(Date date, double calorie) {
        this.date = date;
        this.calorie = calorie;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getCalorie() {
        return calorie;
    }

    public void setCalorie(double calorie) {
        this.calorie = calorie;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.date);
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
        final WeeklyCalorie other = (WeeklyCalorie) obj;
        if (!Objects.equals(this.date, other.date)) {
            return false;
        }
        return true;
    }   
    
}
