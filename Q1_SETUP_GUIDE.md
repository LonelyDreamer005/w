# QUESTION 1: STUDENT FEEDBACK FORM - COMPLETE SETUP GUIDE

> **Form Validation + Servlet/JSP Backend** — Integrating Client-Side HTML/JavaScript with Server-Side Java Processing

---

## 📌 Overview

**What:** Student Feedback Form with HTML input validation, Servlet backend processing, and JSP results display.

**Files:**
- `1.html` — HTML form + CSS styling + JavaScript validation
- `FeedbackServlet.java` — Backend servlet (process form data)
- `feedback_result.jsp` — Results display page
- `web.xml` — Servlet mapping (optional if using annotations)

**Tech Stack:**
- **Frontend:** HTML5, CSS3, JavaScript (ES6)
- **Backend:** Java Servlet, JSP (JavaServer Pages)
- **Server:** Apache Tomcat (Week 7 requirement)

---

## 🎯 Data Flow Architecture

```
┌─────────────────────┐
│   1.html            │
│ (Client-Side)       │
│                     │
│ • HTML Form         │
│ • CSS Styling       │
│ • JS Validation     │
└──────────┬──────────┘
           │
    User fills form
    & clicks Submit
           │
           ↓
  ┌────────────────────────────┐
  │ JavaScript validateForm()   │
  │ (Client-Side Validation)    │
  │                             │
  │ ✓ Name not empty            │
  │ ✓ Email format valid        │
  │ ✓ Course selected           │
  │ ✓ Rating selected           │
  └──────────┬──────────────────┘
             │
      All validations pass?
             │
      ┌──────┴──────┐
    NO│             │YES
      │             │
      ↓             ↓
  Stay on    POST to
  1.html     FeedbackServlet
      │             │
      │             ↓
      │      ┌──────────────────────────┐
      │      │ FeedbackServlet (doPost) │
      │      │ (Server-Side)            │
      │      │                          │
      │      │ • Extract parameters     │
      │      │ • Validate on server     │
      │      │ • Set request attributes │
      │      │ • Forward to JSP         │
      │      └────────────┬─────────────┘
      │                   │
      │      ┌────────────┴─────────────┐
      │      │                          │
      │      ↓                          ↓
      │   VALID                      INVALID
      │      │                          │
      │      ↓                          ↓
      │  ┌─────────────────┐    ┌──────────────────┐
      │  │ Thank You Page  │    │ Error Message    │
      │  │ Display Results │    │ Submitted Data   │
      │  │ in Table        │    │ (for correction) │
      │  └─────────────────┘    └──────────────────┘
      │      │                          │
      └──────┴──────────────────────────┘
             │
             ↓
    ┌─────────────────────────────┐
    │ feedback_result.jsp         │
    │ (JSP Results Display)       │
    │                             │
    │ • Shows submitted data      │
    │ • Thank you message         │
    │ • Links to submit more      │
    └─────────────────────────────┘
```

---

## 📂 Project Structure (Tomcat Deployment)

```
MyWebProject/
├── src/
│   └── FeedbackServlet.java          ← Place here (compiles to WEB-INF/classes)
│
├── WebContent/
│   ├── 1.html                        ← HTML form
│   ├── feedback_result.jsp           ← JSP results
│   │
│   └── WEB-INF/
│       ├── web.xml                   ← Servlet mapping (if not using @WebServlet)
│       └── classes/
│           └── FeedbackServlet.class ← Compiled servlet (auto-generated)
```

---

## ⚙️ Setup Steps

### **STEP 1: Create Tomcat Project in Eclipse**

1. **File** → **New** → **Dynamic Web Project**
2. **Project name:** `StudentFeedbackApp`
3. **Target runtime:** Apache Tomcat v8.0 (or your version)
4. **Dynamic web module version:** 3.0
5. **Click Finish**

---

### **STEP 2: Add 1.html to WebContent**

1. Copy [1.html](1.html) content
2. Create new file: **Right-click WebContent** → **New** → **HTML File**
3. Filename: `1.html`
4. Paste content
5. **Save**

---

### **STEP 3: Compile and Place FeedbackServlet.java**

1. Copy [FeedbackServlet.java](FeedbackServlet.java) content
2. Create new file: **Right-click src** → **New** → **Class**
3. Filename: `FeedbackServlet`
4. Paste content
5. **Save** (Eclipse auto-compiles to WEB-INF/classes/FeedbackServlet.class)

⭐ **Important:** Make sure the package is correct. If FeedbackServlet is in a package (e.g., `com.app`), update:
- HTML form action: `action="http://localhost:8080/StudentFeedbackApp/servlet/com.app.FeedbackServlet"`
- Or update `web.xml` accordingly

---

### **STEP 4: Add feedback_result.jsp**

1. Copy [feedback_result.jsp](feedback_result.jsp) content
2. Create new file: **Right-click WebContent** → **New** → **JSP File**
3. Filename: `feedback_result.jsp`
4. Paste content
5. **Save**

---

### **STEP 5: Configure Servlet Mapping in web.xml**

**Option A: Using web.xml (Traditional)**

Edit `WebContent/WEB-INF/web.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
         http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">

    <!-- ========== SERVLET DECLARATION ========== -->
    <servlet>
        <servlet-name>FeedbackServlet</servlet-name>
        <servlet-class>FeedbackServlet</servlet-class>
        <!-- If servlet is in package com.app:
             <servlet-class>com.app.FeedbackServlet</servlet-class>
        -->
    </servlet>

    <!-- ========== SERVLET URL MAPPING ========== -->
    <servlet-mapping>
        <servlet-name>FeedbackServlet</servlet-name>
        <url-pattern>/FeedbackServlet</url-pattern>
        <!-- Access at: http://localhost:8080/StudentFeedbackApp/FeedbackServlet -->
    </servlet-mapping>

    <!-- ========== WELCOME FILE (Optional) ========== -->
    <welcome-file-list>
        <welcome-file>1.html</welcome-file>
        <welcome-file>index.html</welcome-file>
    </welcome-file-list>

</web-app>
```

**Option B: Using Annotations (Modern, Requires Java 6+)**

Add above FeedbackServlet class declaration:

```java
@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    // ...
}
```

Then web.xml can be minimal. Choose **ONE approach** (not both).

---

### **STEP 6: Update 1.html Form Action URL**

In [1.html](1.html), find the form element and update the action URL:

```html
<form id="feedbackForm" 
      method="POST" 
      action="http://localhost:8080/StudentFeedbackApp/FeedbackServlet"
      onsubmit="return validateForm()">
```

**URL Format:**
```
http://localhost:8080/ProjectName/ServletMapping
                     ↓            ↓
                  Port        from web.xml <url-pattern>
```

---

### **STEP 7: Deploy & Run**

1. **Right-click Project** → **Run As** → **Run on Server**
2. Select **Apache Tomcat v8.0**
3. Click **Finish**
4. Browser opens: `http://localhost:8080/StudentFeedbackApp/1.html`

---

## 🧪 Testing Checklist

### **Test Case 1: Valid Submission**
```
Input:
- Name: "John Doe"
- Email: "john@example.com"
- Course: "Web Technology"
- Rating: "5"

Expected Output:
✓ "Thank You for Your Feedback!"
✓ Data displayed in table
✓ Links to submit more or go home
```

### **Test Case 2: Missing Name**
```
Input:
- Name: (empty)
- Email: "john@example.com"
- Course: "Web Technology"
- Rating: "5"

Expected Output:
✓ Red error: "Name is required"
✓ Form does NOT submit
✓ Page stays on 1.html
```

### **Test Case 3: Invalid Email**
```
Input:
- Name: "John Doe"
- Email: "john@invalid"  (missing .com)
- Course: "Web Technology"
- Rating: "5"

Expected Output:
✓ Red error: "Please enter a valid email address"
✓ Form does NOT submit
```

### **Test Case 4: Missing Course**
```
Input:
- Name: "John Doe"
- Email: "john@example.com"
- Course: (select default)
- Rating: "5"

Expected Output:
✓ Red error: "Please select a course"
```

### **Test Case 5: Missing Rating**
```
Input:
- Name: "John Doe"
- Email: "john@example.com"
- Course: "Web Technology"
- Rating: (no selection)

Expected Output:
✓ Red error: "Please select a rating"
```

---

## 🔑 Key Code Explanations

### **JavaScript Form Validation (1.html)**

```javascript
// ========== EMAIL REGEX VALIDATION ==========
let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//                ↓
// [^\s@]+ = One or more chars that are NOT whitespace or @
// @ = Literal @ symbol
// \. = Literal dot (escaped; . normally matches any char)
// [^\s@]+ = Domain
// [^\s@]+ = TLD (.com, .org, etc.)

// Valid emails:
// ✓ user@example.com
// ✓ john.doe@company.co.uk
// ✓ test123@domain.org

// Invalid emails:
// ✗ user@
// ✗ user.example.com (missing @)
// ✗ user @example.com (space before @)
```

### **Servlet Form Processing (FeedbackServlet.java)**

```java
// ========== STEP 1: Get form data from request ==========
String name = request.getParameter("name");
//   ↓ MUST match HTML <input name="name">

// ========== STEP 2: Validate on server ==========
if (name == null || name.trim().isEmpty()) {
    // Invalid!
}

// ========== STEP 3: Set request attributes for JSP ==========
request.setAttribute("name", name);
//   ↓ JSP accesses via <%= name %> or ${name}

// ========== STEP 4: Forward to JSP ==========
RequestDispatcher dispatcher = request.getRequestDispatcher("feedback_result.jsp");
dispatcher.forward(request, response);
//   ↓ JSP receives request object with attributes
```

### **JSP Results Display (feedback_result.jsp)**

```jsp
<%
    // ========== RETRIEVE DATA FROM SERVLET ==========
    String name = (String) request.getAttribute("name");
    
    // ========== CONDITIONAL LOGIC ==========
    if (isValid) {
        // Show thank you & results
    } else {
        // Show error message
    }
%>

<!-- ========== OUTPUT DATA IN HTML ========== -->
<p>Hello <%= name %>!</p>
```

---

## 🔗 Connection Points (⭐ Important)

### **HTML Form ↔ Servlet**

| Component | HTML Name | Servlet Access |
|-----------|-----------|-----------------|
| Name input | `<input name="name">` | `request.getParameter("name")` |
| Email input | `<input name="email">` | `request.getParameter("email")` |
| Course dropdown | `<select name="course">` | `request.getParameter("course")` |
| Rating radio | `<input name="rating">` | `request.getParameter("rating")` |

⭐ **Key Rule:** HTML `name` attribute MUST match Servlet `getParameter()` argument.

### **Servlet ↔ JSP**

| Servlet Sets | JSP Retrieves |
|-------------|-----------------|
| `request.setAttribute("name", value)` | `<%= request.getAttribute("name") %>` |
| `request.setAttribute("isValid", true)` | `<% if (isValid) { ... } %>` |

⭐ **Key Rule:** Attribute name MUST match exactly.

### **Form Action URL**

HTML form submits to: `<form action="http://localhost:8080/ProjectName/FeedbackServlet">`

Which maps to: `web.xml <url-pattern>/FeedbackServlet</url-pattern>`

Which routes to: Servlet with `@WebServlet("/FeedbackServlet")` or `<servlet-mapping>`

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| **404 error on form submit** | Check Tomcat is running; verify project name in URL; check web.xml mapping |
| **Servlet not found** | Ensure FeedbackServlet.java compiled to WEB-INF/classes/; check servlet-class in web.xml |
| **JSP shows blank page** | Check feedback_result.jsp in WebContent/; verify forward path in Servlet |
| **Form submits but page doesn't change** | Check browser console for JavaScript errors; verify validateForm() returns true/false |
| **Validation not working** | Verify email regex pattern; check JavaScript console for errors |
| **Data not passed to JSP** | Verify request.setAttribute() in Servlet; check JSP retrieval syntax |

---

## 📚 Connection to Previous Labs

This Question 1 integrates concepts from:

- **WEEK-1 to 3:** HTML form design, CSS styling, JavaScript validation
- **WEEK-7:** Tomcat server setup (required for deployment)
- **WEEK-8:** Servlet development (FeedbackServlet)
- **WEEK-9:** JSP development + User authentication (feedback_result.jsp)

---

## 📝 Summary Checklist

- [ ] Create Tomcat project in Eclipse
- [ ] Copy 1.html to WebContent/
- [ ] Copy FeedbackServlet.java to src/ (auto-compiles)
- [ ] Copy feedback_result.jsp to WebContent/
- [ ] Update form action URL in 1.html
- [ ] Configure web.xml (servlet mapping)
- [ ] Deploy to Tomcat
- [ ] Test all 5 test cases above
- [ ] Verify form validation works (client-side)
- [ ] Verify Servlet receives data and forwards to JSP
- [ ] Verify JSP displays results or error messages

---

## 🎓 Learning Outcomes

After completing Q1, you'll understand:

✓ HTML form design with validation rules  
✓ JavaScript client-side validation  
✓ Servlet request/response handling  
✓ Form parameter extraction (`getParameter()`)  
✓ Request attribute forwarding to JSP (`setAttribute()`, `getAttribute()`)  
✓ JSP data display with conditional logic  
✓ Servlet ↔ JSP communication  
✓ Server-side validation for security  
✓ HTML form action → Servlet mapping  

---

**Last Updated:** April 2026 | **Version:** 1.0 Complete Guide
