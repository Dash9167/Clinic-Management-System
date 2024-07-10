<%-- 
    Document   : forget-password
    Created on : 21 Mar, 2024, 8:22:56 PM
    Author     : Dashrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
       <link rel="stylesheet" href="css/forget-password.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>

    <body>
       <div class="contianer">
         <div class="forget">
           
            <form action="passwordServlet" method="post">
                <a href="index.jsp"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <table>
                    <center><h1>Generate Password</h1></center>
                    <%
                    String mssg=(String)request.getAttribute("mssg");
                    if(mssg!=null)
                    {
                        out.print("<h1>"+mssg+"</h1>");
                    }
                    %>
                    <tr>
                        <td>Enter Email</td>
                        <td><input type="email" name="email" required></td>
                    </tr>
                    <tr>
                        <td>Create Password</td>
                        <td><input type="password" name="npass" required></td>
    
                    </tr>
                    <tr>
                        <td>Confirm Password</td>
                        <td> <input type="password" name="cpass" required> </td>
                    </tr>
                   
                </table>
                <input type="submit" value="Generate Password">

            </form>
    

         </div>
       
       </div>
    </body>
</html>
