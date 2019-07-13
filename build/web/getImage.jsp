<%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
Integer id = Integer.parseInt(request.getParameter("id"));
 
String connectionURL = "jdbc:derby://localhost:1527/mealiciousDB";
String user = "nbuser";
String pass = "nbuser";
 
Connection con = null;
 
try{
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection(connectionURL, user, pass);
    
    PreparedStatement ps = con.prepareStatement("SELECT MEAL_IMAGE FROM NBUSER.MEAL WHERE MEAL_ID = ?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
 
    if(rs.next()){
        Blob blob = rs.getBlob("MEAL_IMAGE");
        byte byteArray[] = blob.getBytes(1, (int)blob.length());
 
        response.setContentType("image/jpeg");
        OutputStream os = response.getOutputStream();
        os.write(byteArray);
        os.flush();
        os.close();
    }
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
%>