/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import da.WebUserDA;
import domain.JWTUtils;
import domain.SendMail;
import domain.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author B1
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/servlet/ResetPassword"})
public class ResetPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try{
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            WebUserDA webUserDA = new WebUserDA();
            WebUser webUser = webUserDA.getRecord(username, email);
            int userId = webUser.getId();

            if(webUser != null){
                String dbUsername = webUser.getUsername();
                String dbEmail = webUser.getEmail();
                
                boolean validUsername = username.equalsIgnoreCase(dbUsername);
                boolean validEmail = email.equalsIgnoreCase(dbEmail);
                
                if (validUsername && validEmail){
                    String jwt = JWTUtils.createJWT("forgetPassword", userId, email, username, webUser.getPass(), 3600000); //3600000ms = 1 hour
                    response.sendRedirect("../messagePage/infoMessage.jsp?msgType=Success&msgTitle=Email%20Sent%20Successful&msgBody1=Great,%20we%20have%20successfully%20sent%20the%20instructions%20on%20how%20to%20reset%20your%20password%20to%20&msgBody2=" + email);
                    String msgInHtmlForm = 
                        "<h1>Mealicious</h1>" +
                        "<p><b>Forgot your password?</b></p>" +
                        "<p>Seems like you forgot your password for Mealicious. If this is true, click below to reset your password.</p>" +
                        "<p>Please follow this link to reset your password: "
                            + "<a href='" + request.getServerName() + request.getContextPath() + "/portal/authForgotPassword.jsp?jwt=" + jwt + "'>Reset password</a><p>" +
                        "<p>If you did not forgot your password, you can safely ignore this email.<p>";
                    
                    SendMail.send(email, "Forget Password", msgInHtmlForm);
                } else {
                    response.sendRedirect("../portal/forgetPassword.jsp?msg=invalid");
                }
            } else {
                response.sendRedirect("../portal/forgetPassword.jsp?msg=invalid");
                
            }
        } catch (Exception ex){
            out.print(ex.getMessage());
        } 
    }


}
