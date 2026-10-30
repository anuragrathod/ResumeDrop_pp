# ResumeDrop - Step-by-Step Workflow Guide

This guide walks you through the complete step-by-step workflow of **ResumeDrop**, from dropping files onto your screen to downloading a finished Excel spreadsheet.

Every stage explains:
- **What happens**
- **Which part of the program handles it**
- **How it works in plain language**
- **What goes in and what comes out**

---

## Simple Flow Chart

```
+-----------------------------------------------------------------------------------------+
| STAGE 1: Pick Files on Screen [static/app.js & static/index.html]                       |
| -> Drag-and-drop resumes (PDF, Word, Text); view the selected list                      |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 2: Send Files to the Server [/api/process in app.py]                               |
| -> Uploads resumes to the backend and prepares parallel workers                         |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 3: Basic File & Duplicate Checks [src/document_reader.py]                         |
| -> Checks file type, ignores empty files, and skips accidental duplicates               |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 4: Read the Words Out of the Files [PyMuPDF for PDF, python-docx for Word]        |
| -> Reads text from PDF pages and Word tables in a fraction of a second                  |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 5: Clean Up Text Spacing [src/utils.py]                                           |
| -> Cleans up broken lines, strange symbols, and weird spacing                           |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 6: Two-Way Reading [src/resume_parser.py & src/ai_extractor.py]                   |
| -> Fast Pattern Search: Immediately grabs emails, phones, and web links                 |
| -> Fast AI (meta/llama-3.2-11b-vision-instruct): Reads past jobs, schools, and skills  |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 7: Merge Details into One Profile [src/resume_parser.py]                          |
| -> Combines pattern details with AI career history into a complete profile              |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 8: Quality Checks & Excel Safety [src/validator.py]                               |
| -> Checks graduation years and protects against tricky formula characters               |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 9: Send Live Updates to the Browser [app.py & static/app.js]                       |
| -> The live progress bar moves and candidates appear in the table in real-time          |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 10: Review and Quick Edit [static/app.js]                                         |
| -> Click "View" on any candidate to inspect details or make quick corrections           |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 11: Build the Formatted 5-Sheet Excel File [src/excel_exporter.py]                |
| -> Creates Candidates, Education, Work Experience, Projects, and Log sheets             |
+-----------------------------------------------------------------------------------------+
                                           │
                                           ▼
+-----------------------------------------------------------------------------------------+
| STAGE 12: Download to Your Computer [/api/export in app.py]                             |
| -> Saves the ready-to-share .xlsx spreadsheet to your computer                          |
+-----------------------------------------------------------------------------------------+
```

---

## Detailed Breakdown of Each Stage

---

### Stage 1: Selecting Resumes on the Screen
- **What Happens**: You open the website in your browser, drag your resumes into the upload area (or click to select them from a folder), and see the list of files ready for processing.
- **Accepted Files**: `.pdf`, `.docx` (Word), and `.txt` files up to 10 MB.
- **Output**: A confirmed list of files ready to extract.

---

### Stage 2: Uploading to the Server
- **What Happens**: You click **Extract Candidates**. The files are sent to the Python server in the background.
- **Why It Is Fast**: The server sets up parallel workers so multiple resumes are processed **at the same time** instead of waiting in line one after another.
- **Output**: The server begins processing all files simultaneously and opens a live update channel to your screen.

---

### Stage 3: Quick Checks & Duplicate Protection
- **What Happens**: Before reading, the server does four safety checks:
  1. Checks if the file is a real PDF or Word document.
  2. Makes sure the file is not 0 bytes (empty).
  3. Checks if the file is password-locked. If locked, it flags it safely without crashing.
  4. Checks if you accidentally selected the exact same file twice in the same batch. If so, it processes it only once to save time.
- **Output**: Safe, validated file bytes ready for text extraction.

---

### Stage 4: Reading the Text
- **What Happens**: The system extracts the words from the document:
  - **PDFs**: Reads text page by page in less than a second using high-speed reading tools.
  - **Word Documents**: Reads all paragraphs and tables, preserving column relationships.
- **Output**: The raw text content of the resume.

---

### Stage 5: Tidying Up the Text
- **What Happens**: Different word processors often save invisible formatting artifacts, repeated newlines, or strange spacing.
- **What We Do**: Normalizes line breaks and collapses messy spaces so the text is clean and easy for the AI to read.
- **Output**: Clean plain text.

---

### Stage 6: Two-Way Extraction (Patterns + Fast AI)
- **What Happens**: The system reads the resume using two methods side-by-side:
  - **Method 1 (Instant Pattern Matching)**:
    - Finds email addresses, international and domestic phone numbers, LinkedIn profiles, and GitHub links.
    - Runs in milliseconds and never misses contact details.
  - **Method 2 (Fast AI Reading)**:
    - Sends the text to the fast AI model (`meta/llama-3.2-11b-vision-instruct` on NVIDIA NIM or Google Gemini).
    - The AI reads past jobs, job responsibilities, colleges attended, degrees earned, projects built, and technical skills.
    - Writes a clean, one-sentence summary for every job and project so recruiters can understand what the candidate did at a glance.
  - **Why It Is Fast Now**:
    - Previously, the instructions asked the AI to do a 10-step self-audit before writing its answer, which caused the AI to spend over a minute thinking to itself.
    - We updated the prompt so the AI directly outputs the information, cutting extraction time from **~93 seconds down to 11–18 seconds** per file.
- **Output**: One set of contact details and one set of rich career details.

---

### Stage 7: Combining the Results
- **What Happens**: The system brings together the contact details from Method 1 and the career details from Method 2 into one unified candidate profile.
- **Output**: A complete profile containing name, phone, email, links, degrees, past jobs, projects, and skills.

---

### Stage 8: Quality Checks & Excel Safety
- **What Happens**: The candidate profile goes through automatic quality checks:
  1. Verifies that phone numbers have enough digits (7 to 15 digits).
  2. Verifies that graduation dates are plausible (between 1950 and 2035).
  3. **Excel Safety**: Scans text for tricky formula characters (like `=` or `@`) and adds a single quote `'` in front of them so Microsoft Excel and Google Sheets open the file completely safely without running unwanted macros.
- **Output**: A verified, safe candidate profile.

---

### Stage 9: Live Progress Updates on Screen
- **What Happens**: As each resume completes, the server sends a real-time message to your browser:
  - The animated progress bar moves forward.
  - The candidate's name, email, location, degree, and skills appear in the table on your screen.
  - A green badge shows the record was verified.
- **Output**: Real-time visual progress on your screen.

---

### Stage 10: Review and Quick Edit (Optional)
- **What Happens**: If you want to check what was extracted or correct any typos before exporting:
  - Click the **View** button next to any candidate in the table.
  - A popup window opens showing their complete profile, previous companies, job bullet points, and skills.
  - You can edit any field directly and click **Save Changes**. The table updates immediately.
- **Output**: Confirmed candidate information ready for export.

---

### Stage 11: Building the 5-Sheet Excel File
- **What Happens**: When you click **Export to Excel**, the server transforms all candidate records into a clean, professional spreadsheet with 5 dedicated sheets:
  1. **Sheet 1 (`Candidates`)**: Master summary sheet with candidate names, emails, phone numbers, locations, their highest degree, years of experience, and status badges.
  2. **Sheet 2 (`Education`)**: Academic history with degrees, colleges, specializations, and graduation years.
  3. **Sheet 3 (`Work Experience`)**: Career timeline with job titles, company names, dates, bullet-point responsibilities, and clear one-sentence summaries.
  4. **Sheet 4 (`Projects`)**: Personal and academic projects with descriptions and tools used.
  5. **Sheet 5 (`Processing Log`)**: Full record showing the file names, how fast each file was processed, and verification notes.
- **Output**: A ready-to-use `.xlsx` workbook.

---

### Stage 12: Download to Your Computer
- **What Happens**: Your web browser automatically downloads the finished `.xlsx` file to your computer.
- **Output**: A finished, professionally formatted Excel file ready to share with hiring managers or HR teams.
