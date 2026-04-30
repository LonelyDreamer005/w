# � WEB TECHNOLOGY TEST PREPARATION

> **5 Practice Questions with Complete Solutions | Test-Focused Guide**

This package contains **5 test questions** with full implementations and explanations. Use this to understand and prepare for your test.

---

## 🎯 Quick Navigation (By Question)

| Question | Topic | What to Study | Solution |
|----------|-------|---------------|----------|
| **Q1** | Form Validation + Servlet/JSP | HTML forms, JavaScript validation, Servlet backend | [1.html](1.html), [FeedbackServlet.java](FeedbackServlet.java), [feedback_result.jsp](feedback_result.jsp) |
| **Q2** | XML + JavaScript Data Display | XMLHttpRequest, XML parsing, filtering | [2.html](2.html), [laptops.xml](laptops.xml) |
| **Q3** | Marks Calculator | Form inputs, arithmetic, conditionals | [3.html](3.html) |
| **Q4** | Product Billing | Arrays, loops, dynamic calculations | [4.html](4.html) |
| **Q5** | Blog Layout + Dark Mode | CSS Flexbox, CSS class toggling, theming | [5.html](5.html) |

---

## 📂 What You Have

**8 Solution Files** (Ready to Study/Test)
- `1.html` → Form validation example (HTML/CSS/JS)
- `2.html` → XML filtering example (HTML/CSS/JS)
- `3.html` → Calculator example (HTML/JS)
- `4.html` → Billing example (HTML/JS)
- `5.html` → Blog layout example (HTML/CSS/JS)
- `FeedbackServlet.java` → Backend form processor (Java)
- `feedback_result.jsp` → Results display (JSP)
- `laptops.xml` → Sample XML data

**4 Study Guides** (What to Read)
- `WEB_TECH_PRACTICE_GUIDE.md` → Q2-Q5 detailed explanations with code breakdown
- `Q1_SETUP_GUIDE.md` → Q1 Servlet/JSP explanation and setup
- `QUICK_START_REFERENCE.md` → Quick reference and key code patterns
- `COMPLETE_IMPLEMENTATION_GUIDE.md` → Complete architecture reference

---

## ❓ The 5 Test Questions (What You Need to Know)

### **Question 1: Form Validation + Servlet/JSP**

**What's Being Asked?**
Design a Student Feedback Form with:
- HTML form with Name, Email, Course, Rating fields
- JavaScript validation (empty check, email format check)
- Servlet to process form data
- JSP page to display results

**Key Concepts to Study:**
- HTML form fields and attributes
- JavaScript validation (regex, empty checks)
- Servlet `doPost()` method and `request.getParameter()`
- JSP variable display with `<%= %>`
- `RequestDispatcher` for forwarding

**Where to Find Solution:**
- HTML/CSS/JS: [1.html](1.html)
- Backend: [FeedbackServlet.java](FeedbackServlet.java)
- Display: [feedback_result.jsp](feedback_result.jsp)
- Detailed Explanation: [Q1_SETUP_GUIDE.md](Q1_SETUP_GUIDE.md)

**Email Validation Pattern (Important!):**
```javascript
let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(email)) { /* invalid */ }
```

---

### **Question 2: XML + JavaScript Data Display**

**What's Being Asked?**
Create an HTML page that:
- Reads data from an XML file (5+ laptop records)
- Displays data in an HTML table
- Filters results using a dropdown (by processor type)

**Key Concepts to Study:**
- XML file structure (elements, attributes)
- XMLHttpRequest to fetch XML
- `getElementsByTagName()` to parse XML
- Loop through data and apply filters
- Dynamic table generation with `innerHTML`

**Where to Find Solution:**
- HTML/CSS/JS: [2.html](2.html)
- XML Data: [laptops.xml](laptops.xml)
- Detailed Explanation: [WEB_TECH_PRACTICE_GUIDE.md - Q2](WEB_TECH_PRACTICE_GUIDE.md#question-2-xml--javascript-data-display)

**Key Pattern (XMLHttpRequest):**
```javascript
let xhr = new XMLHttpRequest();
xhr.open("GET", "file.xml", true);
xhr.onload = function() {
    let xml = xhr.responseXML;
    let items = xml.getElementsByTagName("item");
    // Process items
};
xhr.send();
```

---

### **Question 3: Marks Calculator**

**What's Being Asked?**
Create a webpage where:
- User enters marks for 5 subjects
- JavaScript calculates: Total, Average, Grade
- Results display in a table when button is clicked

**Key Concepts to Study:**
- Form input handling with `getElementById()` and `.value`
- Number conversion with `Number()`
- Arithmetic operations (sum, division)
- Conditional logic for grading (if/else if/else)
- Updating DOM with `.innerHTML`

**Where to Find Solution:**
- HTML/JS: [3.html](3.html)
- Detailed Explanation: [WEB_TECH_PRACTICE_GUIDE.md - Q3](WEB_TECH_PRACTICE_GUIDE.md#question-3-marks-calculator)

**Grading Logic (Study This!):**
```javascript
let avg = total / 5;
if (avg >= 90) grade = "A";
else if (avg >= 75) grade = "B";
else if (avg >= 50) grade = "C";
else grade = "Fail";
```

---

### **Question 4: Product Billing**

**What's Being Asked?**
Create a billing page with:
- 4+ products with price and quantity fields
- Calculate subtotal for each product
- Calculate grand total dynamically
- Prevent negative quantities

**Key Concepts to Study:**
- Parallel arrays (prices array matching quantity inputs)
- `querySelectorAll()` to select multiple elements
- Loops to process all products
- Accumulator pattern for totals
- Input validation (prevent negative)

**Where to Find Solution:**
- HTML/JS: [4.html](4.html)
- Detailed Explanation: [WEB_TECH_PRACTICE_GUIDE.md - Q4](WEB_TECH_PRACTICE_GUIDE.md#question-4-product-billing)

**Key Pattern (Loop with Accumulation):**
```javascript
let prices = [100, 200, 150, 50];
let quantities = document.querySelectorAll("input");
let total = 0;
for (let i = 0; i < quantities.length; i++) {
    let qty = parseInt(quantities[i].value);
    if (qty < 0) qty = 0;  // Prevent negative
    total += qty * prices[i];
}
```

---

### **Question 5: Blog Layout + Dark Mode**

**What's Being Asked?**
Design a blog webpage with:
- Header, Navigation, Article, Sidebar, Footer layout
- CSS styling (use Flexbox for responsive layout)
- Dark mode toggle button
- Smooth color transitions

**Key Concepts to Study:**
- Semantic HTML structure
- CSS Flexbox (`display: flex`, `flex: 3`, `flex: 1`)
- CSS class selectors (`.dark { }`)
- JavaScript `classList.toggle()` for theme switching
- CSS transitions for smooth animations

**Where to Find Solution:**
- HTML/CSS/JS: [5.html](5.html)
- Detailed Explanation: [WEB_TECH_PRACTICE_GUIDE.md - Q5](WEB_TECH_PRACTICE_GUIDE.md#question-5-blog-layout--dark-mode)

**Dark Mode Toggle (Important!):**
```javascript
function toggleMode() {
    document.getElementById("body").classList.toggle("dark");
}
```

**Flexbox Layout Pattern:**
```css
.container {
    display: flex;
}
article { flex: 3; }  /* 3 parts */
aside { flex: 1; }    /* 1 part */
```

---

## 📚 How to Prepare for the Test

### **Quick Method (30 minutes)**
1. Read this file (README.md)
2. Open each HTML file in browser and test it
3. Review the code comments in each file

### **Thorough Method (2-3 hours)**
1. Read this file (README.md)
2. Read [WEB_TECH_PRACTICE_GUIDE.md](WEB_TECH_PRACTICE_GUIDE.md) for Q2-Q5
3. Read [Q1_SETUP_GUIDE.md](Q1_SETUP_GUIDE.md) for Q1
4. Open and test each solution file
5. Review key code patterns below

---

## ⭐ Key Code Patterns (Must Know for Test)

### **Email Validation (Q1)**
```javascript
let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(email)) {
    // Email invalid
}
```

### **XMLHttpRequest - Fetch XML Data (Q2)**
```javascript
let xhr = new XMLHttpRequest();
xhr.open("GET", "data.xml", true);
xhr.onload = function() {
    let xml = xhr.responseXML;
    let items = xml.getElementsByTagName("item");
    // Process items
};
xhr.send();
```

### **Arithmetic & Conditional Logic (Q3)**
```javascript
let total = m1 + m2 + m3 + m4 + m5;
let avg = total / 5;
if (avg >= 90) grade = "A";
else if (avg >= 75) grade = "B";
else if (avg >= 50) grade = "C";
else grade = "Fail";
```

### **Loops with Accumulation (Q4)**
```javascript
let total = 0;
for (let i = 0; i < quantities.length; i++) {
    let sub = qty[i] * prices[i];
    total += sub;  // Accumulation pattern
}
```

### **CSS Flexbox Layout (Q5)**
```css
.container {
    display: flex;
}
article { flex: 3; }  /* 75% width */
aside { flex: 1; }    /* 25% width */
```

### **Dark Mode Toggle (Q5)**
```javascript
function toggleMode() {
    document.getElementById("body").classList.toggle("dark");
}
```

### **Servlet Form Processing (Q1)**
```java
String name = request.getParameter("name");
request.setAttribute("name", name);
RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
dispatcher.forward(request, response);
```

### **JSP Display Data (Q1)**
```jsp
<%
    String name = (String) request.getAttribute("name");
%>
<p>Hello <%= name %></p>
```

---

## ✅ Test Preparation Checklist

Before your test, make sure you understand:

### **Question 1: Form Validation + Servlet/JSP**
- [ ] How HTML form `name` attributes connect to Servlet
- [ ] Email regex pattern: `/^[^\s@]+@[^\s@]+\.[^\s@]+$/`
- [ ] `request.getParameter("fieldName")` extraction
- [ ] `request.setAttribute()` and `request.getAttribute()`
- [ ] `RequestDispatcher.forward()` for server-side forwarding
- [ ] JSP `<%= %>` syntax for displaying variables

### **Question 2: XML + Filtering**
- [ ] XMLHttpRequest flow: open → onload → send
- [ ] `xhr.responseXML` returns DOM tree
- [ ] `getElementsByTagName()` to find elements
- [ ] `.textContent` to get element text
- [ ] Filtering logic: `if (value === "filter" || value === "all")`
- [ ] Building HTML with template literals (backticks)

### **Question 3: Marks Calculator**
- [ ] Reading form input values with `.value`
- [ ] Converting strings to numbers with `Number()`
- [ ] Arithmetic: sum, division
- [ ] Conditional logic for grading
- [ ] Updating DOM with `.innerHTML`

### **Question 4: Product Billing**
- [ ] Parallel arrays: `prices[i]` matches `qty[i]`
- [ ] `querySelectorAll()` for multiple elements
- [ ] Loop pattern: `for (let i = 0; i < items.length; i++)`
- [ ] Accumulator pattern: `total += value`
- [ ] Preventing negative values: `if (qty < 0) qty = 0`

### **Question 5: Blog Layout**
- [ ] Semantic HTML: `<header>`, `<nav>`, `<article>`, `<aside>`, `<footer>`
- [ ] CSS Flexbox: `display: flex`, `flex: 3`, `flex: 1`
- [ ] CSS class selectors: `.dark { background: black; }`
- [ ] `classList.toggle()` to add/remove classes
- [ ] CSS transitions for smooth animations

---

## 🧪 Quick Test Your Knowledge

**Can you answer these?** (If not, review the guide)

1. **Q1:** What's the regex for email validation?
2. **Q2:** What does `xhr.responseXML` return?
3. **Q3:** Write the grading logic for A(>=90), B(>=75), C(>=50)
4. **Q4:** What's the accumulator pattern in a loop?
5. **Q5:** How do you toggle a CSS class with JavaScript?

**Answers in:**
- Q1: [Q1_SETUP_GUIDE.md](Q1_SETUP_GUIDE.md) - Email Validation section
- Q2: [WEB_TECH_PRACTICE_GUIDE.md - Q2](WEB_TECH_PRACTICE_GUIDE.md#question-2-xml--javascript-data-display)
- Q3: [WEB_TECH_PRACTICE_GUIDE.md - Q3](WEB_TECH_PRACTICE_GUIDE.md#question-3-marks-calculator)
- Q4: [WEB_TECH_PRACTICE_GUIDE.md - Q4](WEB_TECH_PRACTICE_GUIDE.md#question-4-product-billing)
- Q5: [WEB_TECH_PRACTICE_GUIDE.md - Q5](WEB_TECH_PRACTICE_GUIDE.md#question-5-blog-layout--dark-mode)

---

## 📖 What Each Guide Covers

| Guide | What It Explains | Read This For |
|-------|------------------|-----------------|
| **WEB_TECH_PRACTICE_GUIDE.md** | Q2, Q3, Q4, Q5 detailed code explanations | Understanding how each solution works |
| **Q1_SETUP_GUIDE.md** | Q1 Servlet/JSP explanation and setup | Understanding forms, validation, backend |
| **QUICK_START_REFERENCE.md** | Key concepts, patterns, quick reference | Quick lookup of patterns |
| **COMPLETE_IMPLEMENTATION_GUIDE.md** | Architecture and complete system design | Advanced understanding (optional) |
