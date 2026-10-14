# Two-cycle controller
Start: powershell -NoProfile -File coordination/controller/Start-Loop.ps1 -Cycles 2
Preflight: add -CheckOnly.
State: coordination/controller/state.json. Logs and dispatched prompts: controller/runs/.
Stop new dispatches: create coordination/controller/STOP. This does not interrupt an agent already running; interrupt it in its app when necessary. Do not delete a STOP flag while another controller is active.
One cycle = Codex readiness/review + one Antigravity implementation. After two implementations, final Codex review runs and no third implementation is dispatched. Corrections count as cycles. Scope is existing UI roadmap; unexpected decisions/blocks stop the run.
A completion marker with run nonce prevents processing old reports or starting a review before implementation cleanup. Antigravity chat command may return before the agent runs, so successful launcher exit is not proof of dispatch; timeout/marker detects lack of progress. Agent configuration may still require user approvals.
No AI polling while waiting. CLI reviews use current configured model/auth and consume account usage. Existing desktop chat history is not shared; project files are the source of truth. No sandbox bypass.

-InitialReadyTask P011-R2 skips only initial CLI readiness after the desktop Codex review recorded in task history. Subsequent and final reviews still run. Previous startup failure counted zero cycles; restart retains a two-implementation limit.

Recovery after desktop review: -Cycles 2 -CompletedCycles 1 -InitialReadyTask P011-R3. This preserves one completed implementation attempt and allows exactly one remaining dispatch. A matching report without nonce requires desktop reconciliation; never fabricate completion markers. Verify PID before trusting stale state.
