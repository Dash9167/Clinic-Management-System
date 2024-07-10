package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdatePatientServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String patient_id = request.getParameter("p_id");
        String first = request.getParameter("first");
        String last = request.getParameter("last");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        String blood = request.getParameter("blood");
        String domain = request.getParameter("domain");

        String mssg = "";

       
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            PreparedStatement pst = conn.prepareStatement("update patient_info set first_name=?,last_name=?,gender=?,phone=?,email=?,age=?,address=?,blood_group=? where patient_id=?");
            pst.setString(1, first);
            pst.setString(2, last);
            pst.setString(3, gender);
            pst.setString(4, phone);
            pst.setString(5, email);
            pst.setString(6, age);
            pst.setString(7, address);
            pst.setString(8, blood);
            pst.setString(9, patient_id);

            int rs = pst.executeUpdate();
            if (rs > 0) {
                mssg = "<h3 style=color:green>Patient information updated successfully<h3>";
            } else {
                mssg = "<h3 style=color:red>Patient information updated unsuccessfully</h3>";
            }

        } catch (Exception e) {
            mssg = e.toString();

        }
       
            request.setAttribute("message", mssg);
            request.getRequestDispatcher("editPatient.jsp").forward(request, response);
       

    }
}
