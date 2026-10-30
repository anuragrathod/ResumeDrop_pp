# ResumeDrop — Setup & Installation Guide

This document provides a verified, beginner-friendly, step-by-step installation, configuration, execution, and troubleshooting manual for **Windows (PowerShell)**, **Linux (Bash)**, and **macOS** environments.

---

## 1. System Requirements & Prerequisites

| Requirement | Minimum Specification | Recommended |
|---|---|---|
| **Python Version** | Python 3.10 | Python 3.11 or 3.12 (64-bit) |
| **Operating System** | Windows 10/11, Ubuntu 20.04+, Debian 11+, or macOS 12+ | Windows 11 or Linux Ubuntu 22.04 LTS |
| **RAM** | 2 GB available RAM | 4 GB+ |
| **Disk Space** | ~250 MB (Lightweight Python dependencies; no PyTorch or Docling bloat) | 500 MB |
| **Network** | Active internet connection for API inference calls | Broadband connection |
| **AI API Key** | Either a Google Gemini API key or NVIDIA NIM API keys | Google Gemini API key (free tier available at [Google AI Studio](https://aistudio.google.com/)) |

---

## 2. Obtaining Your AI API Key

ResumeDrop supports both **Google Gemini** (default, high-speed, 1M context) and **NVIDIA NIM** (Meta Llama 3.3 70B):

### Option A: Google Gemini API (Recommended & Default)
1. Go to **[https://aistudio.google.com/](https://aistudio.google.com/)** and sign in with your Google account.
2. Click **Get API key** and create a new key.
3. Copy the key (starts with `AIzaSy...`).
4. Set `GEMINI_API_KEY=your_key_here` in your `.env` file.

### Option B: NVIDIA NIM API (Optional Multi-Key Pool)
1. Visit **[https://build.nvidia.com/](https://build.nvidia.com/)** and sign in.
2. Under Models, select **Meta Llama 3.3 70B Instruct** (`meta/llama-3.3-70b-instruct`).
3. Click **Get API Key** to generate keys starting with `nvapi-`.
4. Up to 3 keys can be added to `.env` (`NVIDIA_API_KEY_1`, `NVIDIA_API_KEY_2`, `NVIDIA_API_KEY_3`) for automatic round-robin and sliding-window rate limiting.

---

## 3. Windows Setup (PowerShell)

### Step 1: Verify Python & Pip
Open **Windows PowerShell** (or Windows Terminal) and run:
```powershell
python --version
pip --version
```
Ensure Python 3.10 or higher is installed and added to your system `PATH`.

### Step 2: Clone or Download Repository
```powershell
git clone https://github.com/anuragrathod/ResumeDrop.git
cd ResumeDrop
```

### Step 3: Create & Activate Virtual Environment
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

> **Tip**: If PowerShell displays an `Execution_Policies` restriction error, run:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> .\.venv\Scripts\Activate.ps1
> ```

### Step 4: Install Dependencies
```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

### Step 5: Configure Environment
Copy `.env.example` to `.env`:
```powershell
Copy-Item .env.example .env
notepad .env
```
Paste your API key (e.g. `GEMINI_API_KEY=AIzaSy...`) and save the file.

### Step 6: Run the Web Application
```powershell
python -m uvicorn app:app --host 0.0.0.0 --port 3000 --reload
```
Open your browser and navigate to **`http://localhost:3000`**.

### Step 7: Run the Command-Line Demo (Optional)
```powershell
# Extract sample resumes and export directly to a 5-sheet Excel workbook:
python cli_demo.py --dir sample_resumes --extract --export output/candidates.xlsx --verbose
```

### Step 8: Run Automated Tests
```powershell
pytest
```

---

## 4. Linux & macOS Setup (Bash)

### Step 1: Install System Prerequisites
On Debian/Ubuntu:
```bash
sudo apt update
sudo apt install -y python3 python3-pip python3-venv build-essential
```
On macOS (using Homebrew):
```bash
brew install python@3.11
```

### Step 2: Clone or Enter Repository
```bash
git clone https://github.com/anuragrathod/ResumeDrop.git
cd ResumeDrop
```

### Step 3: Create & Activate Virtual Environment
```bash
python3 -m venv .venv
source .venv/bin/activate
```

### Step 4: Install Dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Step 5: Configure Environment
```bash
cp .env.example .env
nano .env   # or open with your preferred text editor
```
Set your `GEMINI_API_KEY` or `NVIDIA_API_KEY_1..3` and save.

### Step 6: Start the Server
```bash
bash run_dev.sh
```
or directly with Uvicorn:
```bash
python3 -m uvicorn app:app --host 0.0.0.0 --port 3000 --log-level info
```
Open your browser and navigate to **`http://localhost:3000`**.

### Step 7: Run CLI Demo & Unit Tests
```bash
# Run CLI extraction demo
python3 cli_demo.py --dir sample_resumes --extract --export output/candidates.xlsx --verbose

# Run all automated tests
pytest
```

---

## 5. Verifying the Setup

1. **Web Interface Access**:
   - Open `http://localhost:3000` in Google Chrome, Microsoft Edge, or Mozilla Firefox.
   - You will see the **Resume-to-Excel Automation** home view with a drag-and-drop upload zone and results table.
2. **API Connection Check**:
   - Click the **API Logs** tab in the top navigation bar.
   - Click **Check connection**.
   - An auto-dismissing green banner will confirm: `✓ All APIs are operational and working.`
   - A new log record will immediately display in the 5-column table displaying timestamp, model (`gemini-2.5-flash`), latency in milliseconds, and `200 OK` status.
3. **Resume Extraction Test**:
   - Return to the **Home** view.
   - Drag and drop `sample_resumes/alice_chen_resume.pdf` and `sample_resumes/bob_patel_resume.docx` into the upload zone.
   - Click **Extract Candidates**.
   - The live progress bar will track extraction progress via Server-Sent Events (SSE).
   - Once complete, inspect candidate details using the **View** button and click **Export Excel (.xlsx)** to download the 5-sheet workbook.

---

## 6. Troubleshooting & Common Questions

- **Port 3000 is already in use**:
  Set a custom port in `.env` (e.g. `PORT=8000`) and launch with:
  `python3 -m uvicorn app:app --host 0.0.0.0 --port 8000`.
- **API Rate Limits (HTTP 429)**:
  ResumeDrop contains an automatic sliding-window rate limiter (enforcing <= 40 requests/minute) with exponential backoff. If you encounter rate limits, wait a few moments for the cooldown period to expire.
- **Scanned or Image-only PDFs**:
  ResumeDrop specializes in digital text PDFs to remain lightweight (<250 MB). Scanned documents containing only raster images will be flagged as `empty` in the candidate audit log without crashing the batch.
