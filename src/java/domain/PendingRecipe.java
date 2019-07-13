package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class PendingRecipe implements Serializable {
    private int id;
    private Ingredient ingredient;
    private double size;
    private String unit;

    public PendingRecipe() {
    }

    public PendingRecipe(Ingredient ingredient, double size, String unit) {
        this.ingredient = ingredient;
        this.size = size;
        this.unit = unit;
    }

    public PendingRecipe(int id, Ingredient ingredient, double size, String unit) {
        this.id = id;
        this.ingredient = ingredient;
        this.size = size;
        this.unit = unit;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
        final PendingRecipe other = (PendingRecipe) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
