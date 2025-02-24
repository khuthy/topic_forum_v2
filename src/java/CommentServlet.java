import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/Comment")
public class CommentServlet extends HttpServlet {
    
    // Handle Comment Creation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int topicId = Integer.parseInt(request.getParameter("topicId")); // Get topicId from form
        String commentText = request.getParameter("text"); // Comment text from form
        int userId = Integer.parseInt(request.getParameter("userId")); // Get userId from session
        
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO Comments (topic_id, user_id, text) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, topicId);
                stmt.setInt(2, userId);
                stmt.setString(3, commentText);
                stmt.executeUpdate();
                
                // After comment is posted, redirect to the topic page
                response.sendRedirect("ViewTopicServlet?topicId=" + topicId);
            }
        } catch (SQLException e) {
            response.sendRedirect("topic.jsp?topicId=" + topicId + "&error=true");
        }
    }
}
