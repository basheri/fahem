# MVP Scope

## Included

- Arabic responsive web UI without login.
- Single active PDF per session.
- Arabic and English text PDFs.
- Selective OCR for scanned pages using `ara+eng`.
- Page images and selective visual analysis for meaningful diagrams/tables/equation-heavy pages.
- Beginner/intermediate/advanced explanation level.
- Document map: units, lessons, concepts, page ranges.
- Grounded Arabic chat with answerability status, page citations, and verified quotations.
- PDF page navigation from citations.
- Whole-document and scoped summaries.
- MCQ generation, scoring, explanation, and citation.
- Interactive flashcards with citations.
- Immediate manual deletion, TTL cleanup, and lifecycle deletion.
- Configurable OpenRouter models, fallbacks, budgets, privacy rules, and structured outputs.
- Local Docker Compose and production-minded documentation.

## Explicitly deferred

- Accounts and persistent progress.
- Multiple concurrent documents per session.
- Audio explanations.
- Handwriting recognition guarantees.
- Full symbolic equation parsing or computer algebra.
- Teacher authoring tools.
- Collaboration and sharing.
- Native mobile apps.
- Internet search.
- Payment and subscription.
- Production multi-region architecture.

## MVP operational defaults

- 50 MB maximum file size.
- 300 maximum pages.
- 2-hour idle TTL.
- 24-hour absolute TTL.
- One processing job per session.
- One retry for invalid AI structured output; two transport retries with backoff.
- Privacy policy fails closed when required routing is unavailable.

## Scope-change rule

A proposed addition enters the MVP only if it is required to satisfy an existing acceptance criterion, fixes a security/privacy defect, or removes a blocker. Other additions go to the post-MVP backlog.
