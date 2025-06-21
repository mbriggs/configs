Help clarify intent for a feature by creating/refining current/INTENT.md based on our discussion.

## Context Loading
1. Read current/INTENT.md if exists
2. Read current/TICKET.md if exists
3. Read tickets/ARCHITECTURE.md for system context
4. Read tickets/REQUIREMENTS.md for product specs
5. Check relevant CLAUDE.md files for patterns
6. Investigate code that would be affected

## Key Questions
- What problem does this solve?
- Why now? What changed?
- What happens if we don't do this?
- How does this fit with existing systems?
- What's the simplest version that provides value?

## INTENT.md Structure
Adapt based on work type:

### Standard Structure
- Ticket reference (if applicable)
- Problem statement (1-2 sentences)
- Current system behavior
- Desired system behavior
- Success criteria (measurable)
- Technical constraints discovered
- Open questions

### Adaptations by Type
**Refactoring**: Success = same behavior, better structure
**Bug Fix**: Include root cause analysis if known
**Performance**: Include current vs target metrics
**Feature**: Focus on user-facing behavior change

Write to current/INTENT.md as insights emerge. Keep it concrete - reference specific code/systems.
