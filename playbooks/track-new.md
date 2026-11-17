# /track-new

Argument: `$ARGUMENTS`. The first token is the track slug (lowercase, hyphens, e.g. `rust-basics` or `vendor-exam-code`). The rest, if any, is the source to anchor on: a URL, a file path, or a description (an exam guide, a course outline, a book, a spec, documentation).

A **track** is one learning goal. This playbook sets up its files and its syllabus, and nothing else. It never writes study content or questions.

## Steps

1. **Refuse to overwrite.** If `data/<slug>/` exists, stop and say so. Offer `/status` instead.
2. **Copy the template.** Create `data/` if it doesn't exist. Run `cp -R templates/track data/<slug>`. If `data/shared/` doesn't exist, run `cp -R templates/shared data/shared`. Replace the `{{...}}` placeholders as you fill them in.
3. **Settle the goal (one message, at most 4 questions).** Skip any question the arguments already answer.
   - What do you want to be able to do or understand when this is done?
   - How will you know you are done: an external test with a pass mark, a thing you can build or explain, or just a feeling of fluency? ("none" is a valid answer.)
   - What is your starting level and background?
   - Is there an authoritative source to anchor on (an exam guide, a course outline, a book, a spec, official docs)?
4. **Build the syllabus from the best available source.** Never reconstruct it from memory.
   - **A source exists:** read it (the supplied URL or PDF, or search for the provider's official one) and build the syllabus **only** from it. Record its name, version and retrieved date. Use only official or primary sources.
   - **No source exists:** derive the syllabus from the goal, with the learner. Cross-check it against at least one authoritative reference (documentation, standards, a recognised textbook, or the working system itself) and list what you used. Mark the file `Source: self-derived (unverified)`. Show the learner the draft and let them cut, add or reorder. This is the only approval gate in the playbook.
   - **Shape:** areas, each with objectives that can be tested ("can do X", "can explain why Y"). Stable IDs `<area>.<n>`. Weights: use the source's weights, or equal weights unless the learner says otherwise. Keep it as small as it can be while covering the goal. Add one line of key concepts per objective.
5. **Fill `guidelines.md`.**
   - **Target:** what done means (a pass mark, a demonstration criterion, or none), and whether it has an external date or fee.
   - **Full assessment length:** the real test's length if there is one. Otherwise choose 20 to 60 questions that cover every area in proportion to its weight.
   - **How it is assessed:** question types, style, qualifiers and distractor patterns of the real test, if there is one. Otherwise say "scenario and application questions".
   - **Pacing, known traps and study resources.** Mark anything not stated by a source as `(unverified)`.
6. **Seed `ledger.md`.** One row per syllabus ID with status `unseen`, layers `-`, cal `?`, and the concept copied from the syllabus.
7. **Seed `state.md`.** Next action: `/probe <slug>`. Target date `ASAP (default)`. Never ask for a date. Change it only if the learner volunteers one.
8. **Report** the areas with weights, the number of ledger rows, the source (or "self-derived"), and anything unverified.

## Rules
- Keep every file as small as it can be while staying useful. These files are re-read every session.
- Do not write questions or study content here. This playbook sets up state only.
- Facts must come from an authoritative source. If none exists for a fact, mark it unverified.
