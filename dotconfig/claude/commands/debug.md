Help diagnose and fix production issues systematically.

## Context Gathering
- Capture error message/symptoms
- Check recent commits: `git log --oneline -10`
- Search for similar errors in codebase
- Read relevant CLAUDE.md for known gotchas
- Check monitoring/logs if available

## Systematic Debugging

### 1. Reproduce
- [ ] Can we reproduce locally?
- [ ] What are exact steps?
- [ ] Environment differences?
- [ ] Data-specific issue?

### 2. Isolate
- When did it last work?
- What changed recently?
- Which component is failing?
- Is it affecting all users or subset?

### 3. Root Cause Analysis
For each hypothesis:
- Evidence for/against
- How to test this hypothesis
- What logs would confirm?

### 4. Fix Approach
- Minimal fix for immediate relief
- Proper fix for long term
- What tests prevent regression?

## Documentation Triggers

If this issue was caused by:
- Non-obvious behavior → Update CLAUDE.md gotchas
- Architectural assumption → Consider ADR
- Missing validation → Update patterns

## Output
1. **Immediate mitigation** (if needed)
2. **Root cause** (confirmed)
3. **Fix implementation**
4. **Tests to add**
5. **Documentation updates**

Remember: Future developers will hit this too. Document what would have helped you.
