# MVP Acceptance Criteria

## AC-01 Anonymous access

A new user can start without registration. No user-account table, login route, or persistent progress is required.

## AC-02 PDF support and validation

Valid Arabic/English text and scanned PDFs within configured limits are accepted. Wrong type, corrupt, encrypted, oversized, and over-page-limit files are rejected safely in Arabic.

## AC-03 Selective OCR

Pages with adequate native text are not unnecessarily OCRed. Scanned/low-quality pages use `ara+eng` OCR and retain page numbering and confidence/degraded status.

## AC-04 Document learning map

A ready document exposes ordered units, lessons, key concepts, and page ranges. Every item traces to pages in the active PDF.

## AC-05 Explanation levels

The same source concept can be explained in beginner, intermediate, and advanced Arabic. Detail and terminology differ while source facts remain unchanged.

## AC-06 Strict grounding

Chat uses only the active document. An unanswerable question returns an Arabic not-found response. A partially answerable question clearly separates supported and unsupported portions.

## AC-07 Verified citations

Every substantive answer includes citations with correct page numbers and quotations that match stored source text. Clicking a citation opens the correct PDF page. No citation comes directly from unvalidated model output.

## AC-08 Summaries

The user can generate whole-document, unit, lesson/concept, short, and detailed summaries with source references.

## AC-09 Quizzes

The user can generate an MCQ quiz for a unit or page range, submit answers, receive an immediate score, see the correct answer and explanation, and open the source citation.

## AC-10 Flashcards

The user can generate and interactively review Q/A, term/definition, and concept/example cards with source references.

## AC-11 Real processing states

The UI displays actual processing stages and handles ready, degraded, failed, expired, and deleted states. It does not use fake progress.

## AC-12 Arabic responsive UX

All main journeys work in Arabic RTL on supported desktop and mobile viewport tests. Mixed-direction content remains readable.

## AC-13 Accessibility

Primary journeys are keyboard operable, have visible focus and accessible names, announce processing state, and pass the defined automated/manual WCAG 2.2 AA checks.

## AC-14 Session isolation

A session cannot access another session's document, pages, jobs, chat, generated content, or object storage data, even when valid IDs are known.

## AC-15 Immediate deletion

The user can select “End session and delete now.” New operations are blocked, all associated database/Redis/object artifacts are removed idempotently, and subsequent access fails.

## AC-16 Automatic expiry

Idle and absolute TTL expiry trigger cleanup. Cleanup failures retry and are observable without content logs.

## AC-17 OpenRouter abstraction

Analysis, chat, vision, and generation models are configured independently through environment variables or task profiles. Primary/fallback behavior is tested.

## AC-18 Privacy routing

When ZDR/privacy denial is required, every OpenRouter request enforces it. If no compliant route exists, the request fails safely and does not route to a less private endpoint.

## AC-19 Secret safety

No API key appears in Git history, web bundle, client network calls, logs, test snapshots, error responses, or documentation examples with real values.

## AC-20 Cost controls

The system enforces input/output token limits, question length, rate limits, task budgets, and maximum request cost. Metrics show content-free cost and token data.

## AC-21 Clean-clone operation

A developer can follow the documented clean-clone setup and run the full local stack with configured secrets. The verify command passes.

## AC-22 Release evidence

`docs/reports/release-readiness.md` maps every acceptance criterion to tests, commands, screenshots, or observed behavior and lists unresolved risks honestly.
