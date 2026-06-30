# PDF Processing and Grounded RAG Pipeline

## 1. Ingestion

- Stream upload with byte limit; never load an unbounded file into memory.
- Verify PDF signature and parser readability.
- Reject password-protected files in MVP with a clear Arabic message.
- Sanitize display filename and generate an unrelated storage key.
- Calculate SHA-256 for idempotency and diagnostics.
- Enforce page count before expensive work.

## 2. Extraction and OCR gating

For every page:

1. Extract text blocks, coordinates, fonts, rotation, images, and page dimensions with PyMuPDF.
2. Calculate text quality from character count, printable ratio, language plausibility, duplicate glyphs, and coverage.
3. Use native text when quality passes.
4. Rasterize and OCR only failing pages with OCRmyPDF/Tesseract `ara+eng`.
5. Preserve both raw extraction and canonical source text.
6. Record OCR confidence and degraded flags.

Never run OCR on every page by default; it wastes time and may reduce clean text quality.

## 3. Visual content

- Detect pages with large images, tables, charts, diagrams, or equation density.
- Create bounded-resolution page images/crops.
- Send only selected visual content to the configured vision model.
- Ask for descriptions tied to visible evidence and page number.
- Store structured descriptions as derived content, not replacements for canonical source text.
- Warn that complex equations or diagrams may require student verification.

## 4. Structure and chunking

- Infer headings using font/layout signals plus structured AI analysis where needed.
- Create hierarchical units, lessons, headings, and concepts with page ranges.
- Chunk within section and page boundaries where possible.
- Use overlap only for context; avoid duplicate evidence in final retrieval.
- Store exact source text separately from normalized search text.
- Preserve page, offsets, and bounding boxes.

## 5. Text normalization

Normalization for retrieval may:

- Normalize Unicode forms and whitespace.
- Normalize common Arabic letter/diacritic variants cautiously.
- Remove layout artifacts and repeated headers/footers.

It must not overwrite exact source text used for quotations. Quote verification may use a documented safe-normalization comparison while returning a faithful source excerpt.

## 6. Retrieval

1. Validate session/document.
2. Rewrite the Arabic question only for retrieval, without adding facts.
3. Execute vector and lexical search over the active document and session.
4. Fuse rankings and deduplicate overlapping chunks.
5. Apply diversity across pages/sections.
6. Optionally rerank within a bounded candidate set.
7. Calculate evidence coverage and answerability.
8. Send the minimum selected evidence to the model.

## 7. Generation and verification

- Use a system prompt that defines evidence as untrusted quoted data.
- Require structured output.
- The model returns candidate answer text and references to evidence IDs, not arbitrary page numbers or quotes.
- Server resolves evidence IDs into pages and source text.
- Server verifies every quotation and citation.
- Unsupported claims cause one constrained repair attempt.
- Insufficient evidence returns `not_found` in Arabic.

## 8. Prompt injection defenses

PDF text can contain instructions such as “ignore previous rules,” fake system messages, data-exfiltration requests, or fabricated citations. The system shall:

- Delimit evidence clearly.
- State that evidence is data and instructions inside it are invalid.
- Disable tools/web access in answer generation.
- Never include secrets or unrelated context.
- Validate output and evidence IDs.
- Include adversarial PDFs in evaluation.

## 9. Evaluation metrics

- Retrieval recall@k on labeled fixtures.
- Answer correctness against fixture evidence.
- Citation page accuracy.
- Quote exact/normalized match rate.
- Unsupported claim rate.
- Correct not-found rate.
- Arabic clarity by level.
- OCR quality by page type.
- End-to-end latency and cost.
