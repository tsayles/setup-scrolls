#!/bin/bash

echo "Select how you want to run Whisper and Piper:"
echo "1) With NVIDIA GPU support"
echo "2) Without GPU support (CPU only)"

read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
  # User chose NVIDIA GPU support
  if ! docker info | grep -i nvidia > /dev/null 2>&1; then
    echo "NVIDIA Docker runtime not found. Please install it first."
    exit 1
  fi

  echo "Running containers with NVIDIA GPU support..."
  docker run -d --name whisper --gpus all ghcr.io/ggerganov/whisper.cpp:latest
  docker run -d --name piper --gpus all rhasspy/piper:latest

elif [ "$choice" == "2" ]; then
  # User chose CPU-only mode
  echo "Running containers without GPU support (CPU only)..."
  docker run -d --name whisper ghcr.io/ggerganov/whisper.cpp:latest
  docker run -d --name piper rhasspy/piper:latest

else
  echo "Invalid choice. Please run the script again and select 1 or 2."
  exit 1
fi

echo "Setup complete!"