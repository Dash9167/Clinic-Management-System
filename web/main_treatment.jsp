<%-- 
    Document   : main_treatment
    Created on : 8 Apr, 2024, 1:31:27 PM
    Author     : Dashrath
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Treatment</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@2.0.1/dist/css/multi-select-tag.css">
        <link rel="stylesheet" href="css\main_treatment.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <%
            String heart_rate = request.getParameter("heart_rate");
            String sugar = request.getParameter("sugar");
            String blood_p = request.getParameter("blood_p");
            String weight = request.getParameter("weight");
            String height = request.getParameter("height");
            String B_Temperature = request.getParameter("Body_Temperature");
            String id = request.getParameter("id");
            String ap_code = request.getParameter("ap_id");

            Class.forName("com.mysql.jdbc.Driver");
            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            PreparedStatement pst1 = connect.prepareStatement("insert into treatment_info values (?,?,?,?,?,?,?)");
            pst1.setString(1, heart_rate);
            pst1.setString(2, blood_p);
            pst1.setString(3, sugar);
            pst1.setString(4, weight);
            pst1.setString(5, height);
            pst1.setString(6, B_Temperature);
            pst1.setString(7, id);
            int rsss1 = pst1.executeUpdate();
        %>
        <div>
            <div class="container">
                <a href="Treatment.jsp"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <header>
                    <u> Medicine Treatment</u>
                </header>
                <form action="Actual_treatmentServlet" method="post">
                    <div class="form first">
                        <div class="details personal">
                            <span class="title">Medicine Details For ID <input type="text" name="id" value="<%=id%>" style=" display:none;"readonly></span>
                            <div class="fields">
                                <div class="input-field">
                                    <label>Medicine Name</label>
                                    <select name="medicine" id="medicine" class="livesearch" multiple requried>
                                        <%
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                                            String query = "SELECT * FROM medicine_info";
                                            Statement stmt = conn.createStatement();
                                            ResultSet rs = stmt.executeQuery(query);
                                            while (rs.next()) {
                                                String medicine = rs.getString(2);
                                        %>
                                        <option value="<%=medicine%>"><%=medicine%></option>        
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="input-field">
                                    <label>Lab Test Suggestion</label> <input type="text" name="ap_code" value="<%=ap_code%>" style=" display:none;"readonly>
                                    <select name="test" id="test" class="livesearch" multiple>
                                        <%
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection connn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                                            String test_query = "SELECT * FROM test";
                                            Statement stmtt = connn.createStatement();
                                            ResultSet rss = stmtt.executeQuery(test_query);
                                            while (rss.next()) {
                                                String test = rss.getString(1);
                                        %>
                                        <option value="<%=test%>"><%=test%></option>        
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="input-field">
                                    <label>Injections</label>
                                    <select name="injection" id="injection" class="livesearch" multiple>
                                        <%                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection connnn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                                            String injection = "SELECT * FROM injection_info";
                                            Statement stmttt = connnn.createStatement();
                                            ResultSet rsss = stmttt.executeQuery(injection);
                                            while (rsss.next()) {
                                                String injection_name = rsss.getString(1);
                                        %>
                                        <option value="<%=injection_name%>"><%=injection_name%></option>        
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%%>
                    <div class="buttons">

                        <button class="next-btn" type="submit">
                            <span>Next </span><i class="fa-solid fa-circle-chevron-right"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@2.0.1/dist/js/multi-select-tag.js"></script>
        <script>
            new MultiSelectTag('medicine')  // id
            new MultiSelectTag('test')  // id
            new MultiSelectTag('injection')  // id
        </script>
    </body>
</html>
