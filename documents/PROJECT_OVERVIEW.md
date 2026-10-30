# Project Overview & System Identity
## Project: ResumeDrop (Smart Resume-to-Excel System)

---

## 1. Simple Summary

**ResumeDrop** is a fast and easy-to-use tool made in **Python** that turns resumes into organized Excel spreadsheets automatically.

When companies hire people, they receive dozens or hundreds of resumes in different shapes and formats—PDF files, Word files, and plain text files. Every person designs their resume differently, with different fonts, columns, and styles. Today, hiring teams have to open every single file by hand, copy-paste names, phone numbers, schools, and job histories into a spreadsheet, which takes hours, is tiring, and leads to mistakes.

ResumeDrop does this whole job automatically in seconds:
1. **Reads Any File**: Accepts a batch of resumes (PDF, Word, Text) and reads the words out of them immediately.
2. **Two-Way Smart Reading**:
   - Uses simple pattern matching for straightforward details like email addresses, phone numbers, and web links (LinkedIn, GitHub).
   - Uses a smart AI model (**NVIDIA NIM** or **Google Gemini**) to understand more complicated parts, like work history, job responsibilities, college degrees, projects, and skills.
3. **Double Checks Everything**: Verifies graduation dates, checks for valid emails, and makes sure no data is garbled or missing.
4. **Safety Check**: Makes sure the text inside the resume cannot harm your computer when opened in Excel.
5. **Ready-to-Use 5-Sheet Excel File**: Creates a clean, beautifully formatted Excel file with separate sheets for Candidates, Education, Work Experience, Projects, and an Activity Log.
6. **Live Web Screen**: Shows an easy-to-use screen in your web browser with a live progress bar and an activity log that shows how quickly each resume was handled.

---

## 2. The Problem and How We Solved It

### 2.1 The Problem
- **Too Many Different Files**: Resumes come in all kinds of layouts. Some have two columns, some have tables, and some use unique headings like "My Journey" instead of "Work Experience".
- **Slow Manual Work**: Copying information by hand takes 3 to 6 minutes per resume. For 100 applicants, that is 5 to 10 hours of tedious typing.
- **Typing Mistakes**: Hand-typed phone numbers often miss digits, names get misspelled, and dates get mixed up.
- **Previous Tools Were Either Too Slow or Broken**: Older systems either broke when layouts changed, required massive downloads (several gigabytes of AI files), or got stuck for minutes on a single resume because the AI spent too much time "thinking" before giving an answer.

### 2.2 How ResumeDrop Fixes This
- **Light and Fast**: Does not need giant files or graphics cards. It runs on any regular laptop or office computer.
- **Fast, Direct AI**: Instead of using heavy models that spend minutes overthinking, ResumeDrop uses a fast and accurate AI model (`meta/llama-3.2-11b-vision-instruct`) that reads the resume and directly writes down the details in 10 to 18 seconds.
- **Works in Parallel**: When you upload 5 or 10 resumes, it does not process them one by one like people waiting in a single line. It processes them together at the same time across your available keys, cutting total waiting time dramatically.
- **Safe to Open**: Automatically cleans any tricky characters so the final Excel sheet is completely safe to open.

---

## 3. Goals of the Project

1. **Read Common Formats**: Open PDF, Word, and text resumes cleanly, without needing heavy extra software.
2. **High Accuracy**: Accurately capture candidate names, phone numbers, emails, degrees, companies worked at, and skills without making things up.
3. **Fast Processing**: Process resumes in parallel so a batch of applications finishes in seconds rather than minutes.
4. **Clean Excel Output**: Provide a clean 5-sheet workbook with color-coded badges, clear column widths, and helpful one-line summaries of each candidate's past jobs.
5. **Simple Web Interface**: Allow anyone to drag and drop files, watch real-time progress, review results, and download the finished spreadsheet with a single click.

---

## 4. What the System Does and Does Not Do

### What It Does:
- Reads digital PDF files, Word documents (`.docx`), and text files (`.txt`) up to 10 MB in size.
- Extracts name, email, phone number, location, links (LinkedIn, GitHub, website), education history, jobs, projects, and skills.
- Writes a clear one-line summary for every job and project so recruiters can understand what the person did at a glance.
- Shows a live progress bar so you see exactly which file is being handled.
- Lets you inspect and edit candidate details in a popup window before downloading.
- Downloads a ready-to-use 5-sheet Excel file.
- Provides a connection health check and log view to monitor how fast each request finished.

### What It Does Not Do:
- **Pictures of Printed Paper (Scanned Photos)**: The system is designed for digital documents with readable text. If someone takes a blurry phone photo of a paper resume, the system flags it as empty rather than slowing down your computer with giant image-scanning tools.
- **Permanent Database Needed**: It works on demand. You do not need to install or maintain a heavy database server.
- **Account Logins**: Designed as a simple, open productivity tool for immediate office use without complicated passwords or user accounts.

---

## 5. Who Can Use This System?

| User | Main Task | How ResumeDrop Helps |
|---|---|---|
| **Recruiters & HR Staff** | Reviewing applications for job openings. | Turns a stack of resumes into a clean, searchable Excel sheet in seconds. |
| **College Placement Offices** | Managing student resumes for campus job drives. | Standardizes hundreds of student resumes into one organized spreadsheet with degrees and skills. |
| **Hiring Managers** | Comparing applicant qualifications and projects. | Gives clear, one-sentence summaries of what each candidate actually built or worked on. |
| **Developers & Team Leads** | Automating resume processing in other systems. | Can be run via the simple command-line script (`cli_demo.py`) or the web screen. |

---

## 6. How the Screens Work

The web screen runs right in your browser (at `http://localhost:3000`) and has two main sections:

1. **Home Screen (Resume to Excel)**:
   - **Drop Box**: Drag your resume files right onto the box, or click to choose them from your computer.
   - **File List**: Shows the files you selected and their sizes, with an option to remove any file.
   - **Progress Bar**: Shows a live progress bar with the name of the file being processed and how many files are finished.
   - **Candidate Table**: As resumes finish, candidate names, emails, locations, degrees, and skills appear in a neat table. You can click **View** to see the full details in a popup.
   - **Download Excel Button**: Click this button to save the finished 5-sheet Excel file to your computer.

2. **Activity & Logs Screen**:
   - **Check Connection Button**: Tests your connection to the AI service in about 1 second and shows a green success message when everything is ready.
   - **Activity Log Table**: Shows a simple 5-column list of all recent AI calls, showing the time, document name, model used, speed (in milliseconds), and status.
   - **Refresh & Clear Buttons**: Lets you clear old logs or refresh the screen anytime.

---

## 7. Important Notes to Keep in Mind

1. **Text Resumes**: The system works best with standard digital resumes. If a resume is just a scanned photo of paper without selectable text, the system will mark it so you know to review it by hand.
2. **Internet Connection**: The AI features connect securely over the internet to read complex job histories. If the internet drops, the system still captures emails, phone numbers, and links using built-in pattern rules.
