
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class Ingredient implements Serializable {
    private int id;
    private String name;
    private double fat;
    private double carb;
    private double protein;
    private double size;
    private String unit;

    public Ingredient() {
    }

    public Ingredient(String name, double fat, double carb, double protein, double size, String unit) {
        this.name = name;
        this.fat = fat;
        this.carb = carb;
        this.protein = protein;
        this.size = size;
        this.unit = unit;
    }

    public Ingredient(int id, String name, double fat, double carb, double protein, double size, String unit) {
        this.id = id;
        this.name = name;
        this.fat = fat;
        this.carb = carb;
        this.protein = protein;
        this.size = size;
        this.unit = unit;
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

    public double getFat() {
        return fat;
    }

    public void setFat(double fat) {
        this.fat = fat;
    }

    public double getCarb() {
        return carb;
    }

    public void setCarb(double carb) {
        this.carb = carb;
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
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
    
    public double calCalorie(){
        return (fat * 9) + (carb * 4) + (protein * 4);
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
        final Ingredient other = (Ingredient) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
