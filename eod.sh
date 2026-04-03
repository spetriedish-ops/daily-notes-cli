#!/bin/bash
# eod.sh — Generate an end-of-day bullet summary from today's notes

NOTES_DIR="$(dirname "$(realpath "$0")")"
TODAY="$(date +%Y-%m-%d)"
NOTES_FILE="$NOTES_DIR/$TODAY.txt"

if [ ! -f "$NOTES_FILE" ]; then
  echo "📭 No notes found for today ($TODAY)."
  echo "   Use ./note.sh \"Your note\" to start capturing notes."
  exit 0
fi

echo ""
echo "========================================"
echo "  📝 End-of-Day Summary — $TODAY"
echo "========================================"
echo ""

# Count notes
NOTE_COUNT=$(grep -c "^\[" "$NOTES_FILE" 2>/dev/null || echo 0)
echo "  Total notes captured: $NOTE_COUNT"
echo ""
echo "  What I accomplished today:"
echo ""

# Print each note as a bullet
while IFS= read -r line; do
  # Skip header lines and blank lines
  if [[ "$line" == \#* ]] || [[ -z "$line" ]]; then
    continue
  fi
  # Format: [HH:MM] note → • note (HH:MM)
  if [[ "$line" =~ ^\[([0-9]{2}:[0-9]{2})\]\ (.*) ]]; then
    TIME="${BASH_REMATCH[1]}"
    NOTE="${BASH_REMATCH[2]}"
    echo "  • $NOTE  ($TIME)"
  else
    echo "  • $line"
  fi
done < "$NOTES_FILE"

echo ""
echo "========================================"
echo ""

# Optional: ask if user wants to save summary locally
read -p "  💾 Save summary to eod-$TODAY.txt? (y/n): " SAVE
if [[ "$SAVE" == "y" || "$SAVE" == "Y" ]]; then
  SUMMARY_FILE="$NOTES_DIR/eod-$TODAY.txt"
  {
    echo "End-of-Day Summary — $TODAY"
    echo "========================================"
    echo "Total notes: $NOTE_COUNT"
    echo ""
    echo "What I accomplished today:"
    while IFS= read -r line; do
      if [[ "$line" == \#* ]] || [[ -z "$line" ]]; then continue; fi
      if [[ "$line" =~ ^\[([0-9]{2}:[0-9]{2})\]\ (.*) ]]; then
        echo "  • ${BASH_REMATCH[2]}  (${BASH_REMATCH[1]})"
      else
        echo "  • $line"
      fi
    done < "$NOTES_FILE"
  } > "$SUMMARY_FILE"
  echo "  ✅ Summary saved to: $SUMMARY_FILE"
fi

# Optional: publish to Confluence as part of weekly page
echo ""
read -p "  🌐 Publish to Confluence? (y/n): " PUBLISH
if [[ "$PUBLISH" == "y" || "$PUBLISH" == "Y" ]]; then
  # Determine the week range (Mon–Fri) for the page title
  WEEK_START=$(date -v-$(date +%u)d +%Y-%m-%d 2>/dev/null || date -d "last monday" +%Y-%m-%d 2>/dev/null || echo "$TODAY")
  WEEK_END=$(date -v+$((5-$(date +%u)))d +%Y-%m-%d 2>/dev/null || date -d "next friday" +%Y-%m-%d 2>/dev/null || echo "$TODAY")
  WEEK_TITLE="Week of $WEEK_START"

  # Build HTML content for today's section
  HTML_FILE="$NOTES_DIR/tmp_rovodev_eod_confluence.html"
  {
    echo "<h2>📅 $TODAY</h2>"
    echo "<ul>"
    while IFS= read -r line; do
      if [[ "$line" == \#* ]] || [[ -z "$line" ]]; then continue; fi
      if [[ "$line" =~ ^\[([0-9]{2}:[0-9]{2})\]\ (.*) ]]; then
        echo "  <li>${BASH_REMATCH[2]} <em>(${BASH_REMATCH[1]})</em></li>"
      else
        echo "  <li>$line</li>"
      fi
    done < "$NOTES_FILE"
    echo "</ul>"
    echo "<p><em>Total notes: $NOTE_COUNT</em></p>"
  } > "$HTML_FILE"

  echo ""
  echo "  📄 Weekly Confluence page title: \"$WEEK_TITLE\""
  echo "  📁 Parent page: EOD Summaries (your personal space)"
  echo ""
  echo "  ℹ️  To publish, ask Rovo Dev:"
  echo "     \"Please create or update my Confluence EOD Summaries page titled '$WEEK_TITLE'"
  echo "      under https://hello.atlassian.net/wiki/spaces/~71202092255b7fb59645d3bbea2a3ae2c64183/pages/6753401618"
  echo "      with the content from ~/notes/tmp_rovodev_eod_confluence.html\""
  echo ""
  echo "  ✅ HTML file ready at: $HTML_FILE"
fi
