---
paths:
  - "**/claude-agents/**"
  - "**/openclaw-agents/**"
  - "**/agents/**/*.md"
  - "**/skills/**/*.md"
---

# Agent & Skill Authoring Rules

## Naming
- Agents: `verb-domain` format (e.g. analyze-deal, draft-proposal)
- Skills: `domain-type` format (e.g. oci-reference, fsi-compliance)
- All names: lowercase, hyphenated — never PascalCase

## Agent Structure
- YAML frontmatter required: name, description, tools, model
- Optional frontmatter: skills, maxTurns
- System prompt under 500 words where possible
- One agent = one clear responsibility

## OpenClaw Agents
- Each agent directory: IDENTITY.md, SOUL.md, TOOLS.md, AGENTS.md, HEARTBEAT.md, USER.md
- config/ and skills/ are git-tracked; logs/ and memory/ are gitignored (runtime only)
- Model routing: Claude Sonnet for complex reasoning, Kimi K2 (Ollama) for routine tasks
- Credentials via 1Password — reference by vault/item name, never raw values

## Security
- Never include PII (client names, deal numbers, contact info) in agent or skill definitions
- Use placeholders or parameterized references for customer-specific data
- Reference Oracle collateral by document name, not embedded content