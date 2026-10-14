---
description: Execute the current Codex task, validate scoped work, and report for review.
---

# Execute Current Task

Read AGENTS.md, PROJECT.md, and coordination/CURRENT_TASK.md. Shared files are the source of truth; do not assume access to Codex chat history.

Start only when task status is READY and there is no completed report for that same task awaiting review. Otherwise report the state and stop.

Capture the starting working-tree status. Execute all scoped items and preserve unrelated work. Batch independent operations where practical. If an independent item fails, record the action, error, attempts, impact, and next step, then continue safe independent work.

Run all scoped acceptance checks. Replace coordination/IMPLEMENTATION_REPORT.md using coordination/REPORT_TEMPLATE.md. Record the task ID and status COMPLETE, PARTIAL, or BLOCKED, with reproducible evidence and explicit skipped checks.

Do not change task definitions/history, modify unrelated files, or start another milestone. Stop for Codex review.
