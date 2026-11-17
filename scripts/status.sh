#!/bin/sh
# Prints each track's readiness verdict and next action. Read-only. Works with any agent.
# Claude Code runs it from a SessionStart hook; other agents are told to run it in AGENTS.md.
# It reads the line below "## Readiness verdict" and "## Next action" in each state.md, so those headings must stay.
cd "$(dirname "$0")/.." || exit 0
echo "Study harness: where you left off (from data/*/state.md)"
found=0
for d in data/*/; do
  [ -d "$d" ] || continue
  c=$(basename "$d")
  [ "$c" = "shared" ] && continue
  f="${d}state.md"
  [ -f "$f" ] || continue
  v=$(awk '/^## Readiness verdict/{getline; print; exit}' "$f")
  n=$(awk '/^## Next action/{getline; print; exit}' "$f")
  echo "- $c | $v | next: $n"
  found=1
done
[ "$found" = 1 ] || echo "(no tracks yet: run /track-new <slug> [source])"
echo "Reminder for the agent: if the learner's first message is not a command, show this list, recommend the single best next command (prefer the track most recently worked on; any order is fine and the learner can switch freely), and ask whether to start it. If there are no tracks, offer /track-new. Never ask for a target date."
