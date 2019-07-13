/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import da.StaffDA;
import domain.Staff;
import java.sql.Date;
import java.util.ArrayList;

public class MaintainStaffControl {
    private StaffDA staffDA;

    public MaintainStaffControl() {
        staffDA = new StaffDA();
    }

    public Staff selectRecord(int id) { //By Userid
        return staffDA.getRecord(id);
    }
    
    public Staff selectRecordByStaffId(int staffId) {
        return staffDA.getRecordByStaffId(staffId);
    }
    
    public ArrayList<Staff> retrieveAllRecord(){
        return staffDA.getAllStaff();
    }
    
    public void insertRecord(Staff staff) {
        staffDA.addRecord(staff);
    }
    
    public void updatePosition(int id, String position) {
        Staff staff = selectRecord(id);
        staff.setPosition(position);
        staffDA.modRecord(staff);
    }
    
    public void updateStatus(int id, String status){ // Update status without changing DateEnd
        Staff staff = selectRecord(id);
        staff.setStatus(status);
        staffDA.modRecord(staff);
    }
    
    public void updateStatus(int id, String status, Date dateEnd){ // Update status and DateEnd
        Staff staff = selectRecord(id);
        staff.setStatus(status);
        staff.setDateEnd(dateEnd);
        staffDA.modRecord(staff);
    }
    
}
