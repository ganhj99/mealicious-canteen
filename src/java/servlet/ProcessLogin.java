/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import control.MaintainStaffControl;
import control.MaintainWebUserControl;
import domain.PasswordUtils;
import domain.Staff;
import domain.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebServlet(name = "ProcessLogin", urlPatterns = {"/servlet/ProcessLogin"})
public class ProcessLogin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try{
            HttpSession session = request.getSession();
            String userRole = request.getParameter("userRole");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            MaintainWebUserControl webUserControl = new MaintainWebUserControl();
            MaintainStaffControl staffControl = new MaintainStaffControl();
            WebUser webUser = webUserControl.selectRecordWithUsername(username);
            String redirectURI;
            
            if(webUser != null){
                boolean passwordIsValid = PasswordUtils.validatePassword(password, 
                        webUser.getPass(), webUser.getPassSalt());
                boolean userRoleIsValid = userRole.equalsIgnoreCase(webUser.getRole());
                if(passwordIsValid && userRoleIsValid){ // Password Matched & User Role Matched
                    redirectURI =  "../portal/dashboard.jsp?msg=welcome";
                    //response.sendRedirect("../portal/dashboard.jsp"); //CHANGE TO DASHBOARD
                    session.setAttribute("currentUserId", webUser.getId());
                    session.setAttribute("currentUsername", webUser.getUsername());
                    session.setAttribute("currentUserRole", userRole);
                    if ("Staff".equalsIgnoreCase(userRole)){
                        Staff staff = staffControl.selectRecord(webUser.getId());
                        session.setAttribute("currentStaffPost", staff.getPosition());
                    } 
                    long millis=System.currentTimeMillis();  
                    Timestamp lastLogin  = new Timestamp(millis);
                    webUserControl.updateLastLogin(webUser.getId(), lastLogin);
                } else { // Password Not Matched
                    redirectURI = request.getContextPath() +  "/portal/login.jsp?msg=invalidLogin";
                }
            } else {
                redirectURI = request.getContextPath() + "/portal/login.jsp?msg=invalidLogin";
            }
            
            response.sendRedirect(redirectURI);
        } catch (Exception ex){
            out.println(ex);
        }
            
    }

}
