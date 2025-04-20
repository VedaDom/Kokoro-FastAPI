#!/bin/bash
set -e

# Ensure the model directory exists
mkdir -p api/src/models/v1_0

# Only download the model if requested
if [ "$DOWNLOAD_MODEL" = "true" ]; then
    python download_model.py --output api/src/models/v1_0
fi

# Start the FastAPI app using uv
exec uv run --extra "$DEVICE" --no-sync python -m uvicorn api.src.main:app --host 0.0.0.0 --port 8880 --log-level debug
