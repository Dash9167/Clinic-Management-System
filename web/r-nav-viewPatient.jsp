<%-- 
    Document   : r-nav-viewPatient
    Created on : 17 Apr, 2024, 8:23:00 PM
    Author     : Dashrath
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title> Patient</title>
        <link rel="stylesheet" href="css/nav-bar.css">
        <link rel="stylesheet" href="css/viewPatient.css">
        <link rel="stylesheet" href="css/search.css">


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <%@include file="receptionist-nav-bar.jsp" %>
        <div class="search-container">

            <form action="" method="get">
                <input type="text" name="search" placeholder="Search Patient">
                <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
            </form>
        </div>
        <div class="content">


            <%
                String search = request.getParameter("search");

                if (search != null && !search.isEmpty()) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                        PreparedStatement pst = conn.prepareStatement("select * from patient_info where first_name like ? or last_name like ?");
                        pst.setString(1, "%" + search + "%");
                        pst.setString(2, "%" + search + "%");

                        ResultSet rs = pst.executeQuery();

                        out.println("</tr></tbody> </table></div>");

                        if (rs.next()) {

                            out.println("");
                            out.println(" <div class='responsive-table'><h1>Your Search Result</h1>");
                            out.print("<table> <thead><tr><th>Id</th><th>Name</th><th>Gender</th><th>Phone</th><th>Age</th><th>Email</th><th>Address</th><th>Blood</th><th>Edit</th><th>Book</th>");
                            while (rs.next()) {

                                String patient_id = rs.getString(1);
                                String first = rs.getString(2);
                                String last = rs.getString(3);
                                String gender = rs.getString(4);
                                String phone = rs.getString(5);
                                String age = rs.getString(6);
                                String email = rs.getString(7);
                                String address = rs.getString(8);
                                String blood = rs.getString(9);
                                String Name = first + " " + last;

                                out.println("<form action='editPatient.jsp' method='post'>");

                                out.print("</tr> </thead> <tbody>");
                                out.print("<tr class='tr2'><td data-label='No'><input type='text' value='" + patient_id + "' name=patient_id readonly></td><td data-label='Name'>" + Name + "</td>");
                                out.println("<td data-label='Gender'>" + gender + "</td><td data-label='Phone'>" + phone + "</td>");
                                out.println("<td data-label='Age'>" + age + "</td><td data-label='Email'>" + email + "</td>");
                                out.println(" <td data-label='Address'>" + address + "</td>        <td data-label='Blood'>" + blood + "</td>");
                                out.println(" <td data-label='Edit'><div class='action'><button class='edit' type='submit'>Edit </button> </div></td>   ");
            %>

            <input type="hidden" value="receptionist" name="domain">
            <%
                out.println("</form><td><form action='r-nav-book-appointment.jsp' ><input type='hidden'  value='" + patient_id + "' name='id'> <input type='submit'  value='Book' ></form></td>");
            %>


            <%
                        }
                        out.println("</table>");

                    } else {
                        out.println("<h1 style=color:red;text-align:center>Couldn't find patient </h1>");
                    }

                } catch (Exception e) {

                }
            } else {

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("select * from patient_info order by patient_id desc");

                    out.println("");
                    out.println(" <div class='responsive-table'><h1>Patient List</h1>");
                    out.print("<table> <thead><tr><th>Id</th><th>Name</th><th>Gender</th><th>Phone</th><th>Age</th><th>Email</th><th>Address</th><th>Blood</th><th>Action</th>");

                    while (rs.next()) {
                        String patient_id = rs.getString(1);
                        String first = rs.getString(2);
                        String last = rs.getString(3);
                        String gender = rs.getString(4);
                        String phone = rs.getString(5);
                        String age = rs.getString(6);
                        String email = rs.getString(7);
                        String address = rs.getString(8);
                        String blood = rs.getString(9);
                        String Name = first + " " + last;

                        out.println("<form action='editPatient.jsp' method='post'>");

                        out.print("</tr> </thead> <tbody>");
                        out.print("<tr class='tr2'><td data-label='No'><input type=text value='" + patient_id + "' name=patient_id readonly></td><td data-label='Name'>" + Name + "</td>");
                        out.println("<td data-label='Gender'>" + gender + "</td><td data-label='Phone'>" + phone + "</td>");
                        out.println("<td data-label='Age'>" + age + "</td><td data-label='Email'>" + email + "</td>");
                        out.println(" <td data-label='Address'>" + address + "</td>        <td data-label='Blood'>" + blood + "</td>");
                        out.println(" <td data-label='Edit'><div class='action'><button class='edit' type='submit'>Edit </button> </div></td>   ");
            %>
            <input type="hidden" value="receptionist" name="domain">
            <%
                out.println("</form><td><form action='r-nav-book-appointment.jsp' ><input type='hidden'  value='" + patient_id + "' name='id'> <input type='submit'  value='Book' ></form></td></tr>");
            %>
            <%
                            out.println("</form>");

                        }
                        out.println("</table>");

                    } catch (Exception e) {
                        out.println(e);
                    }

                }

            %>
        </div>
        <div class="container">

            <%
            %>


        </div>



    </body>
</html>
