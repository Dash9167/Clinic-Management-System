package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Actual_treatmentServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String medicine = request.getParameter("medicine");
        String test = request.getParameter("test");
        String injection = request.getParameter("injection");
        String id = request.getParameter("id");
        String ap_code = request.getParameter("ap_code");
        String mssg = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            PreparedStatement pst1 = conn.prepareStatement("INSERT INTO prescription_info (medicine_name, lab_test, injection_name, appointment_code, patient_id) VALUES (?, ?, ?, ?, ?)");
            pst1.setString(1, medicine);
            pst1.setString(2, test);
            pst1.setString(3, injection);
            pst1.setString(4, ap_code);
            pst1.setString(5, id);
            int result = pst1.executeUpdate();
            if (result > 0) {
                String status = "Checked";

                try {
                    Connection connn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst2 = connn.prepareStatement("update appointment_info set status=? where appointment_code=?");
                    pst2.setString(1, status);
                    pst2.setString(2, ap_code);
                    int result2 = pst2.executeUpdate();
                    if (result2 > 0) {
                        mssg = "<h3 style='color:green; text-align:center;'>Prescription Added Successfully</h3>";
                    } else {
                        mssg = "<h2 style='color:green; text-align:center;'>Prescription Added Successfully status not change</h2>";

                    }

                } catch (Exception e) {
                    mssg = e.toString();

                }
            } else {
                mssg = "<h2 style='color:red;text-align:center;'>Prescription Added Unsuccessfully for " + ap_code + "</h2>";
            }
        } catch (Exception e) {
            mssg = e.toString();
        }
        request.setAttribute("mssgg", mssg);
        request.getRequestDispatcher("Doctorhome.jsp").forward(request, response);

    }
}
