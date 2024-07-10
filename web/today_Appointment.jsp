<%-- 
    Document   : today_Appointment
    Created on : 19 Mar, 2024, 10:28:18 PM
    Author     : Dashrath
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/today_Appointment.css">

    </head>
    <body>

        <%@include file="nav-bar.jsp"%>
        <div class="content">
         

            <%
                LocalDate today_date = LocalDate.now();
                String mssg="";
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = conn.prepareStatement("select * from appointment_info where appointment_date=?");
                    pst.setString(1, today_date.toString());
                    ResultSet rs = pst.executeQuery();
                    int i=0;
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
                       if(rs2.next())
                       {
                        i++;
                       }
                       mssg=""+i;
                    }
                } catch (Exception e) {
                    out.println(e);
                }
                request.setAttribute("mssg",mssg);
                request.getRequestDispatcher("Doctorhome.jsp").forward(request, response);
            %>
        </div>

    </body>
</html>
