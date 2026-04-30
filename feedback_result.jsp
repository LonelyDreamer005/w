<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Submission Result</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .result-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 600px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .success-message {
            background: #e8f5e9;
            color: #388e3c;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 18px;
        }

        .error-message {
            background: #ffebee;
            color: #d32f2f;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 16px;
        }

        .thank-you {
            background: #e3f2fd;
            padding: 20px;
            border-left: 4px solid #2196F3;
            margin-bottom: 30px;
            border-radius: 5px;
        }

        .thank-you p {
            color: #1976D2;
            font-size: 16px;
            line-height: 1.6;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        table th,
        table td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: left;
        }

        table th {
            background-color: #667eea;
            color: white;
            font-weight: bold;
            width: 35%;
        }

        table td {
            background-color: #f9f9f9;
        }

        .rating-badge {
            display: inline-block;
            background: #FFD700;
            color: #333;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            text-align: center;
            min-width: 30px;
        }

        .actions {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .actions a,
        .actions button {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .actions .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .actions .btn-secondary {
            background: #f0f0f0;
            color: #333;
            border: 1px solid #ddd;
        }

        .actions a:hover,
        .actions button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .footer-note {
            text-align: center;
            color: #666;
            font-size: 12px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>

<body>

<div class="result-container">
    
    <!-- ========== HEADER ========== -->
    <div class="header">
        <h1>Feedback Submission</h1>
    </div>

    <%
        // ========== JSP CODE: Retrieve data from request attributes ==========
        // Servlet set these attributes via request.setAttribute()
        
        String name = (String) request.getAttribute("name");
        String email = (String) request.getAttribute("email");
        String course = (String) request.getAttribute("course");
        String rating = (String) request.getAttribute("rating");
        Boolean isValid = (Boolean) request.getAttribute("isValid");
        String errorMessage = (String) request.getAttribute("errorMessage");
        
        // Default values if attributes are null
        if (name == null) name = "";
        if (email == null) email = "";
        if (course == null) course = "";
        if (rating == null) rating = "";
        if (isValid == null) isValid = false;
        if (errorMessage == null) errorMessage = "";
        
        // ========== STEP 1: Check if form was valid ==========
        if (isValid) {
            // ========== VALID SUBMISSION: Show thank you message ==========
    %>
    
        <div class="success-message">
            ✓ Thank You for Your Feedback!
        </div>

        <div class="thank-you">
            <p>
                Dear <%= name %>,<br><br>
                We appreciate your valuable feedback on the <%= course %> course. 
                Your input helps us improve our teaching and educational quality. 
                We have recorded your submission and will review it shortly.
            </p>
        </div>

        <!-- ========== SUBMITTED DATA TABLE ========== -->
        <table>
            <tr>
                <th>Field</th>
                <th>Your Response</th>
            </tr>
            <tr>
                <td><strong>Name</strong></td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td><strong>Email</strong></td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td><strong>Course</strong></td>
                <td><%= course %></td>
            </tr>
            <tr>
                <td><strong>Rating</strong></td>
                <td>
                    <span class="rating-badge"><%= rating %>/5</span>
                    <%
                        // ========== RATING INTERPRETATION ==========
                        int ratingValue = Integer.parseInt(rating);
                        String ratingText = "";
                        
                        if (ratingValue == 1) ratingText = " (Poor)";
                        else if (ratingValue == 2) ratingText = " (Fair)";
                        else if (ratingValue == 3) ratingText = " (Good)";
                        else if (ratingValue == 4) ratingText = " (Very Good)";
                        else if (ratingValue == 5) ratingText = " (Excellent)";
                    %>
                    <%= ratingText %>
                </td>
            </tr>
        </table>

        <!-- ========== ACTION BUTTONS ========== -->
        <div class="actions">
            <a href="1.html" class="btn-primary">Submit Another Feedback</a>
            <a href="index.html" class="btn-secondary">Back to Home</a>
        </div>

    <%
        } else {
            // ========== INVALID SUBMISSION: Show error message ==========
    %>
    
        <div class="error-message">
            ❌ Submission Failed - Validation Error
        </div>

        <div class="error-message" style="background: #fff3e0; color: #e65100; margin-bottom: 20px;">
            <strong>Error Details:</strong><br>
            <%= errorMessage %>
        </div>

        <!-- ========== FORM DATA (for reference) ========== -->
        <table>
            <tr>
                <th>Field</th>
                <th>Your Entry</th>
            </tr>
            <tr>
                <td><strong>Name</strong></td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td><strong>Email</strong></td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td><strong>Course</strong></td>
                <td><%= course %></td>
            </tr>
            <tr>
                <td><strong>Rating</strong></td>
                <td><%= rating %></td>
            </tr>
        </table>

        <!-- ========== ACTION BUTTONS ========== -->
        <div class="actions">
            <a href="1.html" class="btn-primary">Go Back & Correct Form</a>
            <a href="index.html" class="btn-secondary">Back to Home</a>
        </div>

    <%
        }
    %>

    <div class="footer-note">
        <p>Submission Date & Time: <%= new java.util.Date() %></p>
        <p>Session ID: <%= session.getId() %></p>
    </div>

</div>

</body>
</html>

<%--
========== EXPLANATION: JSP TAGS & EXPRESSIONS ==========

JSP (JavaServer Pages) allows mixing Java code with HTML:

1. <% ... %> (Scriptlet)
   - Java code block
   - Example: <% int x = 5; %>

2. <%= ... %> (Expression)
   - Outputs value to HTML
   - Example: <%= name %> prints the value of variable 'name'

3. <%-- ... --%> (Comment)
   - JSP comment (not visible in HTML source)

4. request.getAttribute("key")
   - Retrieves data set by Servlet
   - Servlet: request.setAttribute("name", "John");
   - JSP: <%= request.getAttribute("name") %> outputs "John"

5. session.getId()
   - Gets unique session identifier
   - Useful for tracking users across requests

6. new java.util.Date()
   - Creates current date/time object
   - Automatically formatted when printed

========== DATA FLOW ==========

User fills 1.html form
         ↓
Clicks "Submit Feedback"
         ↓
JavaScript validateForm() checks client-side
         ↓
Form POSTs to FeedbackServlet
         ↓
Servlet extracts parameters via request.getParameter()
         ↓
Servlet validates on server-side
         ↓
Servlet sets request attributes via request.setAttribute()
         ↓
Servlet forwards to feedback_result.jsp
         ↓
JSP retrieves attributes via request.getAttribute()
         ↓
JSP outputs HTML with submitted data
         ↓
Browser displays results page
--%>
