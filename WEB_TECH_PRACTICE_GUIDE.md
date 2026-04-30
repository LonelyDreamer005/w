# WEB TECHNOLOGY PRACTICE QUESTIONS - COMPLETE GUIDE

> **Master Reference for Questions 2-5 with Implementation Breakdown, Code Patterns, and Key Concepts**

---

## 📑 Table of Contents
1. [Question 2: XML + JavaScript Data Display](#question-2-xml--javascript-data-display)
2. [Question 3: Marks Calculator](#question-3-marks-calculator)
3. [Question 4: Product Billing](#question-4-product-billing)
4. [Question 5: Blog Layout + Dark Mode](#question-5-blog-layout--dark-mode)
5. [Key JavaScript Patterns](#key-javascript-patterns)
6. [Reusable Concepts](#reusable-concepts)

---

## Question 2: XML + JavaScript Data Display

### 📌 Problem Statement
Create an XML file with 5+ laptop details (brand, model, price, processor). Design an HTML page with CSS where JavaScript reads the XML file and displays data in a table. Include a dropdown filter by processor type.

### 🎯 Files Involved
- **laptops.xml** — Data source
- **2.html** — HTML page with filter UI and JavaScript

---

### **PHASE 1: XML Structure (laptops.xml)**

```xml
<laptops>
    <laptop>
        <brand>Dell</brand>
        <model>Inspiron 15</model>
        <price>55000</price>
        <processor>Intel i5</processor>
    </laptop>
    <!-- More laptops... -->
</laptops>
```

**Key Points:**
- Root element: `<laptops>`
- Each record: `<laptop>` with child elements
- Flat structure (no nesting) for easy DOM parsing
- Consistent element names for `getElementsByTagName()` queries

---

### **PHASE 2: HTML Structure (2.html)**

#### Semantic HTML Setup
```html
<h2>Laptop Details</h2>

<!-- FILTER DROPDOWN: Triggers loadData() on change -->
<select id="filter" onchange="loadData()">
    <option value="all">All</option>
    <option value="Intel i5">Intel i5</option>
    <option value="Intel i7">Intel i7</option>
    <option value="Ryzen 5">Ryzen 5</option>
    <option value="Ryzen 7">Ryzen 7</option>
</select>

<!-- RESULTS TABLE: tbody populated by JavaScript -->
<table>
    <thead>
        <tr>
            <th>Brand</th>
            <th>Model</th>
            <th>Price</th>
            <th>Processor</th>
        </tr>
    </thead>
    <tbody id="tableBody"></tbody>  <!-- ⭐ Dynamic insertion point -->
</table>
```

**Key Pattern:**
- `id="filter"` — Hook for dropdown (JavaScript can access)
- `id="tableBody"` — Placeholder for dynamic HTML
- `onchange="loadData()"` — Event binding (calls function when dropdown changes)

---

### **PHASE 3: CSS Styling**

```css
body {
    font-family: Arial;
    text-align: center;
}

table {
    border-collapse: collapse;    /* ⭐ Removes double borders */
    margin: 20px auto;             /* Center table vertically */
    width: 70%;
}

th, td {
    border: 1px solid black;
    padding: 10px;
}

th {
    background-color: lightgray;   /* Header distinction */
}

select {
    padding: 5px;                  /* Better UX for dropdown */
}
```

**Why `border-collapse: collapse`?**
- Without it: double borders between cells (border between `<td>` AND `<tr>`)
- With it: single border line (cleaner look)

---

### **PHASE 4: JavaScript Logic (⭐ CRITICAL)**

```javascript
function loadData() {
    // ========== STEP 1: Create XMLHttpRequest Object ==========
    let xhr = new XMLHttpRequest();
    
    // ========== STEP 2: Configure Request ==========
    xhr.open("GET", "laptops.xml", true);
    //          ↓      ↓               ↓
    //        METHOD  FILE          ASYNC (true = non-blocking)
    
    // ========== STEP 3: Define Success Handler ==========
    xhr.onload = function () {
        // Parse XML response
        let xml = xhr.responseXML;
        //   ↓ Returns DOM object from XML file
        
        // Get ALL <laptop> elements
        let laptops = xml.getElementsByTagName("laptop");
        //   ↓ Returns NodeList (array-like) of all <laptop> nodes
        
        // Get filter value from dropdown
        let filter = document.getElementById("filter").value;
        //   ↓ "all", "Intel i5", "Ryzen 5", etc.
        
        // ========== STEP 4: Build HTML String ==========
        let output = "";
        
        for (let i = 0; i < laptops.length; i++) {
            // Extract data from current laptop
            let brand = laptops[i].getElementsByTagName("brand")[0].textContent;
            //                                                    ↑
            //                    [0] = first element, .textContent = inner text
            
            let model = laptops[i].getElementsByTagName("model")[0].textContent;
            let price = laptops[i].getElementsByTagName("price")[0].textContent;
            let processor = laptops[i].getElementsByTagName("processor")[0].textContent;
            
            // ========== STEP 5: Apply Filter ==========
            if (filter === "all" || processor === filter) {
                // Add row to output
                output += `
                    <tr>
                        <td>${brand}</td>
                        <td>${model}</td>
                        <td>${price}</td>
                        <td>${processor}</td>
                    </tr>
                `;
            }
        }
        
        // ========== STEP 6: Insert HTML into DOM ==========
        document.getElementById("tableBody").innerHTML = output;
        //                                        ↓
        //                       Replaces content of <tbody>
    };
    
    // ========== STEP 7: Send Request ==========
    xhr.send();
}

// ========== STEP 8: Load Data on Page Start ==========
window.onload = loadData;
//   ↓ Automatically calls loadData() when page loads
```

---

### **⭐ KEY CONCEPTS - Q2**

| Concept | What It Does | Why It Matters |
|---------|-------------|-----------------|
| **XMLHttpRequest** | Fetches XML file without page reload | Foundation for AJAX; basis for Servlet communication in Q1 |
| **getElementsByTagName()** | Finds all elements by tag name | Querying XML structure |
| **textContent** | Gets inner text from element | Extracting data from XML nodes |
| **Template Literals** (backticks) | Creates multi-line strings | Cleaner HTML generation |
| **Filter Logic** | `if (filter === "all" \|\| processor === filter)` | Conditional row inclusion |
| **innerHTML** | Sets HTML content of element | Dynamic DOM manipulation |

---

### **EXECUTION FLOW DIAGRAM**
```
User selects processor from dropdown
           ↓
    onchange="loadData()" triggers
           ↓
   XMLHttpRequest fetches laptops.xml
           ↓
   JavaScript parses XML into DOM
           ↓
   Loop through <laptop> elements
           ↓
   Apply filter: show only matching processor
           ↓
   Build HTML table rows (template literals)
           ↓
   Insert into document.getElementById("tableBody")
           ↓
   Browser renders updated table
```

---

---

## Question 3: Marks Calculator

### 📌 Problem Statement
Create a webpage where user enters marks for 5 subjects. Use JavaScript to calculate total, average, and grade automatically. Display results in a formatted table when button is clicked.

### 🎯 Files Involved
- **3.html** — Input form + results table + JavaScript

---

### **PHASE 1: HTML Structure**

```html
<!-- INPUT FIELDS -->
Subject 1: <input id="m1"><br><br>
Subject 2: <input id="m2"><br><br>
Subject 3: <input id="m3"><br><br>
Subject 4: <input id="m4"><br><br>
Subject 5: <input id="m5"><br><br>

<!-- ACTION BUTTON -->
<button onclick="calculate()">Calculate</button>

<!-- RESULTS TABLE -->
<table border="1">
    <tr>
        <th>Total</th>
        <th>Average</th>
        <th>Grade</th>
    </tr>
    <tr>
        <td id="total"></td>      <!-- ⭐ Dynamic results -->
        <td id="avg"></td>
        <td id="grade"></td>
    </tr>
</table>
```

**Key Pattern:**
- Input fields have `id="m1"` through `id="m5"`
- Results cells have unique IDs for targeted updates
- Button calls `calculate()` on click

---

### **PHASE 2: CSS Styling (Optional but Recommended)**

```css
body {
    font-family: Arial, sans-serif;
    max-width: 500px;
    margin: 50px auto;
    padding: 20px;
}

input {
    width: 100%;
    padding: 8px;
    margin: 5px 0 15px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
    font-size: 16px;
}

button:hover {
    background-color: #45a049;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid black;
    padding: 10px;
    text-align: center;
}

th {
    background-color: #4CAF50;
    color: white;
}
```

---

### **PHASE 3: JavaScript Logic (⭐ CRITICAL)**

```javascript
function calculate() {
    // ========== STEP 1: Get Input Values ==========
    let m1 = Number(document.getElementById("m1").value);
    let m2 = Number(document.getElementById("m2").value);
    let m3 = Number(document.getElementById("m3").value);
    let m4 = Number(document.getElementById("m4").value);
    let m5 = Number(document.getElementById("m5").value);
    //   ↑ Number() converts string to number (e.g., "85" → 85)
    
    // ========== STEP 2: Calculate Total ==========
    let total = m1 + m2 + m3 + m4 + m5;
    //   ↓ Simple arithmetic
    
    // ========== STEP 3: Calculate Average ==========
    let avg = total / 5;
    //   ↓ Divide by number of subjects
    
    // ========== STEP 4: Determine Grade (⭐ Grade Logic) ==========
    let grade = "";
    
    if (avg >= 90) {
        grade = "A";        // 90-100 → A
    }
    else if (avg >= 75) {
        grade = "B";        // 75-89 → B
    }
    else if (avg >= 50) {
        grade = "C";        // 50-74 → C
    }
    else {
        grade = "Fail";     // Below 50 → Fail
    }
    
    // ========== STEP 5: Display Results ==========
    document.getElementById("total").innerHTML = total;
    document.getElementById("avg").innerHTML = avg;
    document.getElementById("grade").innerHTML = grade;
    //                                    ↑ Updates table cells
}
```

---

### **GRADING SCALE BREAKDOWN**
```
Average (avg)     Grade
≥ 90%             A (Excellent)
75-89%            B (Good)
50-74%            C (Pass)
< 50%             Fail
```

**Customization Tips:**
- Change thresholds: `if (avg >= 85)` for stricter grading
- Add more grades: `else if (avg >= 60) grade = "D";`
- Format decimal places: `avg.toFixed(2)` (e.g., 75.50)

---

### **⭐ KEY CONCEPTS - Q3**

| Concept | What It Does | Why It Matters |
|---------|-------------|-----------------|
| **Number() conversion** | String → Number | Essential for arithmetic |
| **Arithmetic operations** | `+`, `/` for calculation | Computing totals/averages |
| **Conditional logic** | `if/else if/else` chains | Decision-making in code |
| **innerHTML** | Updates DOM element text | Displaying dynamic results |
| **Event binding** | `onclick="calculate()"` | Triggering calculations |

---

### **EXAMPLE WALKTHROUGH**
```
Input:
m1=85, m2=90, m3=78, m4=88, m5=92

Execution:
total = 85 + 90 + 78 + 88 + 92 = 433
avg = 433 / 5 = 86.6
grade = "B" (because 86.6 >= 75)

Output:
Total: 433
Average: 86.6
Grade: B
```

---

---

## Question 4: Product Billing

### 📌 Problem Statement
Create a billing page with 4+ products showing price and quantity fields. Use JavaScript to calculate subtotal for each product and grand total dynamically. Prevent negative quantity values.

### 🎯 Files Involved
- **4.html** — Product table + quantity inputs + JavaScript calculation

---

### **PHASE 1: HTML Structure**

```html
<h2>Product Billing</h2>

<table border="1" cellpadding="10">
    <tr>
        <th>Product</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
    </tr>
    
    <tr>
        <td>Product 1</td>
        <td>100</td>
        <td><input type="number" value="0" min="0" onchange="calculate()"></td>
        <td class="subtotal">0</td>     <!-- ⭐ CSS class for batch selection -->
    </tr>
    
    <tr>
        <td>Product 2</td>
        <td>200</td>
        <td><input type="number" value="0" min="0" onchange="calculate()"></td>
        <td class="subtotal">0</td>
    </tr>
    
    <!-- More products... -->
</table>

<h3>Grand Total: <span id="total">0</span></h3>
```

**Key Patterns:**
- `type="number"` — Browser enforces numeric input
- `min="0"` — Browser prevents negative (but JavaScript validates too)
- `onchange="calculate()"` — Triggers recalculation on any quantity change
- `class="subtotal"` — All subtotal cells have same class (batch selection)
- `id="total"` — Grand total display

---

### **PHASE 2: JavaScript Logic (⭐ CRITICAL)**

```javascript
function calculate() {
    // ========== STEP 1: Define Price Array ==========
    let prices = [100, 200, 150, 50];
    //   ↓ Parallel array: prices[i] matches row i
    //   ↓ Order MUST match table rows
    
    // ========== STEP 2: Get All Quantity Inputs ==========
    let quantities = document.querySelectorAll("input");
    //   ↓ Returns NodeList of ALL <input> elements in page
    //   ↓ querySelectorAll() = flexible selector (CSS selectors)
    
    // ========== STEP 3: Get All Subtotal Cells ==========
    let subtotals = document.querySelectorAll(".subtotal");
    //   ↓ Returns NodeList of ALL elements with class="subtotal"
    //   ↓ . prefix = class selector
    
    // ========== STEP 4: Initialize Grand Total ==========
    let total = 0;
    
    // ========== STEP 5: Loop Through Products ==========
    for (let i = 0; i < quantities.length; i++) {
        // Get quantity from input
        let qty = parseInt(quantities[i].value);
        //   ↓ parseInt() converts string to integer (e.g., "5" → 5)
        
        // ========== STEP 6: Prevent Negative Values (⭐ VALIDATION) ==========
        if (qty < 0) {
            qty = 0;
            quantities[i].value = 0;  // Reset input field
        }
        
        // ========== STEP 7: Calculate Subtotal for this Product ==========
        let sub = qty * prices[i];
        //   ↓ E.g., quantity 5 * price 100 = 500
        
        // ========== STEP 8: Update Subtotal Cell ==========
        subtotals[i].innerText = sub;
        //   ↓ Sets text of <td class="subtotal">
        
        // ========== STEP 9: Add to Grand Total ==========
        total += sub;
        //   ↓ Accumulator pattern: total = total + sub
    }
    
    // ========== STEP 10: Display Grand Total ==========
    document.getElementById("total").innerText = total;
}
```

---

### **⭐ KEY CONCEPTS - Q4**

| Concept | What It Does | Why It Matters |
|---------|-------------|-----------------|
| **Parallel Arrays** | `prices[i]` matches `quantities[i]` | Correlating data across arrays |
| **querySelectorAll()** | Selects multiple elements by CSS selector | Batch DOM selection (more flexible than `getElementsByClassName()`) |
| **parseInt()** | String → Integer conversion | Extracting numeric values from inputs |
| **Validation** | `if (qty < 0)` check and reset | Data integrity (prevent invalid orders) |
| **Accumulator Loop** | `total += sub` | Summing multiple values |
| **innerText vs innerHTML** | `.innerText` = text only; `.innerHTML` = HTML | `.innerText` safer for numbers |

---

### **SCALING PATTERN**
This structure scales to ANY number of products:

**Add 5th Product?**
```html
<tr>
    <td>Product 5</td>
    <td>75</td>
    <td><input type="number" value="0" min="0" onchange="calculate()"></td>
    <td class="subtotal">0</td>
</tr>
```

**Update prices array:**
```javascript
let prices = [100, 200, 150, 50, 75];  // Add 75
```

Done! The loop automatically processes the new row.

---

### **EXAMPLE WALKTHROUGH**
```
Input:
Product 1: qty=2
Product 2: qty=3
Product 3: qty=0
Product 4: qty=1

Execution (prices = [100, 200, 150, 50]):
i=0: sub = 2 * 100 = 200,  total = 0 + 200 = 200
i=1: sub = 3 * 200 = 600,  total = 200 + 600 = 800
i=2: sub = 0 * 150 = 0,    total = 800 + 0 = 800
i=3: sub = 1 * 50 = 50,    total = 800 + 50 = 850

Output:
Subtotals: [200, 600, 0, 50]
Grand Total: 850
```

---

---

## Question 5: Blog Layout + Dark Mode

### 📌 Problem Statement
Design a blog webpage with header, navigation menu, main article section, sidebar, and footer. Use CSS for layout and typography. Implement dark mode toggle with JavaScript.

### 🎯 Files Involved
- **5.html** — Blog layout + CSS styling + JavaScript dark mode toggle

---

### **PHASE 1: HTML Structure (Semantic)**

```html
<body id="body">
    
    <!-- HEADER: Site title + theme toggle button -->
    <header>
        <h1>My Blog</h1>
        <button onclick="toggleMode()">Toggle Dark Mode</button>
    </header>
    
    <!-- NAVIGATION: Menu links -->
    <nav>
        <a href="#">Home</a>
        <a href="#">About</a>
        <a href="#">Contact</a>
    </nav>
    
    <!-- MAIN CONTENT: Flex container with article + sidebar -->
    <div class="container">
        <article>
            <h2>Blog Title</h2>
            <p>This is a simple blog post.</p>
        </article>
        
        <aside>
            <h3>Sidebar</h3>
            <p>Links or info here</p>
        </aside>
    </div>
    
    <!-- FOOTER: Copyright / info -->
    <footer>
        <p>Footer Section</p>
    </footer>

</body>
```

**Semantic Elements:**
- `<header>` — Site header (top)
- `<nav>` — Navigation menu
- `<article>` — Main content
- `<aside>` — Sidebar (supporting content)
- `<footer>` — Footer (bottom)

**Why Semantic HTML?**
- Accessibility (screen readers understand structure)
- SEO (search engines index content properly)
- Readability (developers understand intent)

---

### **PHASE 2: CSS Layout & Styling (⭐ CRITICAL)**

```css
/* ========== GLOBAL STYLES ========== */
body {
    font-family: Arial;
    margin: 0;           /* Remove default margins */
    transition: all 0.3s ease;  /* Smooth color transitions on theme change */
}

/* ========== HEADER ========== */
header {
    background: #333;
    color: white;
    text-align: center;
    padding: 10px;
}

/* ========== NAVIGATION ========== */
nav {
    background: #555;
    color: white;
    padding: 10px;
    text-align: center;
}

nav a {
    color: white;
    margin: 10px;
    text-decoration: none;  /* Remove underline */
}

nav a:hover {
    text-decoration: underline;  /* Underline on hover */
    opacity: 0.8;                /* Slight fade effect */
}

/* ========== MAIN CONTAINER: Flexbox Layout (⭐ KEY) ========== */
.container {
    display: flex;           /* Side-by-side layout */
}

/* ========== ARTICLE (Main content) ========== */
article {
    flex: 3;                 /* Takes 3 parts of space */
    padding: 10px;
}

/* ========== SIDEBAR (Supporting content) ========== */
aside {
    flex: 1;                 /* Takes 1 part of space */
    background: #f0f0f0;     /* Light gray background */
    padding: 10px;
}

/* ========== FOOTER ========== */
footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 10px;
}

/* ========== DARK MODE CLASS (⭐ Theme Toggle) ========== */
.dark {
    background: black;
    color: white;
}

.dark nav {
    background: black;       /* Nav background darkens */
}

.dark aside {
    background: #222;        /* Sidebar becomes dark gray */
}

/* ========== BUTTON STYLING ========== */
button {
    margin-top: 10px;
    padding: 5px 10px;
    background-color: white;
    color: #333;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #ddd;  /* Slightly darker on hover */
}
```

---

### **FLEXBOX LAYOUT EXPLAINED**

```
┌─────────────────────────────────────┐
│          HEADER (100% width)        │
│  [My Blog]    [Toggle Button]       │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│      NAV (100% width)               │
│  [Home]  [About]  [Contact]         │
└─────────────────────────────────────┘
┌──────────────────┬──────────────────┐
│                  │                  │
│  ARTICLE (70%)   │  ASIDE (30%)     │
│                  │  (Sidebar)       │
│  flex: 3         │  flex: 1         │
│                  │                  │
└──────────────────┴──────────────────┘
┌─────────────────────────────────────┐
│      FOOTER (100% width)            │
│        Footer Section               │
└─────────────────────────────────────┘
```

**Why Flexbox?**
- `flex: 3` and `flex: 1` create 3:1 ratio (responsive)
- Without hardcoding pixel widths
- Adapts to screen size automatically

---

### **PHASE 3: JavaScript Dark Mode Toggle (⭐ CRITICAL)**

```javascript
function toggleMode() {
    // ========== Get the body element ==========
    let body = document.getElementById("body");
    //   ↓ The element with id="body" (root container)
    
    // ========== Toggle the "dark" class ==========
    body.classList.toggle("dark");
    //   ↓ If "dark" class exists → remove it
    //   ↓ If "dark" class doesn't exist → add it
    
    // ========== How it works ==========
    // Before: <body id="body">
    // After 1st click: <body id="body" class="dark">
    // After 2nd click: <body id="body">
    // After 3rd click: <body id="body" class="dark">
}
```

---

### **CLASS TOGGLING DEEP DIVE**

**What `classList.toggle()` does:**
```javascript
// Equivalent code WITHOUT toggle():
if (body.classList.contains("dark")) {
    body.classList.remove("dark");      // Remove if exists
} else {
    body.classList.add("dark");         // Add if doesn't exist
}

// Using toggle() (cleaner):
body.classList.toggle("dark");          // One line does both!
```

**How CSS `.dark` selector works:**
```css
/* Light mode (default) */
body {
    background: white;
    color: black;
}

/* Dark mode (when class="dark" is present) */
.dark {
    background: black;      /* Overrides default */
    color: white;
}

.dark nav {
    background: black;      /* Nav inherits dark styling */
}
```

---

### **LIGHT ↔ DARK MODE FLOW**

```
Click "Toggle Dark Mode"
         ↓
   toggleMode() executes
         ↓
classList.toggle("dark")
         ↓
 ┌─ Check: Does body have class="dark"?
 │
 ├─ If YES → Remove it (switch to light mode)
 │           CSS reverts to default styles
 │
 └─ If NO → Add it (switch to dark mode)
            CSS `.dark` rules override defaults
         ↓
   Browser repaints with new colors
   transition: all 0.3s ease → Smooth animation
```

---

### **⭐ KEY CONCEPTS - Q5**

| Concept | What It Does | Why It Matters |
|---------|-------------|-----------------|
| **Semantic HTML** | `<header>`, `<nav>`, `<article>`, `<aside>`, `<footer>` | Structure clarity; accessibility; SEO |
| **Flexbox Layout** | `display: flex;` + `flex: 3;` `flex: 1;` | Responsive columns without fixed widths |
| **CSS Class Selector** | `.dark { }` applies to `class="dark"` | Styling multiple elements based on state |
| **classList.toggle()** | Add/remove class dynamically | Clean theme switching |
| **Transition** | `transition: all 0.3s ease;` | Smooth color changes (not abrupt) |
| **Pseudo-selectors** | `:hover` for interactive feedback | Better UX |

---

### **ENHANCEMENT IDEAS**

**Persist dark mode with Local Storage:**
```javascript
function toggleMode() {
    let body = document.getElementById("body");
    body.classList.toggle("dark");
    
    // Save preference to browser storage
    let isDark = body.classList.contains("dark");
    localStorage.setItem("darkMode", isDark);
}

// Load preference on page load
window.onload = function() {
    if (localStorage.getItem("darkMode") === "true") {
        document.getElementById("body").classList.add("dark");
    }
};
```

**Add more theme styles:**
```css
.dark button {
    background-color: #333;
    color: white;
    border: 1px solid white;
}

.dark a:hover {
    background-color: #444;
    color: yellow;
}
```

---

---

## Key JavaScript Patterns

### **Pattern 1: DOM Selection**

```javascript
// By ID (single element)
let elem = document.getElementById("myId");

// By class (multiple elements)
let elems = document.querySelectorAll(".myClass");

// By tag name (multiple elements)
let elems = document.getElementsByTagName("input");

// CSS selector (flexible)
let elems = document.querySelectorAll("div.container > article");
```

### **Pattern 2: Getting & Setting Values**

```javascript
// Get input value
let value = document.getElementById("input1").value;

// Set element text
document.getElementById("result").innerHTML = "Hello";
document.getElementById("result").innerText = "Hello";  // Text only

// Set element property
element.style.color = "red";
element.setAttribute("class", "dark");
element.classList.add("dark");
element.classList.remove("dark");
element.classList.toggle("dark");
```

### **Pattern 3: Event Handling**

```javascript
// Inline event (in HTML)
<button onclick="myFunction()">Click</button>

// Event listener (in JavaScript)
element.addEventListener("click", function() {
    // code
});

// Common events:
// - onclick
// - onchange (input changes)
// - onload (page loads)
// - onsubmit (form submits)
// - onkeypress (key pressed)
```

### **Pattern 4: Loops & Arrays**

```javascript
// Standard for loop
for (let i = 0; i < array.length; i++) {
    console.log(array[i]);
}

// forEach (modern)
array.forEach(function(item, index) {
    console.log(item);
});

// Map (transform)
let doubled = array.map(x => x * 2);

// Filter
let filtered = array.filter(x => x > 5);
```

### **Pattern 5: Conditional Logic**

```javascript
// Simple if/else
if (condition) {
    // code
} else {
    // code
}

// Multiple conditions
if (x > 90) {
    grade = "A";
} else if (x > 75) {
    grade = "B";
} else {
    grade = "C";
}

// Ternary operator (shorthand)
let result = condition ? "yes" : "no";
```

### **Pattern 6: String & Number Conversion**

```javascript
// String → Number
let num = Number("42");      // 42
let num = parseInt("42");    // 42 (integer only)
let num = parseFloat("42.5"); // 42.5

// Number → String
let str = String(42);        // "42"
let str = (42).toString();   // "42"

// Template literals (modern)
let msg = `Hello ${name}, you are ${age} years old`;
```

---

---

## Reusable Concepts

### **For Q1 (Servlet/JSP) - Form Validation Pattern**

The validation patterns from Q2-Q5 apply to Q1:

1. **Get input values** (Q3 pattern):
   ```javascript
   let name = document.getElementById("name").value;
   let email = document.getElementById("email").value;
   ```

2. **Validate fields** (Q3 pattern):
   ```javascript
   if (name === "" || email === "") {
       alert("All fields required!");
       return false;  // Prevent form submission
   }
   ```

3. **Validate email format** (regex pattern):
   ```javascript
   let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
   if (!emailRegex.test(email)) {
       alert("Invalid email!");
       return false;
   }
   ```

4. **Submit to Servlet** (XMLHttpRequest pattern similar to Q2):
   ```javascript
   let xhr = new XMLHttpRequest();
   xhr.open("POST", "FeedbackServlet", true);
   xhr.onload = function() {
       // Servlet processes and forwards to JSP
   };
   xhr.send(new FormData(form));
   ```

### **For Future XML Projects**

The XML + JavaScript pattern (Q2) is reusable:
- **Different data?** Change XML elements and attributes
- **Different filter?** Modify the `if` condition in the filter logic
- **Different table?** Change the HTML template string
- **Same core logic** applies to any XML data source

### **For Future Calculations**

The calculation pattern (Q3, Q4) scales to:
- **Tax calculations:** `tax = total * 0.18;`
- **Discount logic:** `if (total > 1000) total *= 0.9;`
- **Commission:** `commission = sales * 0.05;`

---

---

## Summary Table: Questions 2-5

| Question | Focus | Key Technology | Reusability |
|----------|-------|-----------------|-------------|
| **Q2** | XML + JavaScript Data Display | XMLHttpRequest, DOM parsing, filtering | AJAX pattern; Servlet integration (Q1) |
| **Q3** | Marks Calculator | Form inputs, arithmetic, conditionals | Validation; calculation patterns |
| **Q4** | Product Billing | Arrays, batch DOM selection, accumulation | Scaling; dynamic calculations |
| **Q5** | Blog Layout + Dark Mode | Flexbox, CSS classes, state toggling | Theme management; responsive design |

---

---

## Quick Reference: Common Mistakes & Fixes

| Mistake | Fix |
|---------|-----|
| XML file not found (404) | Ensure `laptops.xml` is in same folder as HTML file |
| `xhr.responseXML` is null | Check XML file has proper XML declaration `<?xml version="1.0"?>` |
| Table not updating | Use `document.getElementById("tableBody").innerHTML = output;` |
| Negative quantities accepted | Add `if (qty < 0) { qty = 0; quantities[i].value = 0; }` |
| Dark mode not applying | Ensure `<body id="body">` has the ID; check CSS `.dark` rules |
| Numbers treated as strings | Use `Number()` or `parseInt()` before arithmetic |
| Input value returns empty | Check input has `value="..."` or `value` is set |
| Template literals not working | Use backticks (`` ` ``), not regular quotes (`"` or `'`) |

---

**Last Updated:** April 2026 | **Version:** 1.0 Complete Reference
