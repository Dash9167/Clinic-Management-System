<%-- 
    Document   : m-nav-bar
    Created on : 17 Apr, 2024, 9:00:18 PM
    Author     : Dashrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/nav-bar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <div class="nav-bar ">
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fa-solid fa-bars"></i>
            </label>
            <label class="logo">
                <i class="fa-solid fa-house-chimney-medical"></i>Clinic Management System 
            </label>
            <ul>
                <li><a href="medicalhome.jsp" onclick="" >Home</a></li>

                <li><a href="prescription.jsp" onclick="">Prescription</a></li>
                <li><a href="m-add-medicine.jsp">Add Medicine</a></li>

               
                <li><a href="" id="logoutBtn"> Logout </a></li>

                <%--
                                <form action="logoutServlet">
                                    <input type="submit" value="Logout">
                                </form>
                --%>

            </ul>

        </div>
    </body>
</html>
<script>
    document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('logoutBtn').addEventListener('click', function (event) {
                event.preventDefault(); // Prevent the default behavior of the anchor tag
                var confirmation = confirm('Are you sure you want to logout?');
                if (confirmation) {
                    // Proceed with logout action
                    window.location.href = 'logoutServlet'; // Replace 'logout.php' with the actual logout URL
                }
                // If confirmation is false, do nothing
            });
        });

</script>
