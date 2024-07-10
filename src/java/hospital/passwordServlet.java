package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class passwordServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String npass = request.getParameter("npass");
        String cpass = request.getParameter("cpass");
        String mssg = "";

        if ((npass.length() >= 8) && cpass.length() >= 8) {
            if (npass.equals(cpass)) {

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
                    PreparedStatement pst = con.prepareStatement("select * from login_info where email=?");
                    pst.setString(1, email);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String domain = rs.getString(1);
                        PreparedStatement pst2 = con.prepareStatement("update login_info set password=? where email=?");
                        pst2.setString(1, npass);
                        pst2.setString(2, email);
                        pst2.executeUpdate();

                        mssg = "<center><h5 style='color:green;'>Password updated successfullly </h5></center>";

                    } else {
                        mssg = "<center><h5 style='color:red;'>" + email + " dosn't Exit !!</h5></center>";

                    }

                } catch (Exception e) {
                    out.println(e);
                }

            } else {

                mssg = "<center><h5 style='color:red;'>Password doesn't match !! try again</h5></center>";

            }
        } else {
            mssg = "<center style='color:red;'>Password  Lenght at least 8 character long</center>";

        }

        request.setAttribute("mssg", mssg);
        request.getRequestDispatcher("forget-password.jsp").forward(request, response);

    }
}
