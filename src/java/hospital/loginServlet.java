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
import javax.servlet.http.HttpSession;

public class loginServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String domain, email, password;
        domain = request.getParameter("domain");
        email = request.getParameter("email");
        password = request.getParameter("password");
        String mssg = "";

        //  out.println("<h1>domain</h1>");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "");
            PreparedStatement pst = con.prepareStatement("select * from login_info where domain_name=?");
            pst.setString(1, domain);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                if (email.equals(rs.getString(2)) && password.equals(rs.getString(3))) {
                    HttpSession session = request.getSession();

                    if (domain.equals("doctor")) {
                        RequestDispatcher rd = request.getRequestDispatcher("Doctorhome.jsp");
                        rd.forward(request, response);
                    }
                    if (domain.equals("receptionist")) {
                        RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                        rd.forward(request, response);
                    }
                    if (domain.equals("medical")) {
                        RequestDispatcher rd = request.getRequestDispatcher("medicalhome.jsp");
                        rd.forward(request, response);
                    }
                } else {
                    mssg = "<h3 style=color:red;><center >Password & Email does not match</center></h3>";

                }
           

            } }
        catch (Exception e) {
            mssg = e.toString();
        }
        request.setAttribute("message", mssg);
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.include(request, response);

    }
}
