
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class Meal implements Serializable {
    private int id;
    private String name;
    private String desc;
    private String img;
    private int cp;
    private String status;
    private double calorie;
    private Category category;

    public Meal() {
    }

    public Meal(String name, String desc, String img, int cp, String status, double calorie, Category category) {
        this.name = name;
        this.desc = desc;
        this.img = img;
        this.cp = cp;
        this.status = status;
        this.calorie = calorie;
        this.category = category;
    }

    public Meal(String name, String desc, int cp, String status, double calorie, Category category) {
        this.name = name;
        this.desc = desc;
        this.cp = cp;
        this.status = status;
        this.calorie = calorie;
        this.category = category;
    }

    public Meal(int id, String name, String desc, String img, int cp, String status, double calorie, Category category) {
        this.id = id;
        this.name = name;
        this.desc = desc;
        this.img = img;
        this.cp = cp;
        this.status = status;
        this.calorie = calorie;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
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

    public double getCalorie() {
        return calorie;
    }

    public void setCalorie(double calorie) {
        this.calorie = calorie;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.id);
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
        final Meal other = (Meal) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
