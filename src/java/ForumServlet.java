import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;

import java.sql.*;

public class ForumServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/topic_forum";
    private static final String DB_USER = "admin";
    private static final String DB_PASS = "admin";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (null != action) switch (action) {
            case "register" -> registerUser(request, response);
            case "login" -> loginUser(request, response);
            case "postComment" -> postComment(request, response);
            case "createTopic" -> createTopic(request, response);
            case "postReply" -> postReply(request, response);
            case "updateUser" -> updateUser(request, response);
            default -> {
            }
        }
    }
    
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.executeUpdate();
            response.getWriter().println("User registered successfully");
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                response.getWriter().println("Login successful");
                session.setAttribute("userId", rs.getInt("userId"));
                response.sendRedirect("home.jsp");
            } else {
                response.getWriter().println("Invalid credentials");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void createTopic(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO topics (user_id, title, description) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, description);
            stmt.executeUpdate();
            response.getWriter().println("Topic created successfully");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void postComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String topicId = request.getParameter("topicId");
        String userId = request.getParameter("userId");
        String text = request.getParameter("text");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO comments (topic_id, user_id, text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, topicId);
            stmt.setString(2, userId);
            stmt.setString(3, text);
            stmt.executeUpdate();
            logActivity("Comment", userId, text);
            response.getWriter().println("Comment posted successfully");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void postReply(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String commentId = request.getParameter("commentId");
        String userId = request.getParameter("userId");
        String text = request.getParameter("text");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO replies (comment_id, user_id, text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, commentId);
            stmt.setString(2, userId);
            stmt.setString(3, text);
            stmt.executeUpdate();
            logActivity("Reply", userId, text);
            response.getWriter().println("Reply posted successfully");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        String email = request.getParameter("email");
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "UPDATE users SET email=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, userId);
            stmt.executeUpdate();
            response.getWriter().println("User information updated successfully");
        } catch (SQLException e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    
    private void logActivity(String type, String userId, String text) {
        try (FileWriter fw = new FileWriter("forum_log.txt", true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.println(type + " - User ID: " + userId + ", Text: " + text);
        } catch (IOException e) {
        }
    }
}
