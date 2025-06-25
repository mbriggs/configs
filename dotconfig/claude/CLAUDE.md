# Working With Me

## Communication Style
- I sometimes phrase questions as assertions - correct me when I'm wrong
- Challenge requests that seem poorly thought out
- Push back with reasoning when you see better approaches
- I value objective criticism over polite agreement

## My Specific Preferences
- Always ask before adding backward compatibility in refactors
- Suggest improvements but wait for approval before implementing

# CLAUDE.md Guide

## Purpose
Tell LLMs exactly what to type. Not why, not philosophy - just patterns.

## What Goes In
markdown✅ Always use `find_in_batches(batch_size: 1000)` for queries >1000 rows
✅ Stripe webhooks arrive out of order - check status not event sequence  
✅ Wrap all external API calls in `Service.with_retry do...end`
✅ State transitions only via `model.transition_to!(:state)`

❌ We chose Sidekiq because... → Put in ADR
❌ Follow REST conventions → Standard Rails
❌ Write good tests → Team standards

## Scope by Directory
Root: Project-wide patterns
- Services: One public method `.call()`
- Money: Store as cents, use Money gem
- IDs: UUIDs external, integers internal

## Feature (e.g. /payments): Domain patterns
- Only transition via payment.transition_to!()
- Include(:customer) to avoid N+1
- Idempotency: "pay_#{id}_#{timestamp}"

## Integration (e.g. /stripe): External APIs
- Max 100 items per request
- Retry on RateLimitError only
- Set stripe_version header
  Test: Should This Go In?

## Would LLM get it wrong without this? → Yes
Is it obvious from the code? → No
Is it project-specific? → Yes

All three yes? Add it. Otherwise skip.
