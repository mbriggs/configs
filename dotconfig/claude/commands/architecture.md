Design technical architecture for features. I'll investigate the codebase, ask clarifying questions, then create ARCHITECTURE.md.

## Context Loading
1. Read current/REQUIREMENTS.md (or ask for PRD if missing)
2. Read current/DISCOVERY.md if exists
3. Investigate relevant code areas mentioned in requirements
4. Check existing architecture patterns in the codebase

## Investigation
Ask about:
- How does this fit with existing systems?
- What needs to be built vs modified?
- What are the main technical risks?
- Where are the natural boundaries?

Challenge assumptions when you see issues.

## Output to ARCHITECTURE.md
After investigation, create with:
- Overview (2-3 sentences)
- Component design with rationale
- Key technical decisions and tradeoffs
- Integration points with existing systems
- Implementation patterns to follow
- Risks and mitigations
- Natural ticket boundaries

Keep it concrete and actionable. Reference specific files/classes where relevant.
