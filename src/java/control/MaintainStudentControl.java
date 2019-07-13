/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import da.StudentDA;
import domain.Student;
import java.sql.Date;
import java.util.ArrayList;

public class MaintainStudentControl {
    private StudentDA studentDA;

    public MaintainStudentControl() {
        studentDA = new StudentDA();
    }

    public Student selectRecordByUserId(int id) {
        return studentDA.getRecord(id);
    }
    
    public Student selectRecordByStudId(String studId) {
        return studentDA.getRecordByStudId(studId);
    }
    
    public ArrayList<Student> retrieveAllRecord(){
        return studentDA.getAllStudent();
    }
    
    public void insertRecord(Student student) {
        studentDA.addRecord(student);
    }
    
    public void updateCreditBalance(String id, int creditBalance) {
        Student student = selectRecordByStudId(id);
        student.setCpBalance(creditBalance);
        studentDA.modRecord(student);
    }
    
}
