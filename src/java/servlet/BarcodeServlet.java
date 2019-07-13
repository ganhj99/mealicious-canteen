/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.krysalis.barcode4j.impl.code128.Code128Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;

@WebServlet(name = "BarcodeServlet", urlPatterns = {"/servlet/BarcodeServlet"})
public class BarcodeServlet extends HttpServlet { 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String value=request.getParameter("code");
            response.setContentType("image/png");
            Code128Bean code128 = new Code128Bean();

            code128.setHeight(15f);
            code128.setModuleWidth(0.3);
            code128.setQuietZone(10);
            code128.doQuietZone(true);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            
            BitmapCanvasProvider canvas = new BitmapCanvasProvider(baos, "image/png", 300, BufferedImage.TYPE_BYTE_BINARY, false, 0);
            code128.generateBarcode(canvas, value);
            canvas.finish();

            ServletOutputStream responseOutputStream = response.getOutputStream();
            responseOutputStream.write(baos.toByteArray());
            responseOutputStream.flush();
            responseOutputStream.close();

       } catch (Exception ex) { 
           throw new ServletException(ex); 
       } 
    } 
  
}