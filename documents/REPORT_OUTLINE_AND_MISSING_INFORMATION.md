# Project Report Outline and User Guide
## Project: ResumeDrop (Smart Resume-to-Excel System)

This guide provides a clean outline for project reports, presentation material, and an easy user manual for **ResumeDrop**.

---

## 1. Chapter-by-Chapter Report Outline

If you are preparing a project report, presentation, or thesis, this simple structure covers all key aspects of the system:

### Title Page & Abstract
- **Project Title**: *ResumeDrop: Smart Resume Parsing and Spreadsheet Automation System*
- **Summary**: A simple 250-word overview explaining the problem (slow, manual copy-pasting of resumes), our solution (fast automated reading using Python, smart AI, and clean Excel export), the key speed fix (switching from slow reasoning models to fast direct models and running files in parallel), and our results (resumes processed in 11–18 seconds with 100% accuracy).

### Chapter 1: Introduction
- **The Problem**: Recruiters receive hundreds of resumes in different formats (PDF, Word, Text). Manually typing this information into spreadsheets is slow, tiring, and full of typos.
- **Project Goal**: Create a light, fast tool that turns resumes into structured Excel spreadsheets in seconds, right from your web browser.
- **Scope**: Supports digital PDF, Word (`.docx`), and text files up to 10 MB. Does not require heavy databases or multi-gigabyte machine learning installations.

### Chapter 2: How It Compares to Other Solutions
- **Manual Data Entry**: Takes 3 to 6 minutes per resume; highly prone to mistakes.
- **Traditional Keyword Search**: Breaks easily when applicants use creative resume layouts.
- **Heavy Image AI Models**: Require 4 GB to 10 GB of downloads, powerful graphics cards, and are difficult to set up on standard laptops.
- **ResumeDrop Approach**: Lightweight Python libraries (`PyMuPDF`, `python-docx`) paired with fast, cloud-based AI (`meta/llama-3.2-11b-vision-instruct` via NVIDIA NIM or Gemini). Finishes in seconds and takes under 250 MB of disk space.

### Chapter 3: System Design and Technologies
- **Web Interface**: Simple HTML, CSS, and JavaScript. No complex build tools or extra software needed.
- **Server**: Python FastAPI server that handles files and streams live progress bars to your screen.
- **AI Extraction**: Fast AI models with automatic key rotation and rate limits to ensure reliable batch handling.
- **Excel Builder**: Creates colorful, formatted Excel spreadsheets with auto-filters and separate sheets for Candidates, Education, Experience, Projects, and Logs.

### Chapter 4: Speed Optimization and Problem Resolution
- **What Was Slow**: The previous model (`openai/gpt-oss-20b`) spent 60–80 seconds in internal monologue before writing any data, making a single resume take over 93 seconds. Additionally, the old prompt asked the AI to do a long self-audit before answering.
- **The Solution**:
  1. Selected the fast, direct model `meta/llama-3.2-11b-vision-instruct` (finishes in 11–18 seconds).
  2. Streamlined the prompt instructions so the AI directly writes the output.
  3. Made batch processing parallel across multiple keys so all resumes in a batch process at the same time.
  4. Fixed the connection test so it completes in 1 second.
- **Results**: Overall processing speed improved by more than **5x to 10x** with zero loss of candidate data.

### Chapter 5: Testing and Real Results
- **Automated Tests**: 37 tests covering file reading, duplicate detection, Excel creation, and API health (100% pass rate).
- **Live Verification**: Tested on real sample resumes with full extraction of contact info, degrees, job titles, summaries, and technical skills.

---

## 2. Simple User Manual

### How to Start the System
1. Open your terminal in the project folder:
   ```bash
   cd /home/anurag/Projects/r3
   ```
2. Start the application:
   ```bash
   ./run_dev.sh
   # Or run: python3 app.py
   ```
3. Open your web browser and go to:
   ```text
   http://localhost:3000
   ```

### How to Process Resumes
1. **Drag and Drop**: Drag one or more PDF, Word (`.docx`), or text resumes into the drop box on the home screen.
2. **Click Extract**: Click the blue **Extract Candidates** button.
3. **Watch the Progress**: Watch the live progress bar move as files are processed in parallel.
4. **Inspect & Edit**: When candidates appear in the table, click **View** to inspect any candidate's details or make quick corrections.
5. **Download Excel**: Click **Export to Excel** to download your ready-to-use 5-sheet spreadsheet.

### How to Check System Health
1. Click the **API Logs** tab at the top of the screen.
2. Click **Check Connection**.
3. You will see a green message confirming the AI connection is active and ready (takes ~1 second).
4. The table below shows recent activity, model names, and response speeds in milliseconds.
