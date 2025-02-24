import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/ResetPassord")
public class ResetPasswordServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display password reset form (usually resetPassword.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("/resetPassword.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve email and new password from the request
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        
        // Validate input (ensure it's not empty)
        if (email == null || email.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Email and new password cannot be empty.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/resetPassword.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        // Use the DBUtils class to interact with the database and update the password
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            
            int rowsUpdated = stmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                // Password updated successfully, redirect to the login page
                response.sendRedirect("login.jsp");
            } else {
                // User not found or some error occurred
                request.setAttribute("error", "User with this email not found.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/resetPassword.jsp");
                dispatcher.forward(request, response);
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error occurred while resetting password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/resetPassword.jsp");
            dispatcher.forward(request, response);
        }
    }
}
