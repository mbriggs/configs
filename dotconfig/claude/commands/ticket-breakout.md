Break down architecture into implementable tickets. Create files in current/tickets/.

## Context
- Read current/ARCHITECTURE.md for components and boundaries
- Read current/REQUIREMENTS.md for priorities
- Look for natural seams: services, APIs, database tables, major classes

## Ticket Creation Rules
1. One architectural component = one ticket (unless it's too big)
2. Size limits: S = 1-2 days, M = 3-5 days, L = 1-2 weeks
3. If bigger than L, split along:
  - Data model vs business logic
  - CRUD vs complex operations
  - Happy path vs error handling

## Ticket Format
Create files like: `001-user-authentication.md`, `002-payment-processing.md`

```

# [Clear outcome]

Size: [S/M/L with specific reason] Depends on: [ticket numbers] Blocks: [ticket numbers]

## Context

From requirements: [specific requirement being addressed] From architecture: [specific decision being implemented]

## Deliverables

- [ ] Implementation: [specific files/classes]
- [ ] Tests: [unit/integration/e2e]
- [ ] Docs: [what needs updating]

## Definition of Done

[How to verify this works independently]

```

## Output
1. Create numbered ticket files in dependency order
2. Create current/tickets/DEPENDENCIES.md showing the DAG
3. Suggest team assignment if clear from architecture
