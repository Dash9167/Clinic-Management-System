package hospital;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Class.forName;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class viewPatient extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("select * from patient_info");

            out.println("<table border='1'>");
            out.println("");
            out.println("<tr><th>patient id</th><th>first name</th><th>last name</th><th>gender</th><th>phone</th><th>age</th><th>email</th><th>address</th><th>Blood Group</th></tr>");
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

                out.println("<tr><td>'" + patient_id + "'</td><td>'" + first + "'</td><td>'"+last+"'</td>");
                out.print("<td>'" + gender + "'</td><td>'" + phone + "'</td>");
                out.print("<td>'" + age + "'</td><td>'" + email + "'</td>");
                out.print("<td>'" + address + "'</td><td>'" + blood + "'</td>");
                out.print("</tr>");

            }

        } catch (Exception e) {
            out.println(e);
        }

    }
}
