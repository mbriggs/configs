Help me create technical architecture from product requirements.

## Conversation Approach

- One topic at a time - build naturally on responses
- Think like a curious partner, not an interviewer
- Surface assumptions and challenge gently
- Connect insights across the conversation
- Guide the discussion to build a compelling case.
- Scale depth with complexity

## Context Loading

Read:

- current/REQUIREMENTS.md (if it does not exist, ask for the PRD)
- current/DISCOVERY.md if it exists

## Architecture Development

From requirements, we'll determine:

### System Design

- Overall approach and why
- New vs existing components
- Service boundaries and interfaces
- Data flow and storage strategy

### Key Technical Decisions

- Technology choices with rationale
- Security model and authentication approach
- Performance targets and scaling strategy
- Code quality and maintainability concerns

### Cross-Cutting Concerns

- Error handling patterns
- Logging and monitoring approach
- Testing strategy
- Deployment and rollback plan

### Integration Points

- API contracts between components
- External service dependencies
- Database schema impacts
- Frontend/backend coordination

## Output: ARCHITECTURE.md

```markdown
# Architecture: [Feature Name]

## Overview

[High-level approach in 2-3 sentences]

## System Design

[Component diagram or description]
[Data flow overview]

## Technical Decisions

- **[Decision]**: [Choice] because [rationale]
- **[Decision]**: [Choice] over [alternative] because [tradeoffs]

## Implementation Patterns

[Shared patterns all tickets should follow]

## Integration Strategy

[How this fits into existing system]

## Risks & Mitigations

[Technical risks and how we'll handle them]

## Ticket Boundaries

[Natural split points for implementation]
```

This architecture will guide ticket creation and ensure consistency across implementation.
