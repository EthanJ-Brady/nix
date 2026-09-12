---
name: wait-what
description: Re-pitch the complete previous response when the user says "wait what" as a clarification request; when attached to a numbered, quoted, or named target, re-pitch that complete target instead.
---

# Wait What

The explanation did not land. Replace it with a simpler explanation rather than extending or defending it.

1. Select the scope:
   - A standalone `wait what` targets the complete preceding assistant response.
   - In a numbered reply, `2. wait what` targets the complete question 2, including context and examples that belong to it. A quotation or named reference similarly targets that complete item.
   - Ask one concise targeting question only when an explicit reference is genuinely ambiguous or no preceding response exists.
2. Preserve the target's core meaning. Retain the conversational state of every unaffected answer and decision without repeating them. Keep the target unresolved and do not advance dependent work.
3. Re-pitch the target from the beginning:
   - Give enough context to orient the user.
   - Present the ideas again in a simpler conceptual order.
   - Cover every core idea, relationship, decision, and question needed to retain the target's meaning.
   - Use ASD-STE100 Simplified Technical English and the ubiquitous language from the applicable `CONTEXT.md`; follow `CONTEXT-MAP.md` when the repository has more than one context.
   - Use concrete examples when they make the idea easier to understand.
4. Stop after the replacement explanation so the user can respond.

A re-pitch is not a summary of one selected point, an explanation of why the prior answer said something, or extra detail appended to the prior answer. Omit incidental wording, not substantive parts of the selected scope.
