<%-- 
    Document   : Doctorhome
    Created on : 19 Mar, 2024, 1:04:50 AM
    Author     : Dashrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/doctorhome.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <%@include file="nav-bar.jsp"%>
       
       <div class="service-boxes">
    <div class="service-box">
        <a href="today_Appointment.jsp">
            <i class="fa fa-calendar" aria-hidden="true"></i>
            <span>Today's Appointment</span>
               <h1>

                        <%
                            String mssg = (String) request.getAttribute("mssg");
                            if (mssg != null) {
                                if(mssg==null)
                                {
                                     out.print("0");
                                }
                                else
                                {
                                    out.print(mssg);
                                }
                            } 
                           else {
                                out.print("");
                            }
                        %>
                    </h1>
        </a>
    </div>
    <div class="service-box">
        <a href="d-add-medicine.jsp">
            <i class="fa-solid fa-prescription-bottle-medical"></i>
            <span>Add Medicine</span>
        </a>
    </div>
    <div class="service-box">
        <a href="d-Appointment_list.jsp">
            <i class="fa fa-address-book" aria-hidden="true"></i>
            <span>Appointment List</span>
        </a>
    </div>
</div>

     

    </body>
</html>
