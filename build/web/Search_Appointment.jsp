<%-- 
    Document   : Search_Appointment
    Created on : 20 Mar, 2024, 12:09:06 AM
    Author     : Dashrath
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>today Appointment</title>
        <link rel="stylesheet" href="css/today_Appointment.css">
        <link rel="stylesheet" href="css/search.css">


    </head>
    <body>
        <%@include file="nav-bar.jsp"%>
        <div class="content">
            <div class="search-container">

                <form action="" method="get">
                    <input type="text" name="search" placeholder="Search Patient">
                    <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
                </form>
            </div>
            <%
                String search = request.getParameter("search");
                if (search != null && !search.isEmpty()) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                        PreparedStatement pst = conn.prepareStatement("select * from appointment_info where appointment_id like ? or appointment_code like ? or patient_id like ?");
                        pst.setString(1, "%" + search + "%");
                        pst.setString(2, "%" + search + "%");
                        pst.setString(3, "%" + search + "%");

                        ResultSet rs = pst.executeQuery();
                        while (rs.next()) {

                            out.println("<table >");
                            out.println("");

                            String appointment_id = rs.getString(1);
                            String appointment_code = rs.getString(2);
                            String patient_id = rs.getString(3);
                            String appointment_date = rs.getString(4);
                            String appointment_time = rs.getString(5);
                            String sysptoms = rs.getString(6);
                            String status = rs.getString(7);

                            PreparedStatement pst2 = conn.prepareStatement("select * from patient_info where patient_id=?");
                            pst2.setString(1, patient_id);
                            ResultSet rs2 = pst2.executeQuery();
                            
                            if (rs2.next()) {
                                String fname = rs2.getString(2);
                                String lname = rs2.getString(3);
                                String gender = rs2.getString(4);
                                String age = rs2.getString(6);
                                String phone = rs2.getString(5);
                                out.println("<tr class='color'><th > Patient Name </th><th colspan=7> " + fname + " " + lname + "</th></tr>");
                                out.println("<tr class='colors'><td>Appointment  Id</td><td>Appointment Code</td><td>Patient Id </td><td>Appointment Date</td><td>Appointment Time </td><td>Symptoms</td><td>Status</td><td>Treatment</td></tr>");

                                out.println("<form action='editPatient.jsp' method='post'>");

                                out.println("<tr><td><input type=text value='" + appointment_id + "' name=patient_id readonly></td><td>'" + appointment_code + "' </td><td>'" + patient_id + "' </td>");
                                out.print("<td>'" + appointment_date + "' </td><td>'" + appointment_time + "' </td>");
                                out.print("<td>'" + sysptoms + "'</td><td>'" + status + "'</td>");

                                out.print("<td><button type='submit' name='edit' ><i class='fa-solid fa-user-check'></i> Check Up</button></td></tr>");
                                out.println("</form>");

                            } else {
                                out.println("<h1 style=color:red;text-align:center>Couldn't find Appointment </h1>");
                            }
                        }

                    } catch (Exception e) {

                    }
                }
            %>

        </div>
    </body>
</html>
