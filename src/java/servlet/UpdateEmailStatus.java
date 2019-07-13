/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import control.MaintainWebUserControl;
import domain.JWTUtils;
import domain.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import io.jsonwebtoken.Claims;

/**
 *
 * @author USER
 */
public class UpdateEmailStatus extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Claims claims = null;
        try{
            String jwt = request.getParameter("jwt");
            claims = JWTUtils.decodeJWT(jwt);
            
            if(validateJWTEmailVerify(claims)){
                response.sendRedirect("../messagePage/infoMessage.jsp?msgType=Success&msgTitle=Email%20Verification%20Successful&msgBody1=Congratulations,%20you%20have%20successfully%20verified%20your%20ownership%20of%20&msgBody2=" + claims.get("email", String.class));
            } else {
                response.sendRedirect("../messagePage/infoMessage.jsp?msgType=Error&msgTitle=Email%20Verification%20Failed&msgBody1=Sorry, we could not verify your email as the verification link is expired or invalid.");
            }
        
        } catch (Exception ex){
            response.sendRedirect("../messagePage/infoMessage.jsp?msgType=Error&msgTitle=Email%20Verification%20Failed&msgBody1=Sorry, we could not verify your email as the verification link is invalid or expired.");
        }
    }
    
    private boolean validateJWTEmailVerify(Claims claims){
        boolean status = false;
        Date issuedAt = claims.getIssuedAt();
        String subject = claims.getSubject();
        Integer userId = Integer.parseInt(claims.getId());
        String username = claims.get("username", String.class);
        String email = claims.get("email", String.class);
        String encryptedPass = claims.get("encryptedPass", String.class);
        Date expDate = claims.getExpiration();
        Date timeNow = new Date();
        
        //Use userId to search for a particular WebUser in database
        MaintainWebUserControl webUserControl = new MaintainWebUserControl();
        WebUser webUser = webUserControl.selectRecordWithUserId(userId);
        
        //Check all available attribute is matched with database
        boolean isValidAccount = username.equals(webUser.getUsername()) &&
                                 email.equalsIgnoreCase(webUser.getEmail()) &&
                                 "NoEncryptedPass".equalsIgnoreCase(encryptedPass);
        
        //Check the expiration time (1hour)
        boolean isValidTime = expDate.after(timeNow);
        
        if ("verifyEmail".equals(subject) && isValidAccount && isValidTime){
            webUserControl.updateEmailAndStatus(webUser.getId(), email, true); // Update email to VERIFIED status
            status = true;
        } 
        return status;
    }
    

}
