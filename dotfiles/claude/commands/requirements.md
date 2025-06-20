You're helping transform validated discovery into requirements. Create current/REQUIREMENTS.md.

## Conversation Approach

- One topic at a time - build naturally on responses
- Think like a curious partner, not an interviewer
- Surface assumptions and challenge gently
- Connect insights across the conversation
- Guide the discussion to build a compelling case.
- Scale depth with complexity

## Context Loading

- Read current/DISCOVERY.md if it exists
- Note validated findings and key insights
- Check for existing REQUIREMENTS.md to refine

If no discovery exists: "Starting requirements without discovery? Would you like to explore the problem first, or do you have high confidence already?"

## Build Requirements

Start with: "Let's capture requirements from what we've learned. Can you summarize the core problem and who it affects?" if that doesn't exist yet.

Through conversation, develop:

### Success Metrics

- How we'll measure success
- Current baseline vs targets
- What indicates wrong direction

### User Stories

- Main user flows and jobs to be done
- Edge cases and internal users
- Clear acceptance criteria

### Requirements

- **Must Have (P0)**: Critical for launch
- **Should Have (P1)**: Significant value
- **Nice to Have (P2)**: Future consideration

## Write to current/REQUIREMENTS.md

Use this structure (adapt as needed):

```markdown
# [Feature] Requirements

**Status**: Draft
**Based on**: [Link to DISCOVERY.md if exists]

## Problem Statement

[Problem, who it affects, current state, cost of inaction]

## Success Metrics

| Metric       | Baseline  | 3-Month Target | 6-Month Target |
| ------------ | --------- | -------------- | -------------- |
| [Key metric] | [Current] | [Goal]         | [Goal]         |

## User Stories

### [Primary User]

**As a** [user type]
**I want to** [action]
**So that** [outcome]

**Acceptance Criteria:**

- [ ] [Specific criterion]

## Requirements

### Must Have (P0)

- **[Feature]**: [Why critical]

### Should Have (P1)

- **[Feature]**: [Value added]

### Out of Scope

- **[Feature]**: [Why not now]

## Risks & Mitigations

| Risk   | Impact  | Mitigation |
| ------ | ------- | ---------- |
| [Risk] | [H/M/L] | [Strategy] |

## Open Questions

- [ ] [Needs answer before development]
- [ ] [Can be resolved during development]
```
