
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.*;

public class Order implements Serializable {
    private int id;
    private Timestamp dateOrder;
    private String status;
    private int ttlcp;
    private Student student;

    public Order() {
    }

    public Order(Timestamp dateOrder, String status, int ttlcp, Student student) {
        this.dateOrder = dateOrder;
        this.status = status;
        this.ttlcp = ttlcp;
        this.student = student;
    }

    public Order(int id, Timestamp dateOrder, String status, int ttlcp, Student student) {
        this.id = id;
        this.dateOrder = dateOrder;
        this.status = status;
        this.ttlcp = ttlcp;
        this.student = student;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(Timestamp dateOrder) {
        this.dateOrder = dateOrder;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTtlcp() {
        return ttlcp;
    }

    public void setTtlcp(int ttlcp) {
        this.ttlcp = ttlcp;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
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
        final Order other = (Order) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
