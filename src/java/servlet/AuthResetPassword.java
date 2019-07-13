/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import control.MaintainWebUserControl;
import domain.PasswordUtils;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
@WebServlet(name = "AuthResetPassword", urlPatterns = {"/servlet/AuthResetPassword"})
public class AuthResetPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try{
            int userId = Integer.parseInt(request.getParameter("userId"));
            String newPassword = request.getParameter("password");
            String newCfmPassword = request.getParameter("cfmPassword");

            MaintainWebUserControl webUserControl = new MaintainWebUserControl();

            //Generating salt & encrypted password
            if (newPassword.equals(newCfmPassword)){
                String passSalt = PasswordUtils.getSalt(30);
                String encryptedPass = PasswordUtils.generateEncryptedPassword(newPassword, passSalt); 
                
                //Update to database using Control
                webUserControl.updatePassword(userId, encryptedPass, passSalt);
                response.sendRedirect("../portal/login.jsp?msg=resetPassSuccess");
            } else {
                out.println("Error!");
            }
        } catch (Exception ex){
            out.println(ex.getMessage());
        }
    }
}
