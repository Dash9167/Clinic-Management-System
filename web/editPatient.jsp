<%-- 
    Document   : editPatient
    Created on : 5 Mar, 2024, 3:08:48 PM
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
        <title>Update Patient</title>
        <link rel="stylesheet" href="css/editPatient.css">
        <link rel="stylesheet" href="css/nav-bar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <%@include file="nav-bar.jsp" %>
        <div class="register">
            <%
                String domain = request.getParameter("domain");
                if (domain.equals("doctor")) {
            %>
            <a href="d-nav-viewPatient.jsp"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <%
                } else {

                %>
            <a href="r-nav-viewPatient.jsp"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <%                }
                %>



            <h2 style="text-align: center;margin-bottom: 20px;">Update Patient</h2>
            <%
                String mssg = (String) request.getAttribute("message");
                if (mssg != null) {
                    out.println("<h3>" + mssg + "</h3>");
                }
            %>



            <%
                String patient_id = request.getParameter("patient_id");

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = conn.prepareStatement("select * from patient_info where Patient_id=?");
                    pst.setString(1, patient_id);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String p_id = rs.getString(1);
                        String first = rs.getString(2);
                        String last = rs.getString(3);
                        String gender = rs.getString(4);
                        String phone = rs.getString(5);
                        String age = rs.getString(6);
                        String email = rs.getString(7);
                        String address = rs.getString(8);
                        String blood = rs.getString(9);

                        out.println("<form action=UpdatePatientServlet><table>");
                        out.println("<tr><td>Patient id</td><td><input type=text value='" + p_id + "' name=p_id readonly></td></tr>");
                        out.println("<tr><td>First Name</td><td><input type=text value='" + first + "' name=first></td></tr>");
                        out.println("<tr><td>Last Name</td><td><input type=text value='" + last + "' name=last></td></tr>");
                        out.println("<tr><td> Gender</td><td><input type=text value='" + gender + "' name=gender></td></tr>");
                        out.println("<tr><td>Phone</td><td><input type=text value='" + phone + "' name=phone></td></tr>");
                        out.println("<tr><td> Age</td><td><input type=text value='" + age + "' name=age></td></tr>");
                        out.println("<tr><td> Email</td><td><input type=text value='" + email + "' name=email></td></tr>");
                        out.println("<tr><td> Address</td><td><input type=text value='" + address + "' name=address></td></tr>");
                        out.println("<tr><td> Blood</td><td><input type=text value='" + blood + "' name=blood></td></tr>");
            %>
            <input type="hidden" value="<%=domain%>" name="domain">
            <%
                        out.println("</table><input type=submit value=Update></form>");

                    }
                } catch (Exception e) {
                    out.println("Error : " + e.getMessage());

                }
            %>

        </div>
    </body>
</html>
