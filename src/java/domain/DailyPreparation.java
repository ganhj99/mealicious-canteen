
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class DailyPreparation implements Serializable {
    private String mealName;
    private double size;
    private String unit;

    public DailyPreparation() {
    }

    public DailyPreparation(String mealName, double size, String unit) {
        this.mealName = mealName;
        this.size = size;
        this.unit = unit;
    }

    public String getMealName() {
        return mealName;
    }

    public void setMealName(String mealName) {
        this.mealName = mealName;
    }

    public double getSize() {
        return size;
    }

    public void setSize(double size) {
        this.size = size;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
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
        final DailyPreparation other = (DailyPreparation) obj;
        if (!Objects.equals(this.mealName, other.mealName)) {
            return false;
        }
        return true;
    }   
    
}
