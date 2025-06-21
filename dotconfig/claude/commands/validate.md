Validate that implementation matches planned approach. Identify any drift or discoveries.

## Context Loading
- Read current/INTENT.md for original goal
- Read current/REQUIREMENTS.md if exists
- Read current/ARCHITECTURE.md for technical decisions
- Read current/APPROACH.md if exists
- Review recent commits and current code changes

## Validation Checks

### Requirements Alignment
- [ ] Each requirement has corresponding implementation
- [ ] No requirements were missed
- [ ] No scope creep (features not in requirements)

### Architecture Compliance
- [ ] Technical decisions from ARCHITECTURE.md were followed
- [ ] Component boundaries remain clean
- [ ] No architectural rules broken

### Pattern Consistency
- [ ] Code follows patterns in relevant CLAUDE.md files
- [ ] No new patterns that should be documented
- [ ] No gotchas discovered that need capturing

## Drift Analysis
For any divergences found:
1. Was the drift necessary? Why?
2. Should we update the plan or fix the code?
3. What documentation needs updating?

## Output
1. **Compliance Report**: What matches/diverges from plan
2. **Documentation Updates**: Required changes to CLAUDE.md/ADRs
3. **Technical Debt**: Shortcuts taken that need tracking
4. **Recommendations**: Fix code or update docs?

Run this before marking work complete to ensure plans match reality.
