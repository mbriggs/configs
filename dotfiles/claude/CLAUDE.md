# CORE PRINCIPLES [HIGHEST PRIORITY]

- ✅ DO: Follow exactly what is asked for and no more - suggesting improvements is encouraged, but implementing them without asking is not acceptable
- ✅ DO: Prioritize clear, straightforward solutions (Simplicity First)
- ✅ DO: Follow standards unless simplicity dictates otherwise
- ✅ DO: Ask explicitly whether backward compatibility is required during refactors - don't assume it is unless specified
- ❌ DON'T: Add optimization or abstraction without demonstrated need

# GIT COMMIT STYLE

## Format

All commits follow conventional commits format:

```
type(scope): description

[body]

[footer]
```

## Rules

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, semicolons, etc)
- `refactor`: Code refactoring without feature changes
- `test`: Test additions or modifications
- `chore`: Build process, dependencies, or tooling changes

### Message Structure
- **Subject**: Imperative mood, no caps, no period, max 50 chars, WHAT changed
- **Body**: Blank line after subject, explains WHY, wrap at 72 chars
- **Footer**: `Refs: TICKET-123` and/or `BREAKING CHANGE: description`

### Principles
- ✅ DO: One logical change per commit
- ✅ DO: Explain why in body, not just what
- ✅ DO: Keep commits atomic and revertable
- ❌ DON'T: Commit half-done work
- ❌ DON'T: Mix unrelated changes

### Examples

```
feat(auth): add JWT validation middleware

Adds token validation to protect API endpoints because 
we need to secure user data before the public launch.

Refs: RAIL-523
```

```
refactor(auth): extract token parsing logic

Separates concerns to make the validation logic easier 
to test and reuse in websocket connections.

BREAKING CHANGE: auth.Parse() now returns (*Claims, error) 
instead of (string, error)
```