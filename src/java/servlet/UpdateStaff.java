/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import control.MaintainStaffControl;
import domain.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class UpdateStaff extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try{
            Integer staffUserId = Integer.parseInt(request.getParameter("staffUserId"));
            Integer staffId = Integer.parseInt(request.getParameter("staffId"));
            String position = request.getParameter("position");
            String status = request.getParameter("status");
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            
            MaintainStaffControl staffControl = new MaintainStaffControl();
            Staff staff = staffControl.selectRecord(staffUserId);
            if(!staff.getPosition().equalsIgnoreCase(position)){
                staffControl.updatePosition(staffUserId, position);
            }
            if(!staff.getStatus().equalsIgnoreCase(status)){
                if("Active".equalsIgnoreCase(status)){
                    staffControl.updateStatus(staffUserId, status);
                } else if("Quit".equalsIgnoreCase(status)){
                    staffControl.updateStatus(staffUserId, status, endDate);
                }
            }
            
        } catch (Exception ex){
            out.println(ex);
        }
    }
}
