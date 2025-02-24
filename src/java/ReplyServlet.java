import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/Reply")
public class ReplyServlet extends HttpServlet {
    
    // Handle Reply Creation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int commentId = Integer.parseInt(request.getParameter("commentId")); // Get commentId from form
        String replyText = request.getParameter("text"); // Reply text from form
        int userId = Integer.parseInt(request.getParameter("userId")); // Get userId from session
        
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO Replies (comment_id, user_id, text) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, commentId);
                stmt.setInt(2, userId);
                stmt.setString(3, replyText);
                stmt.executeUpdate();
                
                // After reply is posted, redirect to the topic page
                int topicId = getTopicIdFromComment(conn, commentId); // Get topicId for redirection
                response.sendRedirect("ViewTopicServlet?topicId=" + topicId);
            }
        } catch (SQLException e) {
            response.sendRedirect("topic.jsp?error=true");
        }
    }

    // Helper method to get TopicId from CommentId
    private int getTopicIdFromComment(Connection conn, int commentId) throws SQLException {
        String query = "SELECT topic_id FROM Comments WHERE comment_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, commentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("topic_id");
            }
        }
        return -1; // Return -1 if not found
    }
}
