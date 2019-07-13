/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;
/**
 *
 * @author B1
 */
public class WebUser implements Serializable {
    private int id;
    private String username;
    private String realName;
    private String phone;
    private String email;
    private boolean emailVerify;
    private Date dateJoin;
    private Timestamp lastUpdate;
    private Timestamp lastLogin;
    private String pass;
    private String passSalt;
    private String role;

    public WebUser() {
    }

    public WebUser(String username, String realName, String phone, String email, boolean emailVerify, Date dateJoin, Timestamp lastUpdate, Timestamp lastLogin, String pass, String passSalt, String role) {
        this.username = username;
        this.realName = realName;
        this.phone = phone;
        this.email = email;
        this.emailVerify = emailVerify;
        this.dateJoin = dateJoin;
        this.lastUpdate = lastUpdate;
        this.lastLogin = lastLogin;
        this.pass = pass;
        this.passSalt = passSalt;
        this.role = role;
    }

    public WebUser(int id, String username, String realName, String phone, String email, boolean emailVerify, Date dateJoin, Timestamp lastUpdate, Timestamp lastLogin, String pass, String passSalt, String role) {
        this.id = id;
        this.username = username;
        this.realName = realName;
        this.phone = phone;
        this.email = email;
        this.emailVerify = emailVerify;
        this.dateJoin = dateJoin;
        this.lastUpdate = lastUpdate;
        this.lastLogin = lastLogin;
        this.pass = pass;
        this.passSalt = passSalt;
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean getEmailVerify() {
        return emailVerify;
    }

    public void setEmailVerify(boolean emailVerify) {
        this.emailVerify = emailVerify;
    }

    public Date getDateJoin() {
        return dateJoin;
    }

    public void setDateJoin(Date dateJoin) {
        this.dateJoin = dateJoin;
    }

    public Timestamp getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Timestamp lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getPassSalt() {
        return passSalt;
    }

    public void setPassSalt(String passSalt) {
        this.passSalt = passSalt;
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
        final WebUser other = (WebUser) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}

