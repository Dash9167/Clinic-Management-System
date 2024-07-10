<%-- 
    Document   : prescription
    Created on : 17 Apr, 2024, 9:13:29 PM
    Author     : Dashrath
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>prescription Page</title>
        <link rel="stylesheet" href="css/search.css">
        <link rel="stylesheet" href="css/prescription.css">
    </head>
    <body>
        <%@include  file="m-nav-bar.jsp"%>

        <div class="search-container">

            <form action="" method="get">
                <input type="text" name="search" placeholder="Search Patient Id/Appointment Id">
                <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
            </form>
        </div>
        <%
            String mssg = (String) request.getAttribute("mssgg");
            if (mssg != null) {
        %>
        <h3><%=mssg%></h3>
        <%
            }
        %>
        <div class="container">
            <%
                String search = request.getParameter("search");
                if (search != null && !search.isEmpty()) {
                    Class.forName("com.mysql.jdbc.Driver");

                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = con.prepareStatement("select * from prescription_info where patient_id like ? or appointment_code like ? AND given=?");
                    pst.setString(1, "%" + search + "%");
                    pst.setString(2, "%" + search + "%");
                    pst.setString(3, "NOT GIVEN");

                    ResultSet rss = pst.executeQuery();
                    while (rss.next()) {
                        String patient_id = rss.getString(1);

                        String medicine_name = rss.getString(2);
                        String test = rss.getString(3);
                        String injection = rss.getString(4);
                        String app_code = rss.getString(5);
                        String Status = rss.getString(6);
                       PreparedStatement psttt = con.prepareStatement("select * from patient_info where patient_id=?");
                        psttt.setString(1, patient_id);
                        ResultSet rsss = psttt.executeQuery();

                        if (rsss.next()) {
                            String fn = rsss.getString(2);
                            String ln = rsss.getString(3);
                        


            %> 

            <form action="" method="get">


                <div class="list-info" >
                    <center class="heading">Patient ID : <input type="text" name="p_id" value="<%=patient_id%> " readonly></center>
                    <table>
                        <tr>
                            <td>  Name  : <%=fn + " " + ln%></td>
                            <td>  Status  : <%=Status%></td>
                            <td>  Appointment Code : <input type="text" name="app-code" value="<%=app_code%>" readonly ></td>
                        </tr>
                        <tr><td>  Medicine : <%=medicine_name%></td>
                            <td>  Lab Test : <%=test%></td>
                            <td> Injection : <%=injection%></td>
                        </tr>
                    </table>
                    <input type="submit" value="Given">
                </div>
            </form>
            <%}
                }
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");

                    Connection connn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pstt = connn.prepareStatement("select * from prescription_info where given=?");
                    pstt.setString(1, "NOT GIVEN");
                    ResultSet rs = pstt.executeQuery();
                    while (rs.next()) {
                        String patient_id = rs.getString(1);
                        String medicine_name = rs.getString(2);
                        String test = rs.getString(3);
                        String injection = rs.getString(4);
                        String app_code = rs.getString(5);
                        String Status = rs.getString(6);
                        PreparedStatement psttt = conn.prepareStatement("select * from patient_info where patient_id=?");
                        psttt.setString(1, patient_id);
                        ResultSet rsss = psttt.executeQuery();

                        if (rsss.next()) {
                            String fn = rsss.getString(2);
                            String ln = rsss.getString(3);
                        


            %> 

            <form action="" method="get">


                <div class="list-info" >
                    <center class="heading">Patient ID : <input type="text" name="p_id" value="<%=patient_id%> " readonly></center>
                    <table>
                        <tr>
                            <td>  Name  : <%=fn + " " + ln%></td>
                            <td>  Status  : <%=Status%></td>
                            <td>  Appointment Code : <input type="text" name="app-code" value="<%=app_code%>" readonly ></td>
                        </tr>
                        <tr><td>  Medicine : <%=medicine_name%></td>
                            <td>  Lab Test : <%=test%></td>
                            <td> Injection : <%=injection%></td>
                        </tr>
                    </table>
                    <input type="submit" value="Given">
                </div>
            </form>
            <%}
                }

            } catch (Exception e) {
            %>
            <h2><%=e%></h2>
            <%
                    }
                }
            %>
            <%
                String value = "GIVEN";
                String msssg = "";

                try {
                    String p_id = request.getParameter("p_id");
                    String app_code = request.getParameter("app-code");
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = conn.prepareStatement("UPDATE prescription_info SET given=? WHERE patient_id=? ");
                    pst.setString(1, value);
                    pst.setString(2, p_id);

                    int rowsAffected = pst.executeUpdate();

                    if (rowsAffected > 0) {
                        msssg = "<h4> Prescription Given Successfully </h4>";
                    } else {
                        msssg = "<h4> Prescription Given Unsuccessfully </h4>";
                    }
                } catch (SQLException e) {
                    msssg = e.toString();
                }
                request.setAttribute("mssgg", msssg);
            %>


        </div>

    </body>
</html>
