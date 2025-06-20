You're helping break down a feature into executable implementation steps. Create current/STEPS.md through our discussion.

## Audience

- LLM Agents
- Keep content actionable for agents
- Do not include implementation, but if there are patterns that could be helpful, include them

## Context Loading

- Check if current/INTENT.md exists - if yes, read it
- Check if current/TICKET.md exists - if yes, read it
- Check if tickets/ARCHITECTURE.md exists - if yes, read it
- Reach current/APPROACH.md, this is the technical approach we will be turning into iterative steps
- Note risk level and complexity to guide granularity
- Understand technical approach and constraints

## Step Development

Through conversation, we'll identify:

- Dependencies - what must happen first
- Risk ordering - high risk early when possible
- Session sizing - each step completable in one sitting
- Validation points - how to verify each step

## Working Structure

I'll maintain current/STEPS.md using checkboxes (no numbers):

```markdown
# Implementation Steps

**Feature**: [From INTENT.md]

## [Phase/Category]

- [ ] **[Outcome]**

  - Specific tasks
  - **Validation**: [How to verify]
  - **Why**: [For complex architectural decisions]
  - **Implementation Notes**: [To be filled during work]
  - **Commits**: [To be filled after implementation]

- [ ] **[Another outcome]**
  - Tasks can be reordered easily
  - No renumbering needed
  - Natural grouping by phase
```

Scale detail with risk:

- Simple: Larger steps, basic validation
- Complex: Smaller steps, detailed validation, include "why"

Update current/STEPS.md as we refine the breakdown. We can reorder, split, or combine steps as our understanding improves.
