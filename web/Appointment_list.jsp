<%-- 
    Document   : Appointment_list
    Created on : 20 Mar, 2024, 1:55:10 AM
    Author     : Dashrath
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Appointment_list Page</title>

        <link rel="stylesheet" href="css/Appointment_list.css">
        <link rel="stylesheet" href="css/search.css">




    </head>
    <body>

        <div class="search-container">

            <form action="" method="get">
                <input type="text" name="search" placeholder="Search Appointment">
                <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
            </form>
        </div>
        <div class="container">

            <%
                String search = request.getParameter("search");
                LocalDate today_Date = LocalDate.now();
                if (search != null && !search.isEmpty()) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                        PreparedStatement pst = conn.prepareStatement("select * from appointment_info where appointment_id like ? or appointment_code like ? or patient_id like ? AND appointment_date=?");
                        pst.setString(1, "%" + search + "%");
                        pst.setString(2, "%" + search + "%");
                        pst.setString(3, "%" + search + "%");
                        pst.setString(4, today_Date.toString());

                        ResultSet rs = pst.executeQuery();
                         %>
            <h3 style=" color: #4CAF50;margin-bottom:15px; ">Search Result " <%=search%> "</h3>
            <%
                        while (rs.next()) {
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
            %>

            <div class="list-info">

                <center class="heading">Appointment ID: <%= appointment_id%></center>
                <table>
                    <tr>
                        <td>Name: <%= fname + " " + lname%></td>
                        <td>Patient ID: <%= patient_id%></td>
                        <td>Appointment Time: <%= appointment_time%></td>
                    </tr>
                    <tr>
                        <td>Gender: <%= gender%></td>
                        <td>Symptoms: <%= sysptoms%></td>
                        <td>Status: <%= status%></td>
                    </tr>
                    <tr>
                        <td>
                            <form action="" method="get">
                                <input type="hidden" name="app_id" value="<%= appointment_id%>">
                                <input type="submit" name="delete" value="Delete">
                            </form>
                        </td>
                        <td>
                            <form action="Treatment.jsp" method="post" style="display: inline;">

                                <input type="hidden" name="search" value="<%= appointment_time%>">
                                <input type="submit" value="Treatment">
                            </form>
                        </td>
                    </tr>

                    <!-- Second form for the Treatment button -->

                </table>
            </div>
            <%
                        }
                    }

                } catch (Exception e) {

                }
            } else {
            %>
            
          
            
            <%
                LocalDate today_date = LocalDate.now();
                String mssg = "";
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = conn.prepareStatement("select * from appointment_info where appointment_date=?");
                    pst.setString(1, today_date.toString());
                    ResultSet rs = pst.executeQuery();
                    while (rs.next()) {
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


            %>



            <div class="list-info">

                <center class="heading">Appointment ID: <%= appointment_id%></center>
                <table>
                    <tr>
                        <td>Name: <%= fname + " " + lname%></td>
                        <td>Patient ID: <%= patient_id%></td>
                        <td>Appointment Time: <%= appointment_time%></td>
                    </tr>
                    <tr>
                        <td>Gender: <%= gender%></td>
                        <td>Symptoms: <%= sysptoms%></td>
                        <td>Status: <%= status%></td>
                    </tr>
                    <tr>
                        <td>
                            <form action="" method="get">
                                <input type="hidden" name="app_id" value="<%= appointment_id%>">
                                <input type="submit" name="delete" value="Delete">
                            </form>
                        </td>
                        <td>
                            <form action="Treatment.jsp" method="post" style="display: inline;">

                                <input type="hidden" name="search" value="<%= appointment_code%>">
                                <input type="submit" value="Treatment">
                            </form>
                        </td>
                    </tr>

                    <!-- Second form for the Treatment button -->

                </table>
            </div>
            <%
                        }

                    }

                } catch (Exception e) {
                    out.println(e);
                }


            %>

            <%                }
            %>





            <%
                String mssg = "";
                String app_id = request.getParameter("app_id");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pstt2 = connn.prepareStatement("delete from appointment_info where appointment_id=?");
                    pstt2.setString(1, app_id);
                    int row = pstt2.executeUpdate();
                    {
                        mssg = "<h3>Appointment deleted successfully !!</h3>";

                    }
                } catch (Exception e) {
                    mssg = "<h3>" + e + "</h3>";
                }
            %>





        </div>
    </body>
</html>
