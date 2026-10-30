# ResumeDrop — Smart Resume-to-Excel System

ResumeDrop is an easy-to-use, fast Python application that turns resume files (PDF, Word, and Text) into clean, organized **5-sheet Excel spreadsheets** (`.xlsx`).

Instead of spending hours copying and pasting candidate names, phone numbers, degrees, and work history into a spreadsheet by hand, ResumeDrop reads your resumes and builds the Excel file for you in seconds.

---

## ⚡ What Makes ResumeDrop Special

- **Fast & Direct AI**: Uses the fast `meta/llama-3.2-11b-vision-instruct` model on NVIDIA NIM to read resumes and output structured details in just **11 to 18 seconds** per file.
- **Processes Files in Parallel**: When you drop multiple resumes into the app, it processes them at the same time across your available keys, finishing a whole batch in seconds.
- **Easy Web Interface**: Runs right in your browser. No complicated setups, no node/npm packages to install. Just run the Python app and start using it.
- **Two-Way Extraction**:
  - Uses instant pattern rules for emails, phone numbers, and web links (LinkedIn, GitHub).
  - Uses smart AI for work histories, degrees, one-sentence job summaries, and skills.
- **Safe for Excel**: Automatically protects against dangerous spreadsheet formulas so the downloaded file is safe to open on any computer.
- **Ready-to-Use 5-Sheet Excel File**:
  1. `Candidates` — Summary sheet with names, contacts, highest degrees, years of experience, and status badges.
  2. `Education` — Academic records with degrees, specializations, schools, and years.
  3. `Work Experience` — Job titles, companies, dates, clear one-sentence summaries, and responsibilities.
  4. `Projects` — Personal or student projects with descriptions and tools used.
  5. `Processing Log` — A simple record showing which files were processed and how long each took.
- **1-Second Connection Health Check**: Click "Check Connection" to test your AI connection in 1 second and see a clear green status.

---

## 🏗️ How the System Works

```
[ Upload Resumes: PDF / Word / Text ]
                  │
                  ▼
        [ Read Text from File ]
  - Reads PDF pages in a split second
  - Reads Word paragraphs and tables
  - Automatically skips duplicate files
                  │
                  ▼
         [ Two-Way Reading ]
  ├── Fast Pattern Search (Emails, Phones, Web Links)
  └── Fast AI Reading (meta/llama-3.2-11b-vision-instruct)
                  │
                  ▼
      [ Combine Details & Verify ]
  - Checks dates and phone number lengths
  - Safely escapes characters for Excel
                  │
                  ▼
      [ Live Updates on Web Screen ]
  - Watch the progress bar move live
  - Inspect or edit any candidate in a popup
                  │
                  ▼
   [ Download 5-Sheet Excel File (.xlsx) ]
```

---

## 🚀 How to Run ResumeDrop

### 1. Requirements & Setup

Make sure you have Python (version 3.10 to 3.12) installed:

```bash
# Clone the repository
git clone https://github.com/anuragrathod/ResumeDrop.git
cd ResumeDrop

# Create and turn on a virtual environment
python3 -m venv .venv
source .venv/bin/activate       # On Windows: .\.venv\Scripts\Activate.ps1

# Install the lightweight packages
pip install -r requirements.txt
```

### 2. Configure Your Settings

Make a copy of the settings file:

```bash
cp .env.example .env
```

Open `.env` in any text editor and add your API keys:
```env
# Optional: Set NVIDIA API keys
NVIDIA_API_KEY_1=your_nvidia_api_key_here
DEFAULT_NVIDIA_MODEL=meta/llama-3.2-11b-vision-instruct

# Optional: Google Gemini API Key
# GEMINI_API_KEY=your_gemini_key_here
```

### 3. Start the Web App

```bash
./run_dev.sh
# Or run: python3 app.py
```

Now open **`http://localhost:3000`** in your web browser.

### 4. Or Run from the Command Line

If you want to process resumes from a folder directly to an Excel file without opening a browser:

```bash
python3 cli_demo.py --dir sample_resumes --extract --export output/candidates.xlsx --verbose
```

---

## 🧪 Testing the System

The project includes an automatic test suite containing **37 tests** that verify file reading, key rotation, Excel building, and data validation:

```bash
pytest
```

All 37 tests pass with zero errors.

---

## 📁 Project Folder Structure

```
ResumeDrop/
├── app.py                      # Main web server, progress streaming & routes
├── cli_demo.py                 # Command-line batch extraction tool
├── requirements.txt            # Python packages needed
├── run_dev.sh                  # One-click startup script
├── .env                        # Your local settings and API keys
├── .env.example                # Example settings template
├── README.md                   # This project overview guide
├── workflow.md                 # Step-by-step workflow guide
├── files.md                    # Detailed guide to every file in the project
├── documents/                  # In-depth project documentation
│   ├── PROJECT_OVERVIEW.md
│   ├── COMPONENTS_AND_TECHNOLOGY_STACK.md
│   ├── WORKING_FLOW_AND_ARCHITECTURE.md
│   ├── IMPLEMENTATION_TESTING_AND_RESULTS.md
│   └── REPORT_OUTLINE_AND_MISSING_INFORMATION.md
├── sample_resumes/             # Sample PDF and Word resumes for testing
│   ├── alice_chen_resume.pdf
│   └── bob_patel_resume.docx
├── schemas/
│   └── candidate.py            # Clean data structures for candidates, education, jobs
├── src/
│   ├── ai_extractor.py         # Fast AI extraction engine and key management
│   ├── document_reader.py      # PDF and Word document readers
│   ├── excel_exporter.py       # Creates the 5-sheet Excel workbook
│   ├── resume_parser.py        # Organizes pattern rules and AI extraction
│   ├── utils.py                # Text cleaning and duplicate checking tools
│   └── validator.py            # Data quality checks and Excel formula safety
├── static/                     # Web interface
│   ├── index.html              # Clean single-page screen
│   ├── styles.css              # Styling
│   └── app.js                  # Browser controls, live progress bar, popup modal
└── tests/                      # 37 automated tests
```

---

## 🔒 Safety and Privacy

- **Excel Formula Protection**: Every cell is inspected before saving. Any text starting with tricky symbols like `=` or `@` is safely treated as plain text so opening Excel is completely safe.
- **Key Privacy**: API keys stay securely on the server and are never displayed in the browser. In activity logs, keys are masked (e.g. `nvapi-***`).
- **No Heavy Downloads**: The entire application takes under 250 MB of disk space.
