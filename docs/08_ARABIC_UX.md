# Arabic UX, RTL, and Accessibility

## Information architecture

1. Landing/upload.
2. Privacy and limits.
3. Level selection.
4. Processing status.
5. Learning workspace:
   - document map;
   - PDF viewer;
   - explanation;
   - chat;
   - summaries;
   - quizzes;
   - flashcards.
6. End session and delete.

## Desktop layout

Use a resizable or switchable workspace with document navigation, PDF viewer, and learning panel. Avoid presenting three dense columns on medium screens.

## Mobile layout

Use clear tabs or bottom navigation for document, learning path, chat, and tools. Preserve the student's position when switching views. Citations open the PDF view at the correct page.

## Arabic copy principles

- Use clear Modern Standard Arabic.
- Avoid unnecessary technical anglicisms; show the English term in parentheses when educationally useful.
- Distinguish “لم أجد الإجابة في هذا الملف” from system errors.
- Explain degraded OCR or visual interpretation without blaming the user.
- Keep destructive deletion action explicit and confirm consequences.

## Directionality

- Root UI uses RTL.
- Use `dir="ltr"` or Unicode isolation for formulas, code, URLs, English filenames, and English quotations.
- Use logical spacing/border properties.
- Ensure icons that imply direction are mirrored only when semantically appropriate.

## Accessibility

- WCAG 2.2 AA target.
- Keyboard support for upload, navigation, citations, quiz choices, and flashcards.
- Visible focus and skip links.
- Screen-reader status announcements for processing changes.
- Do not rely on color alone.
- Respect reduced motion.
- Minimum practical touch target of 44×44 CSS pixels.
- PDF viewer controls require accessible labels.

## Required UI states

- Empty/no file.
- Drag active.
- Client validation failure.
- Uploading.
- Server validation failure.
- Processing by real stage.
- Ready.
- Degraded/partial pages.
- Failed with retry guidance.
- Session nearing expiry.
- Expired.
- Deleting.
- Deleted.
- Provider temporarily unavailable.
- Answer not found in file.
