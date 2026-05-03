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