/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import da.*;
import domain.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 
/**
 * A Java servlet that handles file upload from client.
 * 
 * @author www.codejava.net
 */
@WebServlet(name = "UploadImageFile", urlPatterns = {"/servlet/UploadImageFile"})
public class UploadImageFile extends HttpServlet {
    private static final long serialVersionUID = 1L;
     
    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "../../web/upload";
    private static final String UPLOAD_DIRECTORY_SAVE_IN_DATABASE = "upload";
 
    // upload settings
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
 
    /**
     * Upon receiving file upload submission, parses the request to read
     * upload data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        //Everything from mealInsert.jsp
        MealDA mealDA = new MealDA();
        CategoryDA categoryDA = new CategoryDA();
        PendingRecipeDA pendingRecipeDA = new PendingRecipeDA();
        RecipeDA recipeDA = new RecipeDA();

        String name = null;// = request.getParameter("name");
        String cat = null;
        Category category = null;
        String desc = null;
        int pr = 0;
        String stt = null;
        
        //Image Here
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            
            out.println("Error: Form must has enctype=multipart/form-data.");
            out.flush();
            return;
        }
 
        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk 
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);
        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;
        String databaseFileName = null;
        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
 
        try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
 
            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                for (FileItem item : formItems) {
                    if (item.isFormField()){
                        if("name".equalsIgnoreCase(item.getFieldName())){
                            name = item.getString();
                        } else if("category".equalsIgnoreCase(item.getFieldName())){
                            cat = item.getString();
                            category = categoryDA.getNameRecord(cat);
                        } else if("description".equalsIgnoreCase(item.getFieldName())){
                            desc = item.getString();
                        } else if("price".equalsIgnoreCase(item.getFieldName())){
                            pr = Integer.valueOf(item.getString());
                        } else if("status".equalsIgnoreCase(item.getFieldName())){
                            if("Available".equalsIgnoreCase(item.getString())){
                                stt = item.getString();
                            } else{
                                stt = "Unavailable";
                            }
                        }
                    } else if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
 
                        // saves the file on disk
                        item.write(storeFile);
                         out.println("Upload has been done successfully!");
                         out.println(File.separator + UPLOAD_DIRECTORY_SAVE_IN_DATABASE + File.separator + fileName);
                         databaseFileName = ".." + File.separator + UPLOAD_DIRECTORY_SAVE_IN_DATABASE + File.separator + fileName;
                    }
                }
            }
        } catch (Exception ex) {
            out.println("There was an error: " + ex.getMessage());
        }
        
        //Continue mealInsert.jsp
        ArrayList<PendingRecipe> pendingRecipe = new ArrayList<PendingRecipe>(); 
        pendingRecipe.addAll(pendingRecipeDA.getAllPendingRecipes());

        double calorie = 0;
        for (int i = 0; i < pendingRecipe.size(); i++) { 
            calorie += ((pendingRecipe.get(i).getIngredient().calCalorie() / pendingRecipe.get(i).getIngredient().getSize()) * pendingRecipe.get(i).getSize());
        }

        Meal meal = new Meal(name, desc, databaseFileName, pr, stt, calorie, category);
        mealDA.addRecord(meal);
        meal = mealDA.getLastMeal();

        out.println(pendingRecipe.size());
        
        Recipe recipe = null;

        for (int i = 0; i < pendingRecipe.size(); i++) { 
            recipe = new Recipe(meal, pendingRecipe.get(i).getIngredient(), pendingRecipe.get(i).getSize(), pendingRecipe.get(i).getUnit());
            recipeDA.addRecord(recipe);
        }

        pendingRecipeDA.delAll();
        
        response.sendRedirect("../mealManagement/addMeal.jsp?msg=addMealSuccess&mealName=" + name + "&price=" + pr);
        
    }
}