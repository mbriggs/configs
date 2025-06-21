Create technical approach with step breakdown. Output to current/APPROACH.md and current/steps/.

## Context Loading
- Read current/INTENT.md for the goal
- Note complexity and risk level

## Create APPROACH.md
Include:
1. Technical strategy (2-3 paragraphs)
2. Key patterns to follow
3. Progress checklist
4. Implementation notes section

## Create Step Files
For each work session, create `current/steps/NN-name.md`:
- No more then can comfortably fit into one LLM session context
- Clear validation criteria
- Order by dependencies (what must exist first)
- Separate concerns (data layer, business logic, UI)

## Templates

APPROACH.md:
```markdown
# Technical Approach: [Feature]

## Strategy
[Overall plan]

## Key Patterns
- [Patterns from CLAUDE.md to follow]

## Progress
- [ ] 01: Setup database (steps/01-setup-database.md)
- [ ] 02: Core models (steps/02-core-models.md)

## Implementation Notes
[Updated during work]
````

Step file:

```markdown
# Step: [Name]

## Goal
[What this accomplishes]

## Tasks
- [ ] [Specific task]
- [ ] [Tests]

## Validation
[How to verify success]

## Commits
[Added after session]
```
