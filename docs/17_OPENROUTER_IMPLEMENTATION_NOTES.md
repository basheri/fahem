# OpenRouter Implementation Notes

## Required request behavior

- Use the API only from server-side code.
- Use valid model IDs configured by task profile.
- Request structured outputs for compatible models and validate them again locally.
- Set provider data collection to deny.
- Set `zdr: true` when Zero Data Retention is required.
- Ensure fallback routes meet identical privacy and parameter requirements.
- Enforce request timeout, bounded retry, token caps, and cost caps.
- Record content-free model/latency/token/cost metadata.

## Fail-closed privacy

When `OPENROUTER_REQUIRE_ZDR=true`, a lack of compliant endpoints is an availability failure, not permission to use a non-ZDR endpoint. Return a temporary Arabic service message and preserve the document state.

## Deployment verification

At deployment time, verify the selected model endpoints and OpenRouter account settings. Provider policies can differ by endpoint and can change. Do not hard-code a permanent claim based only on model family name.

## Official references

- Quickstart: https://openrouter.ai/docs/quickstart
- Structured outputs: https://openrouter.ai/docs/guides/features/structured-outputs
- Provider routing: https://openrouter.ai/docs/guides/routing/provider-selection
- Zero Data Retention: https://openrouter.ai/docs/guides/features/zdr
- Data collection: https://openrouter.ai/docs/guides/privacy/data-collection
- Provider logging: https://openrouter.ai/docs/guides/privacy/provider-logging
