<%-- 
    Document   : add-medicine
    Created on : 17 Apr, 2024, 5:47:32 PM
    Author     : Dashrath
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Prescription</title>
        <link rel="stylesheet" href="css/add-medicine.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>

        </style>
    </head>
    <body>   
        <div class="conatent">     
            <h2>Add Medicine</h2>
            <form action="" method="get">
                <div>
                    <label for="medicine">Add Medicine</label>
                    <input type="text" id="medicine" name="medicine">
                </div>
                <div>
                    <label for="labTest">Add Lab Test</label>
                    <input type="text" id="labTest" name="labTest">
                </div>
                <div>
                    <label for="syringe">Add Syringe</label>
                    <input type="text" id="syringe" name="syringe">
                </div>
                <input type="submit"  value="Add">
            </form>
            <%
                String medicine = request.getParameter("medicine");
                String labTest = request.getParameter("labTest");
                String syringe = request.getParameter("syringe");
                String mssg = "";

                try {

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    if (medicine != null) {
                        PreparedStatement pst = conn.prepareStatement("insert  into medicine_info (medicine_name) values (?)");
                        pst.setString(1, medicine);
                        int row = pst.executeUpdate();
                        if (row > 0) {
                            mssg = "Added successfully";
                        }

                    }
                    if (labTest != null) {
                        PreparedStatement pst = conn.prepareStatement("insert  into test values (?)");
                        pst.setString(1, labTest);
                        int row = pst.executeUpdate();
                        if (row > 0) {
                            mssg = "Added successfully";
                        }

                    }
                    if (syringe != null) {
                        PreparedStatement pst = conn.prepareStatement("insert  into injection_info values (?)");
                        pst.setString(1, syringe);
                        int row = pst.executeUpdate();
                        if (row > 0) {
                            mssg = "Added successfully";
                        }

                    }
                } catch (Exception e) {
                    mssg = e.toString();
                }
                request.setAttribute("mssg", mssg);
            %>
            <%                String msssg = (String) request.getAttribute("mssg");
                if (msssg != null) {
            %>
            <h5 style="color: green"><%=msssg%></h5>
            <%
                }
            %>
        </div>
    </body>
</html>

