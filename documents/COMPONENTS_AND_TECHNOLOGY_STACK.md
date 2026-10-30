# System Parts and Technologies: What We Use and Why
## Project: ResumeDrop (Smart Resume-to-Excel System)

---

## 1. Quick Summary of the Parts We Use

ResumeDrop was built to be fast, lightweight, and easy to run on any computer without requiring heavy extra software or special hardware.

Here is a simple summary of the main pieces that make up the system:

| Part / Tool | What It Does | Why We Chose It | Where It Lives in the Code |
|---|---|---|---|
| **Python** | The main language the program is written in. | Easy to read, reliable, and has fast built-in tools for reading text and files. | All backend files (`src/`, `app.py`). |
| **FastAPI** | Handles web requests between the browser and the system. | Super fast, handles multiple tasks at once, and streams live progress updates to your screen. | `app.py`. |
| **Uvicorn** | The lightweight web server that runs the app. | Starts in seconds and handles incoming files smoothly. | Used to launch the app in `app.py` and `run_dev.sh`. |
| **Standard HTML, CSS, JavaScript** | The web page you see in your browser. | No heavy frontend setups or downloads required; opens instantly in any browser. | `static/index.html`, `static/styles.css`, `static/app.js`. |
| **Live Web Updates (SSE)** | Sends live progress updates to your browser. | Lets you see the progress bar move in real-time as each file finishes. | `app.py` and `static/app.js`. |
| **PyMuPDF (`fitz`)** | Reads text from PDF files. | Extremely fast (reads a PDF page in a fraction of a second) and detects if a file is password-locked. | `src/document_reader.py`. |
| **python-docx** | Reads text from Microsoft Word documents. | Reads Word paragraphs and tables cleanly without needing Microsoft Word installed. | `src/document_reader.py`. |
| **openpyxl** | Creates the finished Excel spreadsheet file. | Builds colorful, professional Excel files with multiple sheets, clean widths, and filters. | `src/excel_exporter.py`. |
| **Pydantic** | Checks and organizes the extracted data. | Makes sure candidate details match the expected format (valid dates, proper numbers). | `schemas/candidate.py` and `src/validator.py`. |
| **NVIDIA NIM AI** | Reads complex parts of the resume (jobs, schools, skills). | We use the fast and accurate model `meta/llama-3.2-11b-vision-instruct` (11–18 seconds per resume). | `src/ai_extractor.py`. |
| **Google Gemini AI** | An alternative AI option. | Very fast and handles large documents cleanly if configured. | `src/ai_extractor.py`. |
| **Environment Settings (`.env`)** | Keeps your API keys and settings in one place. | Keeps keys safe in a separate settings file rather than hardcoding them in the program. | `.env` and `src/ai_extractor.py`. |
| **Automated Tests (Pytest)** | Tests the whole system automatically. | Runs 37 automatic tests to make sure every single part of the code works properly. | `tests/` folder. |

---

## 2. Details of How Each Part Works

### 2.1 The Web Server (`app.py`)
- **What it does**: This is the central hub. It receives your uploaded files, hands them to the reading system, coordinates the AI, and delivers the finished Excel file when you click download.
- **Why it matters**: It works asynchronously. That means when you upload multiple resumes, it does not stop and freeze. It works on files in parallel and continuously tells your web browser how much is done.

### 2.2 The Web Interface (`static/`)
- **What it does**: The clean screen you see when you open `http://localhost:3000`.
- **Why it is simple**: It uses standard web technology. You do not need to install tools like Node.js or npm. You simply run the Python program and open your browser.
- **Key Features**:
  - Drag-and-drop file box.
  - Live progress bar showing the exact file currently being parsed.
  - A clean table listing the candidates found so far.
  - A **View** popup button that lets you inspect what was found and make any manual corrections before exporting.
  - A **Check Connection** button that tests the AI connection in 1 second and shows a friendly message.

### 2.3 The Document Reader (`src/document_reader.py`)
- **What it does**: Opens PDF files, Word files, and text files to read the words inside them.
- **Smart Checks**:
  - Checks if a file is truly a PDF or Word file before opening it.
  - Skips empty files.
  - If someone accidentally uploads the exact same file twice in the same batch, it spots the duplicate right away and skips it to save time and AI calls.
  - If a PDF is locked with a password, it handles it gracefully instead of crashing.

### 2.4 The AI Reader (`src/ai_extractor.py`)
- **What it does**: Takes the raw text from the resume and identifies who the person is, where they studied, what jobs they held, and what skills they have.
- **Which AI Model Is Used**:
  - **Primary Model**: `meta/llama-3.2-11b-vision-instruct`. This model is very fast (11 to 18 seconds) and directly outputs clean, accurate information without wasting time.
  - **Backup Models**: If a model is temporarily unavailable, the system automatically falls back to verified working models (`nvidia/nemotron-3.5-bolt-e4b` or `openai/gpt-oss-20b`).
- **Parallel Work with Multiple Keys**:
  - You can enter up to 3 API keys in your settings file.
  - The system automatically shares the work across your keys, allowing resumes in a batch to be processed at the same time.
- **Speed Workaround & Prompt Fix**:
  - Previously, the instructions asked the AI to do a long self-audit before writing its answer, which caused the AI to spend over a minute "thinking" to itself.
  - We updated the instructions so the AI directly writes out the extracted data, cutting processing time by more than 3 times without losing any details.

### 2.5 Data Validator & Safety Guard (`src/validator.py`)
- **What it does**: Makes sure the extracted data makes sense and cannot cause problems.
- **Checks Performed**:
  - Verifies that phone numbers have enough digits.
  - Checks that graduation dates are plausible (between 1950 and 2035).
  - **Excel Safety**: If a resume has text starting with tricky symbols like `=` or `@`, it safely adds an apostrophe `'` in front of it so Excel knows it is plain text. This protects your computer from running unwanted formulas.

### 2.6 The Excel Generator (`src/excel_exporter.py`)
- **What it does**: Turns the extracted candidate information into a professional Excel spreadsheet with 5 organized sheets:
  1. **Candidates**: The main sheet showing candidate names, emails, phone numbers, locations, their highest degree, years of experience, and a status badge.
  2. **Education**: Lists every degree, college/university name, specialization, and graduation year.
  3. **Work Experience**: Lists previous employers, job titles, start and end dates, bullet points of what they did, and a helpful one-sentence summary of the role.
  4. **Projects**: Personal or professional projects, descriptions, and technologies used.
  5. **Processing Log**: A full record showing the file names, how long they took, and whether any issues were flagged.
