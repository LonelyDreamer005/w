import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * ========== STUDENT FEEDBACK SERVLET ==========
 * 
 * Purpose: Handle form submission from 1.html
 *          - Receive student feedback data
 *          - Validate and process on server side
 *          - Forward to JSP for display
 * 
 * Servlet Lifecycle:
 * 1. Client submits form (1.html) → HTTP POST to this servlet
 * 2. doPost() method executes
 * 3. Extract parameters from request
 * 4. Optional: Store in database or validate on server side
 * 5. Set request attributes
 * 6. Forward to JSP for display
 */
public class FeedbackServlet extends HttpServlet {
    
    /**
     * doPost() method: Handles POST requests from HTML form
     * 
     * @param request - Contains form data from 1.html
     * @param response - Used to send response back to client
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ========== STEP 1: Set Response Character Encoding ==========
        response.setContentType("text/html;charset=UTF-8");
        //   ↓ Ensures special characters display correctly
        
        // ========== STEP 2: Extract Form Parameters from Request ==========
        // request.getParameter("fieldName") retrieves value from HTML form input
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String rating = request.getParameter("rating");
        
        // ⭐ KEY POINT: Parameter names MUST match HTML form field names
        // HTML: <input name="name"> → request.getParameter("name")
        // HTML: <select name="course"> → request.getParameter("course")
        
        // ========== STEP 3: Optional Server-Side Validation ==========
        // Client-side validation done in 1.html, but we can validate again here
        // for security and data integrity
        
        boolean isValid = true;
        String errorMessage = "";
        
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            isValid = false;
            errorMessage += "Name is required. ";
        }
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            isValid = false;
            errorMessage += "Email is required. ";
        }
        
        // Validate email format (same regex as client-side)
        String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        if (email != null && !email.matches(emailRegex)) {
            isValid = false;
            errorMessage += "Invalid email format. ";
        }
        
        // Validate course
        if (course == null || course.trim().isEmpty()) {
            isValid = false;
            errorMessage += "Course is required. ";
        }
        
        // Validate rating
        if (rating == null || rating.trim().isEmpty()) {
            isValid = false;
            errorMessage += "Rating is required. ";
        }
        
        // ========== STEP 4: Set Request Attributes (for JSP to access) ==========
        // request.setAttribute("key", value) makes data available to JSP
        // via request.getAttribute("key") or EL expression ${key}
        
        request.setAttribute("name", name != null ? name : "");
        request.setAttribute("email", email != null ? email : "");
        request.setAttribute("course", course != null ? course : "");
        request.setAttribute("rating", rating != null ? rating : "");
        request.setAttribute("isValid", isValid);
        request.setAttribute("errorMessage", errorMessage);
        
        // ========== STEP 5: Optional Database Storage ==========
        // In a real application:
        // - Establish database connection
        // - Insert data into Feedback table
        // - Handle exceptions
        // Example:
        /*
        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Connect to database
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college", 
                "root", 
                "password"
            );
            
            // Prepare SQL statement
            String sql = "INSERT INTO feedback (name, email, course, rating, submission_date) " +
                        "VALUES (?, ?, ?, ?, NOW())";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, course);
            ps.setString(4, rating);
            
            // Execute insert
            ps.executeUpdate();
            
            ps.close();
            con.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dbError", "Failed to store feedback in database");
        }
        */
        
        // ========== STEP 6: Forward to JSP ==========
        // RequestDispatcher allows server-side forwarding
        // (URL bar doesn't change; request object passed to JSP)
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("feedback_result.jsp");
        //                                                         ↑
        //                              JSP file to display results
        
        dispatcher.forward(request, response);
        //   ↓ JSP can now access data via request.getAttribute() or EL
        
        // ========== DIFFERENCE: Forward vs Redirect ==========
        // Forward: request.getRequestDispatcher("file.jsp").forward(req, res)
        //          - Server-side (URL bar unchanged)
        //          - Request object passed to JSP
        //          - Faster
        // 
        // Redirect: response.sendRedirect("file.jsp")
        //           - Client-side (URL bar changes)
        //           - New request created (no request attributes)
        //           - Used for different servers/external sites
    }
}

/**
 * ========== SERVLET MAPPING IN web.xml ==========
 * 
 * Add to web.xml:
 * 
 * <servlet>
 *     <servlet-name>FeedbackServlet</servlet-name>
 *     <servlet-class>FeedbackServlet</servlet-class>
 * </servlet>
 * 
 * <servlet-mapping>
 *     <servlet-name>FeedbackServlet</servlet-name>
 *     <url-pattern>/FeedbackServlet</url-pattern>
 * </servlet-mapping>
 * 
 * OR (Annotation-based, Java 6+):
 * @WebServlet("/FeedbackServlet")
 * above class declaration
 */
