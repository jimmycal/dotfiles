---
paths:
  - "**/fsi-dashboards/**"
  - "**/FSI_*Dashboard*.html"
  - "**/EA_Coverage*.html"
  - "**/Market_Development*.html"
---

# FSI Dashboard Rules

## JavaScript Style
- Use `var` (not `const`/`let`) in page-level HTML scripts to prevent re-declaration errors with shared modules
- `const`/`let` is fine inside serve.js and Python pipeline code
- EA Coverage has its own inline JS — never import shared/js/table.js, charts.js, or filters.js into it

## Design System
- Always use CSS custom properties from shared/css/dashboard.css (e.g. `var(--oracle-red)`, `var(--bg)`)
- Never hardcode colors — use `var(--muted)` not `var(--gray)`, `var(--text)` not `var(--navy)`
- Badges use `border-radius: 4px` (not pill-shaped)
- Oracle red (`#C74634`) for active tab underlines and primary buttons — never blue

## Data Pipeline
- EA Coverage data is baked into HTML by Python pipeline — don't look for a loading bug if data seems stale, re-run process_weekly_report.py instead
- Dashboard Pack contains sheets: Playground, Triage, Market_Development, Territory, Territory_Summary, Territory_Parents
- Market Dev saves to IndexedDB + server CSV via /save endpoint — edits are automatic

## Pre-Distribution
- Run /secrets-scan then /audit before zipping for OneDrive distribution
- Check env.local paths and embedded data for leaked OneDrive paths