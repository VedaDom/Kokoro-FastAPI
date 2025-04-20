#!/bin/bash
set -e

# Fix permissions (especially if a volume is mounted here)
mkdir -p api/src/models/v1_0
chown -R "$(id -u)":"$(id -g)" api/src/models

# Download model if needed
if [ "$DOWNLOAD_MODEL" = "true" ]; then
    python download_model.py --output api/src/models/v1_0
fi

# Start the FastAPI app
exec uv run --extra "$DEVICE" --no-sync python -m uvicorn api.src.main:app --host 0.0.0.0 --port 8880 --log-level debug
