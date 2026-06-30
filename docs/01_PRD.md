# Product Requirements Document — Fahem AI

## 1. Product summary

Fahem AI transforms an academic PDF into an Arabic interactive learning workspace. The product is intended for university students across disciplines and requires no account. The active PDF is the sole knowledge source for explanations and answers.

## 2. Problem

Academic PDFs are often long, dense, bilingual, visually complex, or scanned. Students need structured explanations and active-learning tools, but generic chat systems may hallucinate, ignore page context, or use outside knowledge without disclosure.

## 3. Product goals

- Reduce the effort required to understand an academic PDF.
- Convert the document into units, lessons, concepts, and a learning path.
- Adapt Arabic explanations to beginner, intermediate, or advanced level.
- Provide trustworthy document-grounded answers with page evidence.
- Support active recall through quizzes and flashcards.
- Minimize stored data and delete session artifacts automatically.

## 4. Non-goals for MVP

- User accounts, profiles, subscriptions, or permanent progress.
- Internet search or external knowledge augmentation.
- Collaborative annotations or teacher dashboards.
- LMS/SIS integration.
- Native mobile applications.
- Guaranteed perfect OCR of handwriting or mathematical notation.
- Audio narration.
- Permanent document libraries.

## 5. Primary user

A university student using a laptop or mobile browser who has an Arabic or English academic PDF and wants an Arabic explanation.

## 6. Core journey

1. Student opens the Arabic landing page.
2. Student reads privacy and file-limit information.
3. Student uploads one PDF.
4. Client and server validate the file.
5. Student selects beginner, intermediate, or advanced level.
6. System processes the document and displays actual stage progress.
7. System presents a document map and learning path.
8. Student reads explanations, asks questions, opens citations, generates summaries, quizzes, and flashcards.
9. Student ends the session and deletes data, or data expires automatically.

## 7. Functional requirements

### FR-01 Upload and validation

The system shall accept one PDF per active anonymous session, validate type and limits, reject unsafe or unsupported files with Arabic guidance, and never expose storage paths.

### FR-02 Extraction and OCR

The system shall extract page-level text and metadata. It shall detect low-quality or absent text and apply Arabic/English OCR only where needed. It shall preserve canonical page numbering and source evidence.

### FR-03 Visual academic content

The system shall identify pages containing useful images, tables, diagrams, or equations. It may use selective vision analysis to create descriptions grounded in those page images. The UI shall indicate when visual interpretation may be approximate.

### FR-04 Document structure

The system shall infer units, lessons, headings, and key concepts and generate a navigable learning path. All generated structure must reference source pages.

### FR-05 Explanation level

The user shall select beginner, intermediate, or advanced. Explanations shall vary in terminology, depth, assumptions, examples, and abstraction without changing source facts.

### FR-06 Grounded chat

The student shall ask questions about the active document. The system shall retrieve only document evidence, classify answerability, answer in Arabic, and explicitly refuse unsupported content.

### FR-07 Citations

Each substantive explanation or answer shall include one or more server-validated citations containing page number, exact or safely normalized quotation, and a viewer navigation anchor. Citations must not be invented by the model.

### FR-08 Summaries

The user shall generate whole-document, unit, lesson, concept, short, and detailed summaries. Summaries must remain grounded and carry source-page ranges or citations.

### FR-09 Quizzes

The user shall generate multiple-choice quizzes for a unit or page range. The system shall score immediately, explain the correct answer, and cite the supporting source page.

### FR-10 Flashcards

The user shall generate and review question/answer, term/definition, and concept/example cards. Each card shall retain source references.

### FR-11 PDF viewer

The application shall display the uploaded PDF and navigate to cited pages. Highlighting source regions is preferred when reliable bounding boxes exist.

### FR-12 Session deletion

The user shall be able to delete the session immediately. The system shall also expire idle and absolute-lifetime sessions and remove all associated artifacts through idempotent cleanup.

### FR-13 Processing status

The user shall see meaningful processing stages and recoverable error states. The UI must not show fabricated percentage progress.

### FR-14 AI configuration

Administrators shall configure task-specific primary/fallback models, input/output token caps, request cost cap, retries, timeouts, and privacy routing through environment variables without redeployment where the platform permits.

## 8. Non-functional requirements

- **Security:** OWASP-aligned controls, malicious upload handling, isolation, ownership checks, and least privilege.
- **Privacy:** data minimization, no content logs, server-only secrets, ZDR/privacy routing, TTL deletion.
- **Accessibility:** WCAG 2.2 AA target.
- **Performance:** upload acknowledgement under 2 seconds under normal local network conditions; asynchronous processing; chat P95 target under 12 seconds excluding provider outages.
- **Reliability:** idempotent jobs, retry boundaries, recoverable state, and provider fallback without privacy downgrade.
- **Scalability:** stateless web/API instances; queue-based workers; external storage/database.
- **Maintainability:** typed contracts, tests, ADRs, and modular provider adapters.
- **Localization:** Arabic RTL with correct mixed-direction handling.

## 9. Success metrics for pilot

Metrics must not capture content:

- Upload validation success/failure rate by reason.
- Processing success rate and duration by stage.
- OCR page ratio.
- Grounded answer rate, partial-answer rate, and not-found rate.
- Citation verification failure rate.
- Quiz/flashcard generation success rate.
- Manual deletion success rate and cleanup lag.
- Provider latency, token use, and cost by task/model.
- Client error rate and accessibility defects.

## 10. Release blockers

- Any cross-session access.
- Any exposed secret.
- Any unverified citation shown as valid.
- Any answer using outside knowledge without returning `not_found` or partial status.
- Any data entity without a tested deletion path.
- Privacy configuration silently routing to providers that violate required policy.
- Inability to run the documented local environment from a clean clone.
