<%-- 
    Document   : r-nav-book-appointment
    Created on : 17 Apr, 2024, 8:25:11 PM
    Author     : Dashrath
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>r-nav-book-appointment</title>
        <link rel="stylesheet" href="css/appointment.css">
        <link rel="stylesheet" href="css/nav-bar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .active{
                border:2px solid white;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@include file="receptionist-nav-bar.jsp" %>

        <div class="container">


            <div class="content">
                <h1>Book Appointment</h1>
                <form action="bookAppointmentServlet" method="post">
                    <h3 style="color: green">
                        <%
                            String mssg = (String) request.getAttribute("message");
                            if (mssg != null) {
                                out.print("<center>" + mssg + "</center>");
                            }
                        %>
                    </h3>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                        PreparedStatement pst2 = conn.prepareStatement("select * from appointment_info order by appointment_id desc limit 1");
                        ResultSet rs2 = pst2.executeQuery();
                        if (rs2.next()) {
                            String id = rs2.getString(1);
                            request.setAttribute("app_id", id);
                        }
                    %>
                    <table>
                        <tr><td> Appointment Id</td><td><input type="text" id="appointmentId" value="<%String ap_id = (String) request.getAttribute("app_id");
                            out.print(ap_id);
                                                               %>" placeholder="" name="appointment_id" readonly></td></tr>
                        <tr><td> Patient Id </td><td><input type="text" placeholder="Enter Patient id" name="p_id"
                                                            value="<%
                                                                String id = request.getParameter("id");
                                                                if (id != null) {
                                                            %><%=id%><%
                                                            } else {
                                                            %><%
                                                                }
                                                            %>"
                                                            ></td></tr>
                        <tr><td> Symptoms</td><td><input type="text" placeholder="Sysmtoms" name="symptoms"></td></tr>
                        <tr><td>Appointment Date</td><td><input type="date" placeholder="Enter Appointment Date" name="appointment_date" value="<%= java.time.LocalDate.now()%>"></td></tr>
                        <tr><td> <label for="appointment_time">Appointment Time</label></td>
                            <td><select  name="appointment_time" id="appointment_time">
                                    <option value="10:00:00">10 AM</option>
                                    <option value="11:00:000">11 AM</option>
                                    <option value="12:00:00">12 AM</option>
                                    <option value="2:00:00">2   PM</option>
                                    <option value="3:00:00">3   PM</option>
                                    <option value="4:00:00">4   PM</option>
                                    <option value="5:00:00">5   PM</option>
                                    <option value="6:00:00">6   PM</option>
                                    <option value="7:00:00">7   PM</option>
                                    <option value="8:00:00">8   PM</option>
                                    <option value="9:00:00">9   PM</option>
                                </select></td></tr>
                        <input type="HIDDEN" NAME="domain" value="receptionist">
                        <tr><td> <input type="reset" value="Clear"></td>
                            <td><input type="submit" value="Book"></td></tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>
