# Security Policy

## Reporting

Do not open a public issue for a vulnerability involving secret exposure, unauthorized document access, deletion failure, prompt injection, malicious file processing, or remote code execution. Report it privately to the repository owner through the repository's private security advisory feature.

Include reproduction steps, affected commit, impact, and suggested mitigation when possible. Do not include real user PDFs, prompts, API keys, or personal data.

## Security priorities

The highest-priority security properties are:

1. Anonymous session isolation and prevention of IDOR.
2. Server-only secret handling.
3. Safe PDF validation and processing.
4. Prompt-injection resistance.
5. Strict document grounding and citation verification.
6. Reliable cascading deletion and expiration.
7. Privacy-aware OpenRouter routing.
8. Content-free production logging.
