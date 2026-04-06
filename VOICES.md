# 🎙️ Voice Guidelines

Communication style guides for drafting messages in different contexts using Rovo Dev or any AI assistant.

Each file defines a distinct voice — tone, personality, dos and don'ts, signature phrases, and real example messages.

---

## Available Voices

| Voice | File | Use For |
|---|---|---|
| 🔵 Internal | [voice-internal.md](./voice-internal.md) | Teammates, managers, Slack, internal Confluence |
| 🟢 External | [voice-external.md](./voice-external.md) | Customers, prospects, account contacts |
| 🟣 Executive | [voice-executive.md](./voice-executive.md) | Senior leadership, C-level customer stakeholders |

---

## How to Use with Rovo Dev

Reference the appropriate file and describe your message context:

> "Using the voice guidelines in `voice-external.md`, draft a follow-up email to my Ford contact after our SF office visit."

> "Using `voice-internal.md`, write a Slack message to my manager flagging a business risk."

> "Using `voice-executive.md`, draft a message to my VP about a customer escalation at Cigna."

---

## How to Use with Claude Code

Load the relevant voice file into your Claude Code context at the start of a session:

```
/add voice-internal.md
```

Then reference it naturally in your prompts.

---

## Confluence Versions

These files are also published as Confluence pages in the [Voice Guidelines](https://hello.atlassian.net/wiki/spaces/~71202092255b7fb59645d3bbea2a3ae2c64183/pages/6762103520/Voice+Guidelines) section of Sarah's personal space and used as knowledge sources in the **Message Drafter** Rovo Agent.
