Analyze CLAUDE.md and README.md files for effectiveness and staleness.

## Process
- Read CLAUDE.md and README.md at specified path
- Scan recent code changes in that directory
- Check documentation against actual code

## Validation Checks

### CLAUDE.md
- Do patterns match current code?
- Are gotchas still relevant?
- Missing patterns (repeated code without docs)
- Dead imports/modules referenced

### README.md
- Does architecture description match code structure?
- Are usage examples still valid?
- Do performance notes reflect current implementation?
- Missing major components in overview?

### Cross-Check
- Is there overlap that should be consolidated?
- Does README "why" conflict with CLAUDE.md "what"?
- Are they targeting right audience (human vs AI)?

## Output
1. Stale entries to update/remove
2. Missing documentation for new patterns
3. Conflicts between docs and code
4. Suggested moves between README/CLAUDE.md
