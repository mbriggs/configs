Help me break down architecture into implementable tickets.

## Context Loading

Read:

- current/REQUIREMENTS.md for user stories and priorities
- current/ARCHITECTURE.md for technical approach and boundaries
- Any CLAUDE.md for team conventions

## Ticket Creation Strategy

Using architecture boundaries, create tickets that:

- Follow the technical decisions in ARCHITECTURE.md
- Implement one architectural component or integration
- Can be developed and tested independently
- Build in dependency order
- Store ticket files in current/tickets subfolder

## Breaking Down by Architecture

For each architectural component/boundary:

1. **Foundation tickets** (schema, interfaces, base classes)
2. **Core implementation** (business logic, services)
3. **Integration tickets** (connecting components)
4. **Validation tickets** (testing, monitoring)

## Ticket Format

```
Title: [Component/Outcome]
Size: [S/M/L based on architecture complexity]
Dependencies: [Other tickets, following architecture flow]

Context:
- From REQUIREMENTS: [Which user story this serves]
- From ARCHITECTURE: [Which decisions apply]

Deliverables:
- [ ] [Specific technical outcome]
- [ ] [Tests/validation]
- [ ] [Documentation updates]

Success Criteria:
[How we verify this piece works in isolation]
```

## Dependency Sequencing

Order tickets based on:

- Architecture's data flow
- Integration dependencies
- Risk mitigation (unknowns first)
- Team parallelization opportunities

The architecture has already made the hard decisions - we're just breaking it into executable chunks.
