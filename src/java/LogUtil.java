import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LogUtil {

    private static final String LOG_FILE = "logs/forum.log"; // Log file location

    // Method to log events (e.g., new comment or reply)
    public static void log(String action, String details) {
        try (FileWriter fileWriter = new FileWriter(LOG_FILE, true);
             PrintWriter printWriter = new PrintWriter(fileWriter)) {
            
            // Get the current date and time
            String currentDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            
            // Write the log entry with timestamp, action, and details
            printWriter.printf("%s - %s: %s%n", currentDate, action, details);
        } catch (IOException e) {
            System.err.println("Error writing to log file: " + e.getMessage());
        }
    }
}
