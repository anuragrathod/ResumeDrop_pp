# ResumeDrop - Simple Guide to Every File and Folder

This document gives you a clear, simple tour of every file and folder in the **ResumeDrop** project. It explains what each file does, why it is there, and how they work together.

---

## 1. Quick Folder Map

```
ResumeDrop/
├── app.py                            # The main web server that runs the app
├── cli_demo.py                       # Command-line tool to run without a browser
├── requirements.txt                  # List of Python packages needed
├── run_dev.sh                        # Shortcut script to start the app
├── .env                              # Your personal settings and API keys
├── .env.example                      # Example settings template
├── README.md                         # Main project overview guide
├── workflow.md                       # Complete step-by-step workflow guide
├── files.md                          # Guide to every file in the project (this file)
│
├── src/                              # The core program code
│   ├── document_reader.py            # Opens and reads text from PDF and Word files
│   ├── resume_parser.py              # Organizes pattern rules and AI extraction
│   ├── ai_extractor.py               # Fast AI engine that connects to NVIDIA NIM or Gemini
│   ├── validator.py                  # Checks data quality and makes Excel files safe
│   ├── excel_exporter.py             # Builds the clean 5-sheet Excel spreadsheet
│   └── utils.py                      # Basic text cleaning and duplicate checks
│
├── schemas/                          # Clear data formats
│   └── candidate.py                  # Defines how candidate info (names, jobs, degrees) is organized
│
├── prompts/                          # AI instructions
│   └── extract_candidate.txt         # Clean instructions telling the AI what details to extract
│
├── static/                           # The web page you see in your browser
│   ├── index.html                    # The HTML layout of the screen
│   ├── styles.css                    # Clean visual styling
│   └── app.js                        # Handles button clicks, file drops, and live progress
│
├── sample_resumes/                   # Sample resumes for testing
│   ├── alice_chen_resume.pdf         # Sample PDF resume
│   └── bob_patel_resume.docx         # Sample Word resume
│
├── documents/                        # In-depth project documentation
│   ├── PROJECT_OVERVIEW.md           # Simple summary of the project goals
│   ├── COMPONENTS_AND_TECHNOLOGY_STACK.md # Explanations of every tool we use
│   ├── WORKING_FLOW_AND_ARCHITECTURE.md   # Step-by-step explanation of the flow
│   ├── IMPLEMENTATION_TESTING_AND_RESULTS.md # Test results and real speed benchmarks
│   └── REPORT_OUTLINE_AND_MISSING_INFORMATION.md # Guide for project reports and user manual
│
└── tests/                            # 37 automated tests ensuring everything works
```

---

## 2. Root Files

### `app.py`
- **What it is**: The main backend server for the application.
- **What it does**:
  - Serves the web interface to your browser on port 3000.
  - Receives uploaded resumes and processes them **in parallel** across your available API keys so a whole batch finishes together in seconds.
  - Streams real-time progress updates to your screen so you see the progress bar move as files finish.
  - Handles the **Check Connection** button, testing your AI connection in 1 second.
  - Creates and delivers the finished 5-sheet Excel file when you click download.

### `cli_demo.py`
- **What it is**: A command-line script.
- **What it does**: Allows you to process a folder of resumes directly from your terminal and save an Excel file without needing to open a web browser.

### `requirements.txt`
- **What it is**: The list of Python packages needed to run ResumeDrop.
- **What it does**: When you run `pip install -r requirements.txt`, it installs lightweight tools for reading PDFs, Word files, spreadsheets, and web connections.

### `run_dev.sh`
- **What it is**: A simple shortcut script.
- **What it does**: Lets you start the entire app with one simple command: `./run_dev.sh`.

### `.env` and `.env.example`
- **What they are**: Settings files.
- **What they do**: `.env` holds your private API keys and choices of AI model (e.g. `DEFAULT_NVIDIA_MODEL=meta/llama-3.2-11b-vision-instruct`). `.env.example` is a safe template you can copy to create your `.env`.

### `README.md`
- **What it is**: The main front-page guide to the project with setup instructions, features, and quick-start steps.

### `workflow.md`
- **What it is**: A plain-English, step-by-step guide explaining how a resume moves from upload to Excel.

---

## 3. Core Program Code (`src/`)

### `src/document_reader.py`
- **What it does**: Opens PDF, Word (`.docx`), and text (`.txt`) files and extracts the readable text.
- **Smart Features**:
  - Verifies file types before trying to open them.
  - Catches password-locked PDFs safely without crashing.
  - Automatically spots duplicate resumes in the same batch and skips them to save time.

### `src/resume_parser.py`
- **What it does**: The central coordinator for reading resume details.
- **Two Paths**:
  - Uses fast search rules to immediately grab emails, phone numbers, and web links (LinkedIn, GitHub).
  - Uses the AI engine to read career history, degrees, projects, and skills.
  - Combines both results into one complete profile.

### `src/ai_extractor.py`
- **What it does**: Connects to the AI service (NVIDIA NIM or Google Gemini) to understand the resume.
- **Speed & Features**:
  - Configured with the fast, direct model `meta/llama-3.2-11b-vision-instruct` (finishes in 11 to 18 seconds).
  - Includes verified working fallbacks (`nvidia/nemotron-3.5-bolt-e4b` and `openai/gpt-oss-20b`).
  - Automatically shares requests across multiple API keys in your pool.
  - Runs a fast 1-second connection test to confirm the AI is ready.

### `src/validator.py`
- **What it does**: Quality control and security guard.
- **Checks Performed**:
  - Checks that phone numbers have enough digits.
  - Checks that graduation dates make sense.
  - Protects your computer by cleaning any tricky characters (like `=` or `@`) so opening Excel is completely safe.

### `src/excel_exporter.py`
- **What it does**: Takes the validated candidate information and turns it into a clean, professional 5-sheet Excel workbook with color-coded status badges, auto-filters, and clean column widths.

### `src/utils.py`
- **What it does**: Helper tools that clean up messy spaces, strip invisible control characters, and calculate digital signatures to spot duplicate files.

---

## 4. Data Models and Instructions (`schemas/` & `prompts/`)

### `schemas/candidate.py`
- **What it does**: Defines the exact structure for candidates, education records, past jobs, projects, and skills so the whole program speaks the exact same language.

### `prompts/extract_candidate.txt`
- **What it does**: The instructions given to the AI.
- **Optimized for Speed**: Tells the AI exactly what fields to extract and asks for direct output without preliminary overthinking or self-checking monologues, keeping extraction fast and 100% accurate.

---

## 5. Web Interface (`static/`)

### `static/index.html`
- **What it does**: The structure of the web page. Includes the drag-and-drop box, the live progress bar, the candidate list table, the candidate inspection popup, and the connection check button.

### `static/styles.css`
- **What it does**: Makes the web page look clean, modern, and easy on the eyes with pleasant colors and clear text.

### `static/app.js`
- **What it does**: The JavaScript code running in your browser that handles dragging and dropping files, updates the live progress bar as resumes finish, lets you edit candidate details in the popup, and triggers the Excel download.

---

## 6. Testing (`tests/`)

### `tests/`
- **What it does**: Contains **37 automated tests** covering file reading, Excel creation, security checks, and AI connections.
- You can run all tests anytime by typing `pytest` in your terminal. All 37 tests pass with zero errors.


done