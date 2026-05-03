# Global Preferences — James Calise

## Identity
- Oracle pre-sales, FSI Cloud Engineering + CloudVine Consulting
- Email: jamescalise@icloud.com
- Mac Mini M4 (caliagent@mini via Tailscale) runs OpenClaw agents

## Code Style
- Python: pyproject.toml with src layout, snake_case, type hints, `from __future__ import annotations`
- JavaScript: camelCase, 2-space indent, prefer functional patterns
- Agent files: verb-domain naming (analyze-deal), skill files: domain-type (oci-reference)
- All names lowercase hyphenated

## Security (Always)
- 1Password for all secrets — never inline credentials
- OCI CLI config at ~/.oci/config — never commit
- Run /secrets-scan before distributing any zip or sharing files externally
- No PII in agent/skill definitions — use parameterized references

## Commit & Deploy
- Conventional commits (feat:, fix:, chore:, docs:, refactor:)
- Makefile + deploy.sh is the standard deploy pattern
- Always `terraform plan` before `terraform apply`

## Session Behavior
- Use /compact proactively when context gets heavy — don't wait for degradation
- Check memory/recent-memory.md at session start for rolling context
- Log new decisions, people, and terms discovered during sessions
- Keep responses concise — prefer tables and bullets over paragraphs for reference material

## gstack
Garry Tan's Claude Code skill pack, installed at `~/.claude/skills/gstack`.

- For all web browsing, use the `/browse` skill — **never** use `mcp__claude-in-chrome__*` tools.
- Available slash commands (loaded from gstack):
  - **Planning**: `/autoplan`, `/office-hours`, `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`
  - **Design**: `/design-consultation`, `/design-shotgun`, `/design-html`, `/design-review`
  - **Review & QA**: `/review`, `/cso`, `/qa`, `/qa-only`, `/devex-review`
  - **Ship**: `/ship`, `/land-and-deploy`, `/canary`, `/benchmark`
  - **Browser**: `/browse`, `/connect-chrome`, `/setup-browser-cookies`
  - **Lifecycle**: `/setup-deploy`, `/setup-gbrain`, `/retro`, `/investigate`, `/document-release`, `/learn`
  - **Safety/locks**: `/careful`, `/freeze`, `/guard`, `/unfreeze`
  - **Misc**: `/codex`, `/gstack-upgrade`
- Update with `/gstack-upgrade` (or `cd ~/.claude/skills/gstack && git pull && ./setup`).
