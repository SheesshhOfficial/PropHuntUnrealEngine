param([int]$Cycles=2,[switch]$CheckOnly,[string]$InitialReadyTask,[int]$CompletedCycles=0)
$ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$ag='C:\Users\ashis\AppData\Local\Programs\Antigravity IDE\bin\antigravity-ide.cmd'
$codex=(Get-Command codex -ErrorAction Stop).Source
if($Cycles -lt 1 -or $Cycles -gt 20){throw 'Cycles must be between 1 and 20.'}
if(-not(Test-Path -LiteralPath $ag)){throw 'Antigravity launcher missing.'}
$mutex=[Threading.Mutex]::new($false,'Local\SheeshhPropHuntAgentLoop')
if(-not $mutex.WaitOne(0)){throw 'Another controller is already running.'}
$runId=Get-Date -Format 'yyyyMMdd-HHmmss'
$runDir=Join-Path $PSScriptRoot "runs/$runId"
function Save-State($phase,$count,$detail){
 $state=@{run_id=$runId;phase=$phase;completed_cycles=$count;max_cycles=$Cycles;detail=$detail;updated_at=[DateTimeOffset]::Now.ToString('o');pid=$PID}
 $state|ConvertTo-Json|Set-Content -LiteralPath (Join-Path $PSScriptRoot 'state.tmp') -Encoding utf8
 Move-Item -LiteralPath (Join-Path $PSScriptRoot 'state.tmp') -Destination (Join-Path $PSScriptRoot 'state.json') -Force
}
function Review($index,$final){
 $out=Join-Path $runDir "review-$index.json"
 $log=Join-Path $runDir "review-$index.log"
 $instruction=@"
You are Codex planner/reviewer in the existing Codex-Antigravity workflow. Read AGENTS.md, PROJECT.md, coordination/CURRENT_TASK.md, coordination/IMPLEMENTATION_REPORT.md, coordination/TASK_HISTORY.md, coordination/ROADMAP.md and coordination/UI_DESIGN_BRIEF.md targeted as needed. Do not implement the main task. Independently inspect actual evidence/diffs, screenshots when relevant, and necessary checks. Do not claim unverified results. Preserve ignored assets/backups and unrelated work. No commits, installs, destructive cleanup, public messaging or permission bypass. This loop is authorized for $Cycles implementations within the existing UI roadmap only. Correction tasks count toward this limit. Do not broaden to maps/music/online/performance work. Keep review/report concise, read targeted evidence, avoid repeated passed checks.
If the current READY task has no matching completed report, assess readiness and leave it unchanged if valid; do not review an older report as this task's result. If a matching completed report exists, review and archive it and update history. When corrections are needed, author a narrow READY correction task; otherwise author the next reviewable UI milestone within the agreed roadmap. If a required user decision or unsafe/blocking condition occurs, output decision stop and explain; do not invent authorization.
Final review only: $final. If True, review the last implementation, record outcome/corrections in history and a DRAFT task if needed, but do not dispatch/create another READY implementation for this run. Output decision stop. Otherwise output ready only when CURRENT_TASK contains the reported task_id and Status READY. Output JSON according to schema. Do not edit coordination/controller state/scripts or stop flag. If exec filesystem tools fail with helper_unknown_error setup refresh, do not retry identical calls repeatedly. Use available supported Monolith source read_file and editor run_python for project-local reads/hash verification and Monolith graph/UI inspection. Do not bypass permissions. If no supported access works, stop honestly. Return promptly once the actual review is done.
"@
 $ErrorActionPreference='Continue'
 $instruction | & $codex exec -C $root --sandbox workspace-write --json --output-schema (Join-Path $PSScriptRoot 'review-schema.json') -o $out - 2>&1 | Out-File -LiteralPath $log -Encoding utf8
 $reviewExit=$LASTEXITCODE
 $ErrorActionPreference='Stop'
 if($reviewExit -ne 0){throw "Codex review failed; see $log"}
 if(-not(Test-Path -LiteralPath $out)){throw 'Codex did not return structured review output.'}
 Get-Content -LiteralPath $out -Raw | ConvertFrom-Json
}
try{
 if($CheckOnly){Write-Output "Preflight OK. Codex: $codex; Antigravity: $ag; cycles: $Cycles";return}
 New-Item -ItemType Directory -Path $runDir -Force|Out-Null
 if(Test-Path (Join-Path $PSScriptRoot 'STOP')){throw 'STOP flag exists; remove only when intentionally restarting.'}
 $completed=$CompletedCycles
 Save-State 'reviewing' $completed 'Initial Codex readiness/review'
 for($i=($CompletedCycles+1);$i -le $Cycles;$i++){
  if(Test-Path (Join-Path $PSScriptRoot 'STOP')){throw 'User requested controller stop.'}
  if($i -eq ($CompletedCycles+1) -and $InitialReadyTask){$review=[pscustomobject]@{decision='ready';task_id=$InitialReadyTask;reason='Readiness reviewed in desktop Codex; see task history'}}else{$review=Review $i $false}
  if($review.decision -ne 'ready'){Save-State 'needs_attention' $completed $review.reason;return}
  $task=Get-Content (Join-Path $root 'coordination/CURRENT_TASK.md') -Raw
  if($task -notmatch '(?m)^Status: READY\s*$' -or -not $task.Contains($review.task_id)){throw 'Review output does not match a READY task.'}
  $nonce=[Guid]::NewGuid().ToString()
  $done=Join-Path $runDir "done-$i.json"
  $prompt="Use the codex-antigravity-workflow skill as Antigravity implementer. Read AGENTS.md, PROJECT.md and coordination/CURRENT_TASK.md in $root. Execute only READY task $($review.task_id), preserve scope and evidence, validate and write IMPLEMENTATION_REPORT.md using REPORT_TEMPLATE.md. Do not change task/history/controller or start another task. Continue independent safe checks after failures; no fabricated evidence. After ALL tool calls, asset saves, test cleanup and report writing are finished, your final filesystem action must write this completion marker to $done as UTF-8 JSON: {`"task_id`":`"$($review.task_id)`",`"nonce`":`"$nonce`"}. Marker is completion, not approval. Then stop. If user approval/input is required, report BLOCKED/PARTIAL and write marker only after safely stopping. Do not keep running after marker."
  Set-Content (Join-Path $runDir "dispatch-$i.txt") $prompt -Encoding utf8
  Save-State 'dispatching' $completed $review.task_id
  Push-Location $root
  $ErrorActionPreference='Continue'
  try{& $ag chat --mode agent --reuse-window --add-file (Join-Path $root 'coordination/CURRENT_TASK.md') $prompt 2>&1 | Out-File (Join-Path $runDir "dispatch-$i.log") -Encoding utf8; $dispatchExit=$LASTEXITCODE}finally{Pop-Location; $ErrorActionPreference='Stop'}
  if($dispatchExit -ne 0){throw "Antigravity chat dispatch failed ($dispatchExit)."}
  Save-State 'waiting_for_antigravity' $completed $review.task_id
  $deadline=[DateTime]::UtcNow.AddHours(2)
  while(-not(Test-Path -LiteralPath $done)){
   if(Test-Path (Join-Path $PSScriptRoot 'STOP')){throw 'Stop requested; no new turns will be dispatched. Active agent may still need user interruption.'}
   if([DateTime]::UtcNow -gt $deadline){throw 'Antigravity completion timed out; no duplicate dispatch attempted.'}
   Start-Sleep -Seconds 5
  }
  $marker=Get-Content $done -Raw|ConvertFrom-Json
  if($marker.nonce -ne $nonce -or $marker.task_id -ne $review.task_id){throw 'Invalid completion marker.'}
  $report=Get-Content (Join-Path $root 'coordination/IMPLEMENTATION_REPORT.md') -Raw
  if(-not $report.Contains("Task ID: $($review.task_id)") -or $report -notmatch '(?m)^Status: (COMPLETE|PARTIAL|BLOCKED)\s*$'){throw 'Completion marker has no matching final report.'}
  $completed++
  Save-State 'reviewing' $completed 'Implementation finished; next review'
 }
 $result=Review ($Cycles+1) $true
 Save-State 'finished' $completed $result.reason
}catch{
 if(-not $CheckOnly){Save-State 'needs_attention' $completed $_.Exception.Message}
 Write-Error $_
}finally{$mutex.ReleaseMutex();$mutex.Dispose()}



