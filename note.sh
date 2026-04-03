#!/bin/bash
# note.sh — Capture a timestamped note for today

NOTES_DIR="$(dirname "$(realpath "$0")")"
TODAY="$(date +%Y-%m-%d)"
NOTES_FILE="$NOTES_DIR/$TODAY.txt"
TIMESTAMP="$(date +%H:%M)"

if [ -z "$1" ]; then
  echo "Usage: ./note.sh \"Your note here\""
  exit 1
fi

# Create file with header if it doesn't exist
if [ ! -f "$NOTES_FILE" ]; then
  echo "# Notes — $TODAY" >> "$NOTES_FILE"
  echo "" >> "$NOTES_FILE"
fi

echo "[$TIMESTAMP] $1" >> "$NOTES_FILE"
echo "✅ Note saved: [$TIMESTAMP] $1"
