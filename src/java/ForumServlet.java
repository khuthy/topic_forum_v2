import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;

public class ForumServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/topic_forum";
    private static final String DB_USER = "admin";
    private static final String DB_PASS = "admin";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "register" -> registerUser(request, response);
                case "login" -> loginUser(request, response);
                case "postComment" -> postComment(request, response);
                case "createTopic" -> createTopic(request, response);
                case "postReply" -> postReply(request, response);
            }
        }
    }
    
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.executeUpdate();
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
   private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
        String sql = "SELECT id FROM users WHERE email=? AND password=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("id");

            HttpSession session = request.getSession();  // Ensure session is created
            session.setAttribute("user_id", userId); // Store user_id in session

            response.sendRedirect("home.jsp"); // Redirect after login
        } else {
            response.getWriter().println("Invalid credentials");
        }
    } catch (SQLException e) {
        response.getWriter().println("Error: " + e.getMessage());
    }
}

    
    private void createTopic(HttpServletRequest request, HttpServletResponse response) throws IOException {
          HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("user_id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO topics (user_id, title, description) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, description);
            stmt.executeUpdate();
            response.sendRedirect("home.jsp");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void postComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("user_id");
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        String text = request.getParameter("text");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO comments (topic_id, user_id, text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, topicId);
            stmt.setInt(2, userId);
            stmt.setString(3, text);
            stmt.executeUpdate();
            response.sendRedirect("view_topic.jsp?topicId=" + topicId);
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void postReply(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("user_id");
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String text = request.getParameter("text");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO replies (comment_id, user_id, text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, commentId);
            stmt.setInt(2, userId);
            stmt.setString(3, text);
            stmt.executeUpdate();
            response.sendRedirect("home.jsp");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
