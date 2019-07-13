
package domain;

import java.io.Serializable;
import java.sql.*;
import java.util.Objects;

public class Student implements Serializable {
    private String id;
    private int cpBalance;
    private WebUser webUser;

    public Student() {
    }

    public Student(String id, int cpBalance, WebUser webUser) {
        this.id = id;
        this.cpBalance = cpBalance;
        this.webUser = webUser;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getCpBalance() {
        return cpBalance;
    }

    public void setCpBalance(int cpBalance) {
        this.cpBalance = cpBalance;
    }

    public WebUser getWebUser() {
        return webUser;
    }

    public void setWebUser(WebUser webUser) {
        this.webUser = webUser;
    }
    
    public int reloadCreditPoint(int topupAmt){
        return this.cpBalance += topupAmt;
    }
    
    public int deductCreditPoint(int deductAmt){
        if (deductAmt <= this.cpBalance){
            return this.cpBalance -= deductAmt;
        } else {
            return 0; //Return 0 means failed to deduct credit point
        }
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
        final Student other = (Student) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }   
    
}
