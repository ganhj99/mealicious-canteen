/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Logout", urlPatterns = {"/servlet/Logout"})
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
        
            String currentUserId = String.valueOf(session.getAttribute("currentUserId"));
            String currentUsername = (String) session.getAttribute("currentUsername");
            String currentUserRole = (String) session.getAttribute("currentUserRole");
            String currentStaffPost = null;
            if (session.getAttribute("currentStaffPost") != null){
                currentStaffPost = (String) session.getAttribute("currentStaffPost");
            }
            
            //restrict non-user access
            if (currentUserId == null && currentUsername == null && currentUserRole == null && currentStaffPost == null) { 
                response.sendRedirect("../portal/login.jsp"); 
            } 
        
            if (session != null) {
                session.setAttribute("currentUserId", null);
                session.setAttribute("currentUsername", null);
                session.setAttribute("currentUserRole", null);
                if (session.getAttribute("currentStaffPost") != null){
                    session.setAttribute("currentStaffPost", null);
                }
                session.invalidate();
            }
            response.sendRedirect("../portal/login.jsp?msg=logout");
        } catch (Exception ex){
            
        }
    }
}
