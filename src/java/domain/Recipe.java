package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class Recipe implements Serializable {
    private Meal meal;
    private Ingredient ingredient;
    private double size;
    private String unit;

    public Recipe() {
    }

    public Recipe(Meal meal, Ingredient ingredient, double size, String unit) {
        this.meal = meal;
        this.ingredient = ingredient;
        this.size = size;
        this.unit = unit;
    }

    public Meal getMeal() {
        return meal;
    }

    public void setMeal(Meal meal) {
        this.meal = meal;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
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
        hash = 53 * hash + Objects.hashCode(this.meal);
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
        final Recipe other = (Recipe) obj;
        if (!Objects.equals(this.meal, other.meal)) {
            return false;
        }
        return true;
    }   
    
}
