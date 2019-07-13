/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@WebServlet(name = "UploadImage", urlPatterns = {"/servlet/UploadImage"})
@MultipartConfig(maxFileSize = 16177216)
public class UploadImage extends HttpServlet {

    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String connectionURL = "jdbc:derby://localhost:1527/mealiciousDB";
                String user = "nbuser";
                String pass = "nbuser";
 
		int result = 0;
		Connection con = null;
                int mid = Integer.parseInt(req.getParameter("mealID"));
		Part part = req.getPart("image");
 
		if(part != null){
			try{
                            Class.forName("org.apache.derby.jdbc.ClientDriver");
			    con = DriverManager.getConnection(connectionURL, user, pass);
			    PreparedStatement ps = con.prepareStatement("UPDATE NBUSER.MEAL SET MEAL_IMAGE = ? WHERE MEAL_ID = ?");
			    InputStream is = part.getInputStream();
                            ps.setBlob(1, is);
			    ps.setInt(2, mid);
			    result = ps.executeUpdate();
			}
			catch(Exception e){
				e.printStackTrace();
			}	
			finally{
				if(con != null){
					try{
						con.close();
					}
					catch(Exception e){
						e.printStackTrace();
					}
				}
			}
		}
		
		if(result > 0){
	    	resp.sendRedirect("../mealManagement/mealList.jsp");
                }
		else{
			resp.sendRedirect("../result.jsp?message=Some+Error+Occurred");
		}
	}
}
