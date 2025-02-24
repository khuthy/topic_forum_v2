import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/Topic")
public class TopicServlet extends HttpServlet {
    
    // Handle Topic Creation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int userId = Integer.parseInt(request.getParameter("userId")); // Get userId from session or request
        
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO Topics (title, description, user_id) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, title);
                stmt.setString(2, description);
                stmt.setInt(3, userId);
                stmt.executeUpdate();
                response.sendRedirect("home.jsp"); // Redirect after topic creation
            }
        } catch (SQLException e) {
            response.sendRedirect("createTopic.jsp?error=true");
        }
    }
    
    // Handle View Topics
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM Topics";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                ResultSet rs = stmt.executeQuery();
                request.setAttribute("topics", rs);
                RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            response.sendRedirect("home.jsp?error=true");
        }
    }
}
