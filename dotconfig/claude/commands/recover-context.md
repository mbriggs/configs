Help me recover context and continue work in progress.

## Situation Assessment
Run these commands:
- `git status` - see uncommitted changes
- `git diff` - understand modifications
- `git log -5 --oneline` - recent commits
- Check for running processes/servers

## Context Recovery
1. Read current/INTENT.md for the goal
2. Read current/APPROACH.md if exists - check progress and implementation notes
3. If APPROACH.md exists, identify current step from progress checklist
4. Read current step file to see what was planned
5. Look at uncommitted changes to understand:
  - What was I implementing?
  - How far did I get?
  - What's half-finished?

## State Analysis
Based on the evidence:
- What's already working?
- What's partially complete?
- What's the logical next step?
- Any failing tests or errors to fix?

## Recovery Plan
Propose:
1. Quick wins to complete partial work
2. Tests to verify current state
3. Remaining tasks from current step
4. Where to create a commit point

Keep it tactical - we're resuming work, not replanning.
