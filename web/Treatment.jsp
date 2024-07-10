<%-- 
    Document   : Treatment
    Created on : 20 Mar, 2024, 2:13:48 AM
    Author     : Dashrath
--%>


<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Treatment</title>
        <link rel="stylesheet" href="css\treatmet.css">
     
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>

        <div class="treatmet">
           
         

            <%                String search = request.getParameter("search");

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                PreparedStatement pst = conn.prepareStatement("select * from appointment_info where appointment_code=?");
                pst.setString(1, search);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    String id = rs.getString(3);
                    String symtoms = rs.getString(6);


            %>
            <div class="container">
                <a href="Doctorhome.jsp"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <header>
                    <u> Treatment</u>
                </header>
                <form action="main_treatment.jsp" method="post">
                    <div class="form first">
                        <div class="details personal">
                            <span class="title">Personal Details </span>
                            <div class="fields">
                                <%                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection connn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                                    PreparedStatement pst2 = connn.prepareStatement("select * from patient_info where patient_id=?");
                                    pst2.setString(1, id);
                                    ResultSet rss = pst2.executeQuery();
                                    if (rss.next()) {
                                        String name = rss.getString(2) + " " + rss.getString(3);
                                        String age = rss.getString(6);
                                        String blood = rss.getString(9);


                                %>

                                <div class="input-field">
                                    <label>Name</label>
                                    <input type="text" placeholder="" value="<%=name%>" readonly>

                                </div>

                                <div class="input-field">
                                    <label>Patient Id</label>
                                    <input type="text" placeholder=" " value="<%=id%>" readonly name="id">
                                </div>

                                <div class="input-field">
                                    <label>Appointment Code</label>
                                    <input type="text" placeholder="" value="<%=search%>"readonly name="ap_id">
                                </div>
                                <div class="input-field" readonly>
                                    <label>Age</label>
                                    <input type="text" placeholder="<%=age%>" readonly>
                                </div>
                                <div class="input-field">
                                    <label>Symptoms</label>
                                    <input type="text" readonly placeholder="<%=symtoms%>" readonly>
                                </div>
                                <div class="input-field">
                                    <label>Blood Group</label>
                                    <input type="text" placeholder="<%=blood%>" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="details treatmet">

                            <span class="title">Treatment Details </span>
                            <div class="fields">
                                <div class="input-field">
                                    <label>Heart Rate</label>
                                    <input type="text" placeholder="" name="heart_rate">
                                </div>
                                <div class="input-field">
                                    <label>Blood Pressure</label>
                                    <input type="text" placeholder="" name="blood_p">
                                </div>
                                <div class="input-field">
                                    <label>Sugar</label>
                                    <select name="sugar">
                                        <option value="sugar">NO</option>
                                        <option value="sugar">YES</option>
                                    </select>
                                </div>
                                <div class="input-field">
                                    <label> weight</label>
                                    <input type="text" placeholder="" name="weight">
                                </div>
                                <div class="input-field">
                                    <label>height</label>
                                    <input type="text" placeholder="" name="height">
                                </div>
                                <div class="input-field">
                                    <label>Body Temperature</label>
                                    <input type="text" placeholder="" name="Body_Temperature">
                                </div>
                            </div>
                            <div class="buttons">
                                <button class="back-btn" type="reset">
                                    <i class="fa-solid fa-circle-chevron-left"></i><span >Reset </span>
                                </button>
                                <button class="next-btn">
                                    <span>Next </span><i class="fa-solid fa-circle-chevron-right"></i>
                                </button>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
            <%
               
                }
            } else {
               
            %>

            <%
                }


            %>
        </div>   
    </body>
</html>