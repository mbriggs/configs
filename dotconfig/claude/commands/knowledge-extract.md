Extract valuable patterns from completed work into documentation.

## Context
- Read current/ artifacts to understand what was built
- Pay special attention to APPROACH.md implementation notes (if it exists)
- Run `git log --oneline -20` for recent commits
- Run `git show [hash]` for commits with interesting messages
- Find existing CLAUDE.md/README.md files at relevant levels
- Check for decisions/ or docs/adr/ directories

## Mining Commits
Look for commit messages that explain:
- Major changes ("Switch from X to Y...")
- Workarounds ("Fix X by doing Y because...")
- Failed attempts ("Revert: tried X but...")
- Performance fixes ("Cache X to avoid N+1...")

## Documentation Types
**CLAUDE.md**: Patterns and gotchas for AI assistants
**README.md**: What it does and how to use it
**ADR (decisions/YYYY-MM-DD-title.md)**: Why we chose X over Y

## When to Create an ADR
- Chose between multiple valid approaches
- Made a non-obvious technical decision
- Accepted significant tradeoffs
- Changed direction from previous approach

## ADR Format
```markdown
# [Title]
Date: YYYY-MM-DD

## Status
Accepted

## Context
[What forced this decision]

## Decision
[What we chose]

## Consequences
[Tradeoffs we accepted]

## Alternatives Considered
[What else we tried/evaluated]
```

## Output

For each insight, recommend:

- Documentation type (CLAUDE.md, README.md, or new ADR)
- Specific content to add
- Location in project hierarchy
