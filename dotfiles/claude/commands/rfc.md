You're helping create an RFC for stakeholder review. Write to current/RFC.md based on our discussion.

## Context Loading

- Read current/ARCHITECTURE.md for technical approach and decisions
- Read current/INTENT.md and current/APPROACH.md if they exist
- Note workflow recommendation (Standard/Complex) from PLAN.md
- Understand the problem, solution, and trade-offs already explored

## Conversation Approach

- One topic at a time - build naturally on responses
- Think like a curious partner, not an interviewer
- Surface assumptions and challenge gently
- Connect insights across the conversation
- Guide the discussion to build a compelling case.
- Scale depth with complexity

## Building Strong Arguments

Through conversation, help develop:

- Concrete examples instead of abstractions
- Metrics and data over general statements
- Specific mitigations for each risk
- Clear, measurable success criteria
- Business value connection

## RFC Structure

Write to current/RFC.md using this template (adapt as needed):

```markdown
# [Feature Name] RFC

## Problem

[Clear 1-2 sentence problem statement]

## Current State

[What exists today and why it's insufficient]

## Goals and Non-Goals

**Goals:**

- [What we will achieve]
- [Measurable outcomes]

**Non-Goals:**

- [What we explicitly won't do]
- [Scope boundaries]

## Stakeholders

- [Role]: [Interest/concern]
- [Role]: [Interest/concern]

## Solution

[Detailed technical approach with reasoning]

### Implementation Overview

[High-level how it works]

### Technical Details

[Specifics that reviewers need]

### Success Criteria

[How we know it's working]

## Alternative Solutions

### Option A: [Alternative]

- Pros: [Benefits]
- Cons: [Drawbacks]
- Why not chosen: [Reasoning]

### Option B: [Alternative]

[Same structure]

## Tradeoffs

[Downsides we're accepting with chosen approach]

## Dependencies

- [Technical dependencies]
- [Team dependencies]
- [External dependencies]

## Concerns

### Security

[Implications and mitigations]

### Performance

[Expected impact and monitoring plan]

### Compliance/PHI/PII

[If applicable - requirements and approach]

### Costs

- Development: [Estimate]
- Infrastructure: [Ongoing costs]
- Maintenance: [Long-term burden]

### How can this break?

[Failure modes and symptoms]

### How do we know it works?

[Validation and monitoring approach]

## Implementation Plan

### Phase 1: [Name]

[What happens, success criteria]

### Phase 2: [Name]

[What happens, success criteria]

### Rollback Plan

[How to undo if needed]

## Feature Flags

[Specific flags and rollout strategy]

## Monitoring & Alerts

[What we'll track and alert thresholds]

## Open Questions

- [ ] [Questions needing answers before proceeding]
- [ ] [Questions that can be resolved during implementation]
```

## Adapt Based on Feature Type

**Add sections as needed:**

- Data migrations: Add "Data Integrity Plan"
- API changes: Add "Client Migration Guide"
- Breaking changes: Add "Deprecation Timeline"
- Performance work: Add "Benchmark Results"

**Remove sections if irrelevant:**

- Internal tool might not need "Compliance"
- UI change might not need "Performance"

## Quality Checks

As we build the RFC, ensure:

- Problem is compelling and quantified
- Solution clearly addresses the problem
- Alternatives were genuinely considered
- Risks are acknowledged with mitigations
- Success is measurable
- Rollback is possible

Update current/RFC.md throughout our discussion. Once complete, it's ready for stakeholder review.
