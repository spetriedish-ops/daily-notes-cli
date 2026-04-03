# 📝 Daily Notes & EOD Summary

A lightweight CLI tool to capture notes throughout the day and generate a clean end-of-day bullet summary.

---

## Setup (one-time)

Make the scripts executable:

```bash
chmod +x ~/notes/note.sh
chmod +x ~/notes/eod.sh
```

Optionally, add aliases to your `~/.zshrc` for quick access:

```bash
alias note="~/notes/note.sh"
alias eod="~/notes/eod.sh"
```

Then reload your shell:

```bash
source ~/.zshrc
```

---

## Usage

### Capture a note
```bash
./note.sh "Finished Charter HELA deal review"
./note.sh "Joined sync with Ania re: Ford strategy"
./note.sh "Sent EOD update to Nick"
```

Each note is saved with a timestamp to `~/notes/YYYY-MM-DD.txt`.

### Generate end-of-day summary
```bash
./eod.sh
```

This prints a formatted bullet summary of everything you captured today, and optionally saves it to `~/notes/eod-YYYY-MM-DD.txt`.

---

## File Structure

```
~/notes/
├── note.sh          # Add a note
├── eod.sh           # Generate EOD summary
├── README.md        # This file
├── 2026-04-03.txt   # Today's raw notes
├── eod-2026-04-03.txt  # Saved EOD summary (optional)
└── ...
```

---

## Publishing to Confluence

When you run `./eod.sh` and choose to publish, it will:
1. Generate an HTML file at `~/notes/tmp_rovodev_eod_confluence.html`
2. Tell you the weekly page title (e.g., `Week of 2026-03-30`)
3. Prompt you to ask Rovo Dev to publish it

**Then just tell Rovo Dev:**
> "Please create or update my Confluence EOD Summaries page titled 'Week of YYYY-MM-DD' under https://hello.atlassian.net/wiki/spaces/~71202092255b7fb59645d3bbea2a3ae2c64183/pages/6753401618 with the content from ~/notes/tmp_rovodev_eod_confluence.html"

Rovo Dev will create a new weekly child page (or update it if it already exists) under your **EOD Summaries** parent page in your personal Confluence space.

🔗 **EOD Summaries parent page:** https://hello.atlassian.net/wiki/spaces/~71202092255b7fb59645d3bbea2a3ae2c64183/pages/6753401618/EOD+Summaries

---

## Example Output

```
========================================
  📝 End-of-Day Summary — 2026-04-03
========================================

  Total notes captured: 4

  What I accomplished today:

  • Reviewed DD-26823 Charter HELA deal  (09:15)
  • Joined sync with Ania re: Ford strategy  (10:30)
  • Sent follow-up email to Capital One team  (13:45)
  • Completed weekly SOLPROJ-13 update  (16:00)

========================================
```
