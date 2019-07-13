/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import control.*;
import domain.PasswordUtils;
import domain.Student;
import domain.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author B1
 */
@WebServlet(name = "ValidateRegister", urlPatterns = {"/servlet/ValidateRegister"})
public class ValidateRegister extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        
            PrintWriter out = response.getWriter(); //TESTING

            String studentId = request.getParameter("studentId");
            String username = request.getParameter("username");
            String realName = request.getParameter("realName");
            String password = request.getParameter("password");
            String cfmPassword = request.getParameter("cfmPassword");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            
            int creditBalance = 0;
            out.println(studentId + username + realName + password + cfmPassword + phone + email);
            //Get webUser dateJoined
            //DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            long millis=System.currentTimeMillis();  
            Date dateNow = new Date(millis);
            //out.println(dateNow);
            out.println("*");
            if(studentId.isEmpty() || username.isEmpty() || realName.isEmpty() || 
                    phone.isEmpty() || email.isEmpty() || password.isEmpty() ||
                    cfmPassword.isEmpty() || !(password.equals(cfmPassword))){
                out.println("!");
                RequestDispatcher req = request.getRequestDispatcher("../portal/register.jsp?errMsg=1"); 
                req.include(request, response);
            } else {
                out.println(":");
                String passSalt = PasswordUtils.getSalt(30);
                String passEncrypted = PasswordUtils.generateEncryptedPassword(password, passSalt);
                WebUser webUser = new WebUser(username, realName, phone, email, false, dateNow, null, null, passEncrypted, passSalt, "Student"); // To be sent to database
                
                MaintainWebUserControl webUserControl = new MaintainWebUserControl();
                MaintainStudentControl studentControl = new MaintainStudentControl();
                
                webUserControl.insertRecord(webUser); // Add record, to generate id in database.
                webUser = webUserControl.selectRecordWithUsername(username); // Get webUser all attrb including database generated id
                
                Student stud = new Student(studentId, creditBalance, webUser); // Student all attrb including webUser's generated id
                studentControl.insertRecord(stud);
                out.println("!");
                response.sendRedirect("../portal/login.jsp?msg=registerSuccess");
            }
            out.println("outside");
            //out.println("Current Date : "+dateFormat.format(date));
        } catch (Exception ex){
        }
    }


}
