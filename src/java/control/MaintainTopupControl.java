/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import da.TopupDA;
import domain.Topup;
import java.util.ArrayList;
import java.sql.*;

public class MaintainTopupControl {
    private TopupDA topupDA;

    public MaintainTopupControl() {
        topupDA = new TopupDA();
    }

    public Topup selectRecord(int id) { //By TopupID
        return topupDA.getRecord(id);
    }
    
    public ArrayList<Topup> retrieveAllRecord(){
        return topupDA.getAllTopup();
    }
    
    public ArrayList<Topup> retrieveAllTodayRecord(Timestamp todayDate){
        return topupDA.getAllTodayRecord(todayDate);
    }
    
//    public ArrayList<Topup> retrieveAllTodayRecord(){
//        long millis = System.currentTimeMillis();  
//        Timestamp todayDate  = new Timestamp(millis);
//        return topupDA.getAllTodayRecord(todayDate)
//    }
    
    public ArrayList<Topup> retrieveAllMonthRecordForStud(String studId, String month, String year){
        return topupDA.getAllMonthRecordForStud(studId, month, year);
    }
    
    public ArrayList<Topup> retrieveAllMonthRecordForStaff(String month, String year){
        return topupDA.getAllMonthRecordForStaff(month, year);
    }
    
    public void insertRecord(Topup topup) {
        topupDA.addRecord(topup);
    }

    
}
