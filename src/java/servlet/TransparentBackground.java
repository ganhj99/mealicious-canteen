/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.awt.image.BufferedImage;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author USER
 */
@WebServlet(name = "TransparentBackground", urlPatterns = {"/servlet/TransparentBackground"})
public class TransparentBackground extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //PrintWriter out = response.getWriter();
        //out.println(request.getParameter("url"));
        URL url = new URL(request.getParameter("url"));
        BufferedImage bImage = ImageIO.read(url);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(bImage, "png", bos );
        byte [] data = bos.toByteArray();
        ServletOutputStream responseOutputStream = response.getOutputStream();
        response.setContentType("image/png");
        responseOutputStream.write(data);
        responseOutputStream.flush();
        responseOutputStream.close();
    }

}
