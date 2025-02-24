import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO Users (email, password, first_name, last_name) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, email);
                stmt.setString(2, password); // Make sure to hash passwords in production!
                stmt.setString(3, firstName);
                stmt.setString(4, lastName);
                stmt.executeUpdate();
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            response.sendRedirect("register.jsp?error=true");
        }
    }
}
