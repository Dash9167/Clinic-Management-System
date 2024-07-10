package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class bookAppointmentServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String message = "";
        String appointment_id = request.getParameter("appointment_id");
        String domain = request.getParameter("domain");

        String patient_id = request.getParameter("p_id");
        String appointment_date = request.getParameter("appointment_date");
        String appointment_time = request.getParameter("appointment_time");
        String symptoms = request.getParameter("symptoms");
        String appointment_code = "AP" + appointment_id;
        LocalDate inputDate = LocalDate.parse(appointment_date);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            Class.forName("com.mysql.jdbc.Driver");
            String sql = "SELECT * FROM patient_info WHERE patient_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, patient_id);
            ResultSet rss = pstmt.executeQuery();
            if (rss.next()) {

                if (!inputDate.isBefore(LocalDate.now())) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                        PreparedStatement pst2 = con.prepareStatement("select count(appointment_id) from appointment_info where appointment_time=?");
                        pst2.setString(1, appointment_date);
                        ResultSet rs2 = pst2.executeQuery();
                        if (rs2.next()) {
                            int Appointment_count;
                            Appointment_count = rs2.getInt(1);
                            if (Appointment_count <= 10) {
                                PreparedStatement pst = con.prepareStatement("select * from appointment_info where appointment_date=? and appointment_time=?");
                                pst.setString(1, appointment_date);
                                pst.setString(2, appointment_time);
                                ResultSet rs = pst.executeQuery();
                                if (!rs.next()) {
                                    PreparedStatement ps = con.prepareStatement("update appointment_info set appointment_code=?, patient_id=?, appointment_date=?,"
                                            + "appointment_time=?,  sysmptoms=? where appointment_id=?");
                                    ps.setString(1, appointment_code);
                                    ps.setString(2, patient_id);
                                    ps.setString(3, appointment_date);
                                    ps.setString(4, appointment_time);
                                    ps.setString(5, symptoms);
                                    ps.setString(6, appointment_id);
                                    int rowsAffected = ps.executeUpdate();
                                    if (rowsAffected > 0) {
                                        PreparedStatement pst3;
                                        pst3 = con.prepareStatement("insert into appointment_info (status) values(?)");
                                        pst3.setString(1, "Not Checked");
                                        int rows = pst3.executeUpdate();
                                        if (rows > 0) {
                                            message = "Appointment booked successfully! " + appointment_code + "";
                                        }
                                    } else {
                                        message = "Failed to book appointment. Please try again.";
                                    }
                                } else {
                                    message = "<h3 style='color:red;'>Appointment is not available on " + appointment_time + "</h3>";
                                }
                            } else {
                                message = "<h3 style='color:red;'>Appointment  is Full on this day</h3>";
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        message = "Error: " + e.getMessage();
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(bookAppointmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    message = "<h3 style='color:red;'>Appointment date cannot be in past !!</h3>";
                }

            } else {

                message = "Patient ID does not exist in the table";
            }
        } catch (Exception e) {
            message = e.toString();
        }
        if ("doctor".equals(domain)) {
            request.setAttribute("message", message);
            request.getRequestDispatcher("d-nav-book-appointment.jsp").forward(request, response);
        } else if ("receptionist".equals(domain)) {
            request.setAttribute("message", message);
            request.getRequestDispatcher("r-nav-book-appointment.jsp").forward(request, response);
        }

    }
}
