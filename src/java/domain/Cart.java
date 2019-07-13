
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;
import java.util.*;

public class Cart implements Serializable {
    private int id;
    private Student stud;

    public Cart() {
    }

    public Cart(Student stud) {
        this.stud = stud;
    }

    public Cart(int id, Student stud) {
        this.id = id;
        this.stud = stud;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Student getStud() {
        return stud;
    }

    public void setStud(Student stud) {
        this.stud = stud;
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
        final Cart other = (Cart) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
