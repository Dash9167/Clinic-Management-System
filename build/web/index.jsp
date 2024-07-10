<%-- 
    Document   : index.jsp
    Created on : 7 Mar, 2024, 12:01:31 AM
    Author     : Dashrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/hospital-login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/nav-bar.css">
    </head>
    <body>
        <div class="login">
            <div class="user-photo">

                <h1>Login</h1>
                <h2>
                    <%
                        String mssg = (String) request.getAttribute("message");
                        if (mssg != null) {
                            out.print(mssg);
                        }

                    %>
                </h2>
            </div>    
            <form action="loginServlet" method="post">
                <div class="input-box">
                    <select name="domain" id="domain" >
                        <option value="doctor">Doctor</option>
                        <option value="receptionist">Receptionist</option>
                        <option value="medical">Medical</option>
                    </select>
                </div>
                <div class="input-box">
                    <input type="email" name="email" placeholder="Enter  Email" required>
                    <i class="fa-regular fa-envelope"></i>
                </div>  
                <div class="input-box">
                    <input type="password" name="password" placeholder="Enter Password" required>
                    <i class="fa-solid fa-key">  </i>
                </div>  
                <button type="submit" class="btn">Login</button>
            </form>
            <div class="forget-pwd">
                <a href="forget-password.jsp">forgot password click here?</a>
            </div>     

        </div>
    </body>
</html>
