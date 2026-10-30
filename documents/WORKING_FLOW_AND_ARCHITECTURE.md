# How the System Works: Complete Step-by-Step Flow
## Project: ResumeDrop (Smart Resume-to-Excel System)

This guide explains the entire step-by-step journey of a resume in **ResumeDrop**, from the moment you drag files onto your screen to the moment you open the finished Excel file on your computer.

---

## 1. Simple Overview of the Steps

```
[ Step 1: Drag & Drop Files on Screen ]
                   │
                   ▼
[ Step 2: Upload Files to the Server ]
                   │
                   ▼
[ Step 3: Quick File Checks (Not empty? Not a duplicate?) ]
                   │
                   ▼
[ Step 4: Read the Words Out of the Document (PDF or Word) ]
                   │
                   ▼
[ Step 5: Clean Up Messy Text (Remove strange symbols & extra spaces) ]
                   │
                   ▼
[ Step 6: Two-Way Reading ]
   ├── Path A: Fast pattern matching for emails, phones & links
   └── Path B: AI reads colleges, past jobs, projects & skills
                   │
                   ▼
[ Step 7: Combine Details into One Complete Profile ]
                   │
                   ▼
[ Step 8: Double-Check Quality & Safety (Verify dates & secure text) ]
                   │
                   ▼
[ Step 9: Send Real-Time Updates to the Screen (Progress Bar Moves) ]
                   │
                   ▼
[ Step 10: Review and Edit (Optional: Click View to adjust anything) ]
                   │
                   ▼
[ Step 11: Build the Formatted 5-Sheet Excel File ]
                   │
                   ▼
[ Step 12: Download Excel Spreadsheet to Your Computer ]
```

---

## 2. Detailed Explanation of Each Step

### Step 1: Picking Your Files
- **What happens**: You open the app in your web browser (`http://localhost:3000`) and drag your resume files into the big drop box, or click to choose them from your computer folder.
- **Accepted Files**: PDF files, Word files (`.docx`), and text files (`.txt`).
- **What you see**: A neat list of all the files you selected with their sizes, and an **Extract Candidates** button ready to click.

---

### Step 2: Sending Files to the Server
- **What happens**: You click **Extract Candidates**. The browser sends the files to the Python system in the background.
- **No Freezing**: Your browser stays smooth and responsive. It immediately opens a live update channel so you can watch the progress live.

---

### Step 3: Basic File Safety & Checks
- **What happens**: Before reading anything, the system performs quick checks:
  1. Makes sure the file is actually a PDF or Word file and not a renamed image or broken file.
  2. Makes sure the file is not 0 bytes (empty).
  3. Checks if you accidentally added the same resume twice in the same batch. If so, it processes it only once so you do not waste time.
  4. Checks if the PDF is password-locked. If locked, it notes it down safely without crashing.

---

### Step 4: Reading the Words
- **What happens**: The system extracts the text from the document:
  - For PDF files: It reads the text page by page in a fraction of a second.
  - For Word files: It reads paragraphs and tables, preserving the structure of columns.
- **Result**: A clean stream of the text written on the resume.

---

### Step 5: Cleaning Up the Text
- **What happens**: Resumes often have invisible strange characters, repeated line breaks, or weird spacing caused by different word processors.
- **What we do**: The system tidies up the text by removing invisible control characters and making the spacing consistent, making it easy for the AI to understand.

---

### Step 6: Two-Way Smart Reading (Fast Patterns + AI)
Instead of relying on only one method, the system uses two paths side-by-side:

- **Path A: Instant Pattern Matching**:
  - Finds email addresses, phone numbers (including country codes), and website links (LinkedIn, GitHub, portfolios) using fast, exact search rules.
  - This step is instantaneous and 100% reliable for contacts.
- **Path B: Fast AI Model**:
  - The cleaned resume is handed to the AI model (`meta/llama-3.2-11b-vision-instruct`).
  - The AI reads through the person's work history, understands what roles they held, creates a clear one-sentence summary for each job, finds which colleges they attended, and picks out their technical skills.
- **How We Made This Fast**:
  - Previously, the system was waiting for the AI to do a long internal self-audit that took 70–90 seconds per file.
  - We adjusted the instructions so the AI directly writes out the extracted data. Now, this step finishes in just **11 to 18 seconds** per file.
  - When you upload multiple resumes, they are processed **in parallel at the same time** across your available keys, so a batch of resumes finishes together in seconds.

---

### Step 7: Combining the Information
- **What happens**: The system combines the results from Path A and Path B into one complete profile.
- **Priority Rule**: If both the pattern rule and the AI found an email address or phone number, the exact pattern rule is kept because it is direct and exact. The AI provides the rich work descriptions and education details.

---

### Step 8: Quality Checks & Safety Guard
- **What happens**: The candidate profile goes through automatic quality checks:
  1. Checks that phone numbers have a valid number of digits.
  2. Checks that graduation years make sense (e.g. between 1950 and 2035).
  3. Checks that degree names are clear (like B.Tech, M.S., Ph.D.).
  4. **Excel Safety**: Scans text for tricky characters (like `=` or `@`) and adds a single quote `'` in front of them so Microsoft Excel opens the file safely without running unwanted macros.

---

### Step 9: Live Updates on Your Screen
- **What happens**: As each resume finishes, a message is immediately sent to your browser:
  - The progress bar moves forward.
  - The candidate's name, email, location, degree, and skills appear in the table on your screen.
  - A green badge shows the record was verified successfully.

---

### Step 10: Review and Edit (Optional)
- **What happens**: If you want to check the details or fix any typo before downloading:
  - Click the **View** button next to any candidate.
  - A popup window opens showing their complete profile, previous companies, job bullet points, and skills.
  - You can edit any field directly and click **Save Changes**. The table updates immediately.

---

### Step 11 & 12: Generating and Downloading the Excel File
- **What happens**: When you are ready, click **Export to Excel**.
- **The Result**: The system creates an Excel file (`.xlsx`) containing 5 neatly organized sheets:
  1. **Candidates**: Master summary list of all applicants.
  2. **Education**: Detailed list of degrees, colleges, and years.
  3. **Work Experience**: Job titles, companies, dates, one-line summaries, and responsibilities.
  4. **Projects**: Personal and student projects with descriptions and tools.
  5. **Processing Log**: Audit record showing the file names, how fast they finished, and verification status.
- Your browser automatically downloads the file to your computer.
