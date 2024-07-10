package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addpatientServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String mssg = "";

        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String gender = request.getParameter("Gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        String blood = request.getParameter("blood");
        String domain = request.getParameter("domain");

        int phone_lenght = phone.length();

        if (phone_lenght == 10) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                PreparedStatement pst = con.prepareStatement("insert into patient_info (first_name,last_name,gender,phone,age,email,address,blood_group) values(?,?,?,?,?,?,?,?)");

                pst.setString(1, fname);
                pst.setString(2, lname);
                pst.setString(3, gender);
                pst.setString(4, phone);
                pst.setString(5, age);
                pst.setString(6, email);
                pst.setString(7, address);
                pst.setString(8, blood);
                int row = pst.executeUpdate();
                if (row == 1) {
                    PreparedStatement pst2 = con.prepareStatement("select max(patient_id) from patient_info");
                    ResultSet rs = pst2.executeQuery();
                    int id = 0;

                    if (rs.next()) {
                        id = rs.getInt(1);

                        mssg = "<h4 style='color:green;'>" + fname + " " + lname + " added successfully & Patient ID is " + id + "</h4>";

                    }

                } else {
                    mssg = "<h3 style='color:red;'>Patient doen't added </h3> ";

                }

            } catch (ClassNotFoundException | SQLException e) {
                out.println(e);
            }

        } else {
            mssg = " <h3 style='color:red;'>length of phone number isn't proper</h3> ";

        }
        if ("doctor".equals(domain)) {
            request.setAttribute("message", mssg);
            request.getRequestDispatcher("d-nav-add-patient.jsp").forward(request, response);
        } else if ("receptionist".equals(domain)) {
            request.setAttribute("message", mssg);
            request.getRequestDispatcher("r-nav-add-patient.jsp").forward(request, response);
        }

    }
}
