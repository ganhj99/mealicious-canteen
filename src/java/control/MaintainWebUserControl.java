/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import da.WebUserDA;
import domain.WebUser;
import java.sql.Timestamp;
import java.util.ArrayList;

public class MaintainWebUserControl {
    private WebUserDA webUserDA;

    public MaintainWebUserControl() {
        webUserDA = new WebUserDA();
    }

    public WebUser selectRecordWithUserId(int id) {
        return webUserDA.getRecord(id);
    }
    
    public WebUser selectRecordWithUsername(String username) {
        return webUserDA.getRecordByUsername(username);
    }
    
    public WebUser selectRecordWithEmail(String email) {
        return webUserDA.getRecordByEmail(email);
    }
    
    public WebUser selectRecordWithUsernameAndEmail(String username, String email) {
        return webUserDA.getRecord(username, email);
    }
    
    public ArrayList<WebUser> retrieveAllRecord(){
        return webUserDA.getAllWebUser();
    }
    
    public void insertRecord(WebUser webUser) {
        webUserDA.addRecord(webUser);
    }
    
    public void updatePhone(int id, String phone) {
        WebUser webUser = selectRecordWithUserId(id);
        webUser.setPhone(phone);
        webUserDA.modRecord(webUser);
    }
    
    public void updateEmailAndStatus(int id, String email, boolean verifyStatus){
        WebUser webUser = selectRecordWithUserId(id);
        webUser.setEmail(email);
        webUser.setEmailVerify(verifyStatus);
        webUserDA.modRecord(webUser);
    }
    
    public void updatePassword(int id, String passEncrypted, String passSalt){
        WebUser webUser = selectRecordWithUserId(id);
        webUser.setPass(passEncrypted);
        webUser.setPassSalt(passSalt);
        webUserDA.modRecord(webUser);
    }
    
    public void updateLastLogin(int id, Timestamp lastLoginTime){
        WebUser webUser = selectRecordWithUserId(id);
        webUser.setLastLogin(lastLoginTime);
        webUserDA.modRecord(webUser);
    }
    
    public void updateLastUpdate(int id, Timestamp lastUpdateTime){
        WebUser webUser = selectRecordWithUserId(id);
        webUser.setLastUpdate(lastUpdateTime);
        webUserDA.modRecord(webUser);
    }
}
