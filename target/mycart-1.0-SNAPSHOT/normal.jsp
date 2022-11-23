<%@page import="com.learn.mycart.entities.User"%>
<%
    //JAVA Code for authentication
    User user =(User) session.getAttribute("current-user");
    
    if(user==null)
    {
        session.setAttribute("message", "You are not logged in !! Login First"); //key value pair key=message, value="You are not logged in !! Login First"
        response.sendRedirect("login.jsp");
        return;
    }
    else
    {
        if (user.getUserType().equals("admin")) 
        {
            session.setAttribute("message", "You are not normal user !! Do not access this page"); 
            response.sendRedirect("login.jsp");
            return;
        }
    }




%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Normal Page</title>
    </head>
    <body>
        <h1>This is normal user panel</h1>
    </body>
</html>
