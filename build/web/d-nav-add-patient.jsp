<%-- 
    Document   : d-nav-add-patient
    Created on : 17 Apr, 2024, 8:35:34 PM
    Author     : Dashrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" href="css/patient-register.css">
        <link rel="stylesheet" href="css/nav-bar.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <%@include file="nav-bar.jsp"%>
        <div class="register">
            <center>Add New Patient </center>
                <%
                    String mssg = (String) request.getAttribute("message");
                    if (mssg != null) {
                        out.print(mssg);
                    }
                %>
            <form action="addpatientServlet">
                <table>
                    <tr>
                        <td><a>Patient First Name</a></td>
                        <td><input type="text" maxlength="20" onkeypress="return event.charCode >= 48 && event.char.Code <= 57" placeholder="  Enter First Name " name="fname"required></td>
                    </tr>
                    <tr>
                        <td><a>Patient Last Name</a></td>
                        <td><input type="text" maxlength="20" onkeypress="return event.charCode >= 48 && event.char.Code <= 57" placeholder="  Enter Last Name" name="lname"required></td>
                    </tr>
                    <tr>
                        <td> <a>Gender</a></td>
                        <td><input type="radio" value="male" name="Gender" >Male
                            <input type="radio" value="female" name="Gender" >Female</td>
                    </tr>
                    <tr>
                        <td><a>Phone Number</a></td>
                        <td> <input type="text" maxlength="10" onkeypress="return event.charCode >= 48 && event.char.Code <= 57" placeholder="  Enter Phone Number"  name="phone" required></td>
                    </tr>
                    <tr>
                        <td><a>Age </a></td>
                        <td> <input type="text" maxlength="3" onkeypress="return event.charCode >= 48 && event.char.Code <= 57" placeholder="  Enter Age" value="" name="age"required ></td>
                    </tr>

                    <tr>
                        <td> <a>Email</a></td>
                        <td><input type="email" placeholder="  Enter  Email" name="email" required></td>
                    </tr>
                    <tr>
                        <td><a>Address</a></td>
                        <td><input type="text" placeholder="  Enter Address" name="address" required></td>
                    </tr>
                    <tr>
                        <td><a> Blood Group </a></td>
                        <td><input type="text" placeholder="  Enter Blood Group" name="blood"></td>
                    </tr>

                </table>
                <input type="HIDDEN" NAME="domain" value="doctor">

                <input type="submit" value="Add Patient">
                <input type="reset" name="Reset" value="Reset">
            </form>

        </div>
    </body>
</html>
