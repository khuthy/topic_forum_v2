import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/Viewtopic")
public class ViewTopicServlet extends HttpServlet {
    
    // Handle View Specific Topic and Comments
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int topicId = Integer.parseInt(request.getParameter("topicId")); // Get topicId from URL
        
        try (Connection conn = DBConnection.getConnection()) {
            // Get Topic Details
            String topicQuery = "SELECT * FROM Topics WHERE topic_id = ?";
            try (PreparedStatement topicStmt = conn.prepareStatement(topicQuery)) {
                topicStmt.setInt(1, topicId);
                ResultSet topicRs = topicStmt.executeQuery();
                if (topicRs.next()) {
                    request.setAttribute("topic", topicRs);
                }
            }

            // Get Comments for this Topic
            String commentQuery = "SELECT * FROM Comments WHERE topic_id = ?";
            try (PreparedStatement commentStmt = conn.prepareStatement(commentQuery)) {
                commentStmt.setInt(1, topicId);
                ResultSet commentRs = commentStmt.executeQuery();
                request.setAttribute("comments", commentRs);
            }

            // Forward to topic.jsp to display
            RequestDispatcher dispatcher = request.getRequestDispatcher("topic.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            response.sendRedirect("home.jsp?error=true");
        }
    }
}
