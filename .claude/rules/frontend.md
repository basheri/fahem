---
paths:
  - "apps/web/**/*.{ts,tsx,css}"
  - "packages/ui/**/*.{ts,tsx,css}"
---

# Frontend Rules

- Arabic is the default interface language and the root document direction is RTL.
- Use logical CSS properties. Do not hard-code left/right where start/end is correct.
- Render English text, code, formulas, page numbers, and file names with appropriate LTR isolation.
- Build mobile-first and test common mobile and desktop widths.
- Use semantic HTML, keyboard-accessible controls, visible focus, accessible names, status announcements, and reduced-motion support.
- Never expose secrets or raw internal error details.
- Never display a citation unless the API returned a validated citation object.
- Provide real processing stages and polling/SSE state, not fake progress.
- Handle upload, validation, processing, ready, partial failure, failed, expired, and deleted states.
- All API responses must be runtime-validated at the client boundary.
