/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;

public class Topup implements Serializable{
    private int id;
    private Timestamp topupDate;
    private int topupAmt;
    private Student student;
    private Staff staff;

    public Topup() {
    }
    
    public Topup(Timestamp topupDate, int topupAmt, Student student, Staff staff) {
        this.topupDate = topupDate;
        this.topupAmt = topupAmt;
        this.student = student;
        this.staff = staff;
    }

    public Topup(int id, Timestamp topupDate, int topupAmt, Student student, Staff staff) {
        this.id = id;
        this.topupDate = topupDate;
        this.topupAmt = topupAmt;
        this.student = student;
        this.staff = staff;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getTopupDate() {
        return topupDate;
    }

    public void setTopupDate(Timestamp topupDate) {
        this.topupDate = topupDate;
    }

    public int getTopupAmt() {
        return topupAmt;
    }

    public void setTopupAmt(int topupAmt) {
        this.topupAmt = topupAmt;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
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
        final Topup other = (Topup) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
}
