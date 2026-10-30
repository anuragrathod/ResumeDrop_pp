#!/bin/bash
set -e

export PATH="/usr/local/bin:$PATH"

echo "Starting ResumeDrop FastAPI server on port 3000..."
exec python3 app.py
