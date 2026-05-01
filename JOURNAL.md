# Project Journal — v2ig

This file is the **session-bridge**: the very top says *where the project is now*; the rest is an append-only log of recent sessions (what was done and why). Entries older than the most-recent few are moved to `JOURNAL-archive.md`.

**How to read this file at session start:**

1. Read the **ACTIVE** section below — that is the next-session bootstrap (current state, pending user actions, the first move, blockers).
2. Skim the most recent session entry under **Session History** for the *why* behind whatever the ACTIVE section refers to.
3. Older entries are useful only when investigating the history of a specific decision; otherwise skip them.

**How to update this file at session end (`/uadf-handoff`):**

1. Append a new entry at the **top** of *Session History* describing what was done, why, and any non-obvious context.
2. Rewrite the **ACTIVE** section so it reflects the new state (overwrite, don't append).
3. If the file is getting long, move the oldest entries to `JOURNAL-archive.md` (target: keep `JOURNAL.md` under ~600 lines so it loads cheaply at session start).

Everything else relevant to picking up work — paths, build commands, architectural rules, environment quirks — lives in `MEMORY.md` (auto-loaded) and `CLAUDE.md` (project conventions). Do not duplicate that content here.

---

## ACTIVE — 2026-05-01 (two parallel blockers: HL7 template-trust whitelist + GCP org policy on structured_outputs)

**Phase:** Two independent things blocked on user/admin action; both have been narrowed to a single specific request each.

1. **Auto-IG publication** — still blocked on the JS-trust catch-22 from 2026-04-29 (`local-template/content/assets/js/{v2-table-filter,v2-classic-tabs}.js` reject by template-trust, inline `<script>` rejects by HTML scanner). Whitelist request to HL7 is the gating action. No change since prior handoff.
2. **LLM extraction (ADR-0006 Phase 1)** — script switched to Vertex AI this session, connectivity works, but the SDK's `messages.parse()` helper requires the Vertex `structured_outputs` feature, which is **blocked by GCP org policy** on the NIST project for `claude-sonnet-4-6`. Either get the policy expanded OR refactor the script to use plain `messages.create()` + client-side Pydantic validation.

**Branches:**
- `dev/framework` at `a0b4b04b` (1 ahead of origin) — Vertex switch + provision.sh update committed but not pushed; script doesn't run end-to-end yet
- `origin/main` at `1f8bf2d5` (unchanged)
- `origin/build` at `865ecd74` (unchanged) — still rejected by template-trust

### Next session's first move

**Resolve which LLM-extraction path to take, then act.** Two options:
- **(a) Pursue the GCP org policy expansion** — user/NIST admin adds `publishers/anthropic/models/claude-sonnet-4-6:structured_outputs` to the allowed-feature list at `https://docs.cloud.google.com/vertex-ai/generative-ai/docs/control-model-access`. Then re-run the limit-3 sanity check; should just work.
- **(b) Refactor the script to use `messages.create()` instead of `messages.parse()`** — embed the JSON schema as text in the system prompt, parse the response with `json.loads()`, validate with `ExtractionResult.model_validate()`. Keeps prompt caching intact. Estimated 30 min of work + a second sanity check.

If the whitelist also landed for HL7, push an empty commit to `build` and let auto-IG run in parallel (~70 min). The two paths don't conflict.

### Pending user actions before next Claude session

1. **(unchanged) File the HL7 template-whitelist request** for `local-template/content/assets/js/{v2-table-filter,v2-classic-tabs}.js`.
2. **(NEW) Decide on LLM-extraction path**: chase the GCP org policy expansion, or authorize the manual-JSON refactor (option b above), or both in parallel.

### Build verification status

- ✅ **Hxx recursive BackboneElement works.** Auto-IG built past validation on the 2026-04-29 19:56 UTC run (commit `e175d9eb`). No FHIRPath errors, no snapshot errors, no `Unable to find ...` errors. The pattern in 15 message structures + standalone `Hxx.json` is valid FHIR R5.
- ✅ **postproc-g full build passes** end-to-end (with `-tx n/a`). That's the structural verification when auto-IG is unavailable.
- ❌ **Auto-IG output check rejects** the inline `<script>` tags AND the `.js` files (whichever form we use). See ADR-0004 (reversed 2026-04-29) for the catch-22 specifics.

### What's true now (confirmed this session)

- **tx.fhir.org is healthy.** Yesterday's outage caused two false-positive failures (28 Apr 17:19 UTC, 19:31 UTC); recovered by 29 Apr morning.
- **Auto-IG processes new branches fast** (~2 min from push) but **backs off failing branches** (the `build` branch took ~70 min to retrigger after consecutive failures). Empty commits don't seem to break the dedupe — needed a real (non-empty) commit to be sure.
- **Auto-IG hardcodes `-tx http://tx.fhir.org`** on the CLI; no IG-side parameter overrides this. Confirmed via web research against `Publisher.java#setTxServerValue`.
- **mfaughn has `write` not `admin`** on `HL7/v2ig` — webhook listing endpoint returns 404. Cannot diagnose webhook-delivery issues from this side; need someone with admin access (or an HL7 ops person) to check.
- **The MVP `mvp-test` branch is a working test article** for proving auto-IG infrastructure is alive even when our main IG is failing. It currently has two unrelated issues (Jekyll missing `menu.xml`, R5 parameter format wants `code` as Coding not string) — fix these next time we want to use it as a probe.

### LLM extraction sanity (NEW state — 2026-05-01)

- Script now uses `AnthropicVertex()` (commit `a0b4b04b`). Auth via Application Default Credentials (already present at `~/.config/gcloud/application_default_credentials.json`); project + region from `ANTHROPIC_VERTEX_PROJECT_ID=nist-gcp-itl-hit` + `CLOUD_ML_REGION=global` (already in env).
- Model ID: `claude-sonnet-4-6@default` (matches user's convention; bare `claude-sonnet-4-6` would also work per Anthropic Vertex docs).
- 3-table sanity check fails at the first call with: `Organization Policy constraint constraints/vertexai.allowedPartnerModelFeatures violated for projects/370789798156 attempting to use a disallowed feature structured_outputs for Partner model claude-sonnet-4-6`. Subsequent calls fail differently — `output_config.format: Extra inputs are not permitted` — same root cause manifesting at the schema level.
- The SDK's `messages.parse()` helper sends `output_config.format` to enforce structured output, which is exactly what's gated. Three workaround options ranked by effort:
  1. Get GCP admin to add `publishers/anthropic/models/claude-sonnet-4-6:structured_outputs` to allowed features (zero code change; admin turnaround unknown).
  2. Refactor to `messages.create()` + manual JSON parsing — embed `ExtractionResult` schema as text in the system prompt with explicit "respond with JSON only, no preamble" instruction; parse response with `json.loads()` and validate with `ExtractionResult.model_validate()`. ~30 min of work; preserves prompt caching; modest risk of malformed-JSON responses (mitigation: retry once, then mark as error).
  3. Try a different model where structured_outputs may not be blocked — but the org policy likely covers all partner models, not just Sonnet 4.6, so this probably doesn't help.
- Test command after either resolution: `python3 tooling/scripts/extract_v291_llm.py CH03_PatientAdmin.docx --limit 3` (~$0.01, ~30 sec).

### Hot spots if the next auto-IG attempt fails after HL7 whitelist

1. **R5 IG parameter format.** Our `v2plus.xml` may still use R4-style `code: "string"` parameters. R5 expects Coding `{system, code}`. Auto-IG warning seen on MVP: "property code is a class JsonPrimitive looking for an object". Not yet investigated for `v2plus.xml`.
2. **Jekyll `menu.xml`.** Templates expect `input/includes/menu.xml`. v2plus.xml-based build is presumably fine here (existed before), but verify if the build chokes on missing includes.
3. **Per-branch backoff.** Even after a successful build, if a subsequent push fails immediately the backoff window may re-engage. Build cycle planning should assume one shot per ~70 min on retries.

### Open blockers (V2 Management decisions, not Claude work)

Unchanged from prior handoff. Documented in `v291-extracted/v2mgmt-review-report.md` Sections 1–16. The Section 9 + 16 Hxx-equivalence question was answered last session by §1.12 errata; the rest stands:

- **REVIEW-0001** — ACK clause 10.4 UAC repeating intentional or typo?
- ACK caption description variants (7 non-standard occurrences)
- NTE description form in MDM_T01/T02 — long vs short form
- `GUARANTOR_INSURANCE` group name in RQI_I01 (typo `+` in clause 11.3.3?)
- "for Additional Demographics" in PATIENT group (5 instances)
- 358 bare "Participation" + 165 OBX mismatches — large-scale standardization
- RDE_O11 RXO "Prescription Order" variant
- 197 FHIR↔raw V291 diffs where FHIR has the better description
- **Section 9 + 16 (refined)**: confirm `Hxx` ≡ `...` ≡ `etc.` per §1.12; confirm MSH/transmission-control exclusion as enforceable invariant; resolve cardinality on the 10 non-MFN placeholder slots; fill `RSP_K11.8-SEGMENT_PATTERN.1` null short/definition; recover `RTB_Knn.8` description; decide whether the §12.3 CH12 order-detail-family narrowing should be encoded as an additional invariant.

---

## Session History

## 2026-05-01 — LLM extraction switched to Vertex AI, blocked on GCP org policy

### Completed

**Switched `tooling/scripts/extract_v291_llm.py` from direct Anthropic API to Vertex AI** (commit `a0b4b04b`). Replaced `anthropic.Anthropic()` with `AnthropicVertex()` (constructor reads `ANTHROPIC_VERTEX_PROJECT_ID` + `CLOUD_ML_REGION` from env automatically). Removed the `ANTHROPIC_API_KEY` check. Updated model ID to `claude-sonnet-4-6@default` to match the user's convention from `ANTHROPIC_DEFAULT_SONNET_MODEL`. Updated `.claude-dev/provision.sh` to install `anthropic[vertex]` (which pulls `google-auth`) instead of bare `anthropic`. Verified `~/.config/gcloud/application_default_credentials.json` is in place from the user's Claude Code Vertex auth.

**Discovered GCP org policy gate on `structured_outputs` feature.** The 3-table sanity check (`--limit 3` on CH03_PatientAdmin.docx) fails at the first call with `Organization Policy constraint constraints/vertexai.allowedPartnerModelFeatures violated for projects/370789798156 attempting to use a disallowed feature structured_outputs for Partner model claude-sonnet-4-6`. The remaining two calls fail at the schema layer with `output_config.format: Extra inputs are not permitted` — same root cause: the SDK's `messages.parse()` helper sends `output_config.format` to enforce structured output, which is exactly what the org policy gates. Three workarounds documented in JOURNAL ACTIVE; user to choose between requesting org policy expansion (zero code change) and refactoring to manual JSON parsing with client-side Pydantic validation (~30 min).

### Why

- **Vertex over direct API**: user has no Anthropic API key but already authenticates to Anthropic via Vertex (it's how Claude Code itself reaches the model). All the env vars (`ANTHROPIC_VERTEX_PROJECT_ID=nist-gcp-itl-hit`, `CLOUD_ML_REGION=global`) and ADC were already in place — switching the SDK class was the only real change. Pricing on global endpoints matches direct API rates ($3/$15 per M tokens for Sonnet 4.6, no Vertex premium), so the cost-estimate math in the script stays correct.
- **`@default` suffix on model ID**: matches the user's existing convention (`ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6@default`); Anthropic Vertex docs confirm bare `claude-sonnet-4-6` would also work but `@default` is more explicit about routing intent.
- **Stop and hand off rather than refactor**: the manual-JSON-parsing refactor is ~30 min of work plus a second sanity check, and the user signaled an imminent context clear. Better to commit the partial progress (Vertex switch is genuinely useful regardless of which workaround we pick) and let the next session decide between the two paths fresh.

### Commits this session

On `dev/framework`:
- `a0b4b04b` — Switch LLM extraction to Vertex AI client (1 ahead of origin; not pushed)

### Relevant context for next session

- **`messages.parse()` is the gated call**, not `messages.create()`. If we go the manual-JSON-parsing route, the script structure stays the same except the LLM call wraps `client.messages.create()` and we parse `response.content[0].text` ourselves. The `SYSTEM_PROMPT` constant already contains the JSON shape examples — would need to add a "respond with JSON only, no preamble" instruction at the end and swap the Pydantic schema-injection for a textual schema description.
- **Prompt caching still works on Vertex** for plain `messages.create()` — `cache_control: {"type": "ephemeral"}` is wire-compatible. The system-prompt cache savings the script was designed around survive the refactor.
- **Org policy URL**: `https://docs.cloud.google.com/vertex-ai/generative-ai/docs/control-model-access` (from the error message). The specific allowlist entry to request: `publishers/anthropic/models/claude-sonnet-4-6:structured_outputs`. If pursued, may also need entries for other models we plan to use later (Opus 4.7, Haiku 4.5).
- **GCP project number** in the error message is `370789798156`, which corresponds to `ANTHROPIC_VERTEX_PROJECT_ID=nist-gcp-itl-hit`. Useful for the org policy ask if the admin needs the numeric project ID.
- **Both blockers are independent.** The HL7 template-trust whitelist (auto-IG publication) and the GCP `structured_outputs` policy (LLM extraction) can be pursued in parallel — they touch different systems and different stakeholders.

---

## 2026-04-27 → 2026-04-30 — Hxx invariants dropped, tx.fhir.org chase, ADR-0004 reversal blocked on template trust

### Completed

**Dropped both Hxx FHIRPath invariants.** postproc-g full build (kicked off after the previous session) failed at
`StructureDefinitionValidator.validateElementDefinitionInvariant` →
`Unable to find http://hl7.org/v2/StructureDefinition/MFN_Znn#MFN_Znn.5-MF_SITE_DEFINED.2-Hxx`. Two compounding root causes diagnosed: (a) the FHIRPath type-checker can't walk a recursive `contentReference` at validation time (snapshot doesn't yet exist when invariants are checked), and (b) the MSH-exclusion expression `segment.type.first().code.endsWith('/MSH')` cannot be type-checked against the abstract `Segment` base, which is `kind: logical` with **zero differential elements** — there is no `.type` field to walk. Severity (`error` vs `warning`) is irrelevant: the type-check is unconditional and the failure is `java.lang.Error`, not a validation outcome. Stripped `v2-hxx-xor` and `v2-hxx-no-control` from `Hxx.json` and the 15 inlined message-structure sites. Updated `tooling/scripts/inline_hxx_pattern.py` to be self-healing — detect already-inlined parents, strip leftover constraints, refresh stale "slot-level invariant" wording in child definitions. Per-site `definition` now appended with "Per Hxx semantics (StructureDefinition/Hxx, ADR-0007): each occurrence carries exactly one segment OR one nested group, not both; MSH and transmission-control segments (BHS, BTS, FHS, FTS, DSC) are excluded." Added ADR-0007 follow-up listing four candidate paths to re-introduce machine-checkable enforcement (slicing, profile-level Constraint, custom validator, value-set binding on `.segment`). Commit `46ddaf80`.

**Confirmed Hxx recursive BackboneElement pattern works.** After the constraint-drop push (commit `865ecd74` to build), auto-IG ran for 67 minutes and got past TX init, snapshot generation, validation, output generation — no Hxx-related errors anywhere. The recursive `contentReference: #<parent-id>` in the `.group` child resolves correctly when the parent is the same SD. Pattern is validated end-to-end.

**tx.fhir.org outage chased and ruled out.** Two consecutive auto-IG runs on 2026-04-28 (17:19 UTC, 19:31 UTC) failed at TX init with `SocketTimeoutException` reading `https://tx.fhir.org/r5/metadata` (TLS handshake succeeded, then hung). Initial diagnosis was widespread tx.fhir.org outage, then revised when user found a Zulip thread confirming only-yesterday outage. Web research confirmed no IG-side parameter overrides the auto-IG-hardcoded `-tx http://tx.fhir.org` flag (verified against `Publisher.java#setTxServerValue`). By 2026-04-29 morning, tx.fhir.org was healthy — an MVP IG (orphan branch `mvp-test`) built within 2 minutes of push and got past TX init cleanly.

**Reversed ADR-0004 (extracted JS back to .js files), blocked by trust catch-22.** With Hxx working and tx healthy, the next failure surfaced: auto-IG's HTML scanner rejected the inline `<script>` blocks in 15,033 generated `*-testing.html` files with "put the script in a `.js` file in a trusted template (if it is justified and needed)." Source: `local-template/includes/_append.fragment-css.html` injects the `v2-table-filter` IIFE into every page's CSS fragment, and `local-template/includes/fragment-pageend.html` injects `v2-classic-tabs` (under `{% if v2classictabs %}`). Both extracted to standalone files at `local-template/content/assets/js/v2-table-filter.js` and `v2-classic-tabs.js`; replaced the inline blocks with `<script src="assets/js/...">`. Pushed to build (commit `865ecd74`); auto-IG rejected within **5 seconds** with the exact original ADR-0004 error: `Unable to execute 'onLoad' in script 'scripts/ant.xml' as the template '#local-template' is not trusted (reason: Template has file extensions: [.js])`. **Catch-22 confirmed and unresolvable from our side.** ADR-0004 marked "Reversed 2026-04-29" with the new failure quoted; the reversal stays in place because inline is no longer fallback-able (the HTML scanner check would fire again). User to file template-whitelist request to HL7 — only real fix.

**Created `mvp-test` orphan branch as auto-IG probe.** Bare-minimum IG (1 ImplementationGuide, 1 trivial CodeSystem with two concepts, 1 page, default `fhir.base.template`). Pushed at 2026-04-29 20:37 UTC; auto-IG picked it up in <2 min. Failed for two unrelated reasons: missing `input/includes/menu.xml` (template default expects it; Jekyll Liquid Exception during HTML generation), and R5 parameter-format warning ("property code is a class JsonPrimitive looking for an object" — R5 IG `parameter.code` is Coding `{system, code}`, not the R4-style string). Branch left in place as a known-good test article for future "is auto-IG infrastructure working?" probes — fix the two issues next time it's needed.

**Installed `gh` CLI to /home/claude/gh/** (no sudo, no write perm to `/home/claude/bin`). Added to `.claude-dev/provision.sh` so fresh containers restore it. User authenticated as `mfaughn`; confirmed `write` perm on HL7/v2ig but not `admin`, so webhook-listing endpoints return 404. Cannot diagnose webhook delivery from this side. The token in chat scrollback (`ghp_rDDr...`) is 7-day; revoke at session-end if not already done.

### Why

- **Drop invariants over fix invariants**: the FHIRPath engine genuinely cannot type-check recursive contentReferences before snapshot generation. Even rewriting the expressions wouldn't help; the engine throws `java.lang.Error` from the path-walking code, not from semantic validation. Narrative documentation in `definition` text + the structural shape (BackboneElement with segment/group children) preserves what the invariants encoded; machine-checkable re-introduction is now an ADR-0007 follow-up.
- **mvp-test branch over content bisection**: when auto-IG was silent on the build branch, the question was "is auto-IG broken, or is our IG broken?" Bisecting our IG content can't help (the failure mode in question is at TX init, before any content matters). A fresh orphan branch was the cleanest test: if it builds, auto-IG is fine and our build branch is being throttled. It built (got past TX init), proving auto-IG is alive — the build branch was on per-branch backoff.
- **Reverse ADR-0004 over leave-it-inline**: the new HTML-scanner check made inline non-viable. We were going to be blocked either way; the `.js` form at least leaves a clean state for the moment whitelisting happens.

### Commits this session

On `dev/framework` (with origin):
- `46ddaf80` — Drop Hxx FHIRPath invariants, document semantics narratively
- `0cd8fd83` — Add gh CLI to provision.sh for fresh container restore
- `7a7de99a` — Reverse ADR-0004: extract inline scripts back to .js files

On `main` / pushed to `build`:
- `1f8bf2d5` — Merge dev/framework: reverse ADR-0004 (re-externalize JS) (origin/main)
- `865ecd74` — Update from main (origin/build) — currently rejected by auto-IG trust check

On `mvp-test` (orphan, single commit):
- MVP IG pushed at 2026-04-29 20:37 UTC; broken on Jekyll/menu.xml (low priority follow-up)

### Relevant context for next session

- **Whitelisting is the gating action.** The `local-template/content/assets/js/{v2-table-filter,v2-classic-tabs}.js` files are the artifacts the whitelist would cover. Both are <100 lines, minimally adapted from THO's `table.js` pattern, and have no external dependencies beyond jQuery (which is already loaded by the base template via `tabs.js` infrastructure).
- **The base template (`fhir.base.template`) carries a security warning** in the build log: "This content depends on fhir.base.template which is no longer considered secure to use" (link: `https://www.fhir.org/guides/security-notices/2026-03-npm-dependencies.html`). Not blocking yet but worth following up on after whitelist; we may need to migrate to a different base template.
- **Auto-IG output URL** when whitelisting lands: `https://build.fhir.org/ig/HL7/v2ig/branches/build/`. Expected runtime ~70 min for our full IG (the 2026-04-29 19:56 UTC run was 67 min). Per-branch backoff means the first attempt after whitelisting may take 1–2 hours to start.
- **The `mvp-test` branch is left as-is** — orphan, broken on Jekyll/R5-parameter format. If we need the probe again, fix `input/includes/menu.xml` (stub will do) and convert IG `definition.parameter[].code` from string to `{system, code}` Coding form.
- **Per-branch backoff observed**: 18:48 UTC push → auto-IG processed at 19:56 UTC (~70 min delay). New branches process fast (~2 min). Empty commits don't reset the backoff window.
- **The 2026-04-29 19:56 UTC build log is the most informative artifact from this session.** It contains the proof that Hxx works structurally (it built past validation), the snapshot-generation timing (~5 min for the full IG), and the exact form of the HTML-scanner rejection. If diagnosing future builds, that log is worth pulling.
- **postproc-g full build remains the reliable structural verifier** when auto-IG is unavailable — runs in <1 hour with `-tx n/a`. Use `./apptainer/remote-build.sh full` (per MEMORY.md Build Rules).

---

### Completed

**V2 management report Sections 9 + 16 rewritten.** User pasted three V2.9.1 source clauses (CH01 §1.12 errata, CH04 §4.2.2.4 "Order detail segment", CH12 §12.3 "Note"). The §1.12 errata is the smoking gun: it explicitly states the future-direction intent that `Hxx` is the formal representation for the open-ended `etc.` / `...` placeholder. Folded the verbatim clauses into Section 9 as a "Source clauses from V2.9.1" subsection; Section 16 (the unification action log) updated with a "Note on equivalence" that defers to Section 9 and adds a new question about whether the MSH/transmission-control exclusion should be encoded as an enforceable invariant. The "is `...` ≡ `Hxx`?" question (was Section 16 Q1) is now answered "yes" per the standard's own stated direction.

**ADR-0007 written and revised mid-session.** Initial draft proposed centralized `Hxx.json` as a recursive logical model with `contentReference: "#Hxx"` referenced via `type` from each consuming SD. User correctly flagged that contentReference is StructureDefinition-scoped — when `Hxx` is composed into a consuming SD via type reference, the `#Hxx` fragment doesn't get rewritten to point to the local Hxx slot. Decision revised to **inline duplication at each of the 15 consuming sites**, with the `.group` element's `contentReference` pointing to the local Hxx slot (always same-SD, always unambiguous). The ADR now documents inline as the decision and centralized-via-type as the rejected alternative, with the contentReference scoping rationale explained.

**`Hxx.json` rewritten** as a recursive BackboneElement-shaped logical model (segment + group children, XOR + transmission-control invariants). `baseDefinition` shifted from `Segment` to `Base`, `meta.profile` reference to `Segment-Profile` removed — Hxx is no longer a segment; it is a sibling structural pattern. Kept in place at `input/sourceOfTruth/segment/segments/Hxx.json` even though it no longer belongs in `segments/` semantically — moving it deferred to ADR-0007's open follow-ups.

**`tooling/scripts/inline_hxx_pattern.py` written + applied to 15 sites.** Idempotent, has `--dry-run`. Walks all message-structure JSON files, finds elements typed as `http://hl7.org/v2/StructureDefinition/Hxx`, replaces each with three elements: the parent BackboneElement (preserving the original `short`/`definition` so per-site semantics stay tailored, dropping the `v2-segment-status: A` extension since the slot is no longer typed as a segment), the `.segment` child (typed as Segment), and the `.group` child (contentReference to the local parent Hxx slot id). Both invariants set to `severity: error` per user direction (the §1.12 wording "*does not limit your choice...except for MSH and other transmission control segments*" is normative, not advisory). The 15 sites cover the 11 from Section 16 (CH05 query patterns + CH08 MFN_Znn) plus the 4 CH12 ORDER_DETAIL CHOICE sites (PGL_PC6, PPG_PCG, PPP_PCB, PPR_PC1).

**Pushed to build.** `dev/framework` (`6040b245`) → `main` (`a61efd82`) → `build` (`35228d93`) via `./push-to-build.sh --no-preprocess` (FHIR-only change, no asciidoc to re-process). The build branch diff was unexpectedly large (795 files) — that's the cumulative carryover of files deleted on main (e.g., the unreferenced `StructureDefinition-ACK-*-intro.xml` files from the 2026-04-23 ACK collapse) finally reaching the build branch now that `push-to-build.sh` properly wipes synced trees before re-checkout. Auto-IG result pending at session-end.

### Why

- **Inline over centralized**: `contentReference` is SD-scoped. When the IG Publisher composes a logical model (Hxx) into a consuming SD via the `type` mechanism, it does not perform the fragment rewrite that would be needed to retarget `#Hxx` from the source SD to the consuming SD's local Hxx slot. The duplication cost (15 sites × ~30 lines of JSON each) is mitigated by an idempotent script and by retaining `Hxx.json` as the canonical reference definition. Centralized would have been cleaner architecturally; inline is the only thing that actually works.
- **Recursive BackboneElement over flat or parallel-array alternatives**: V2.9.1 §1.12 admits both segments AND segment groups in the placeholder, and V2 message order is significant. A flat `Reference(Segment)` cannot represent groups. Parallel typed arrays (`segments[]` + `groups[]`) silently lose the interleaving order between segments and groups in mixed sequences. The single repeating BackboneElement with XOR-per-occurrence (each occurrence is one segment OR one group, the slot itself repeats to express ordered sequences) is the only shape that captures both semantics.
- **Wrapper layer accepted as price of admission**: the BackboneElement adds a structural layer at FHIR-instance time (`{"segment": {...PID...}}`) that doesn't exist in V2 ER7 wire format (just `PID|...`). The wrapper does real work — it's the unit at which "segment XOR group" is decided per occurrence. ADR-0007 documents this explicitly.
- **Severity = error, not warning**: V2.9.1 §1.12 wording "*does not limit your choice of segment or segment groups, except for MSH and other transmission control segments*" is normative — putting MSH in an Hxx slot is forbidden by the standard, not merely discouraged. If the IG Publisher's FHIRPath engine can't validate the expression as written, fall back to warning (documented in JOURNAL ACTIVE as the rollback plan).

### Commits this session

On `dev/framework` (and pushed to origin):
- `43261b5c` — Redefine Hxx as recursive BackboneElement placeholder (ADR-0007) [first version, centralized design]
- `6040b245` — Inline Hxx recursive BackboneElement pattern at 15 sites (ADR-0007 revised) [revised to inline after user feedback]

On `main` / pushed to `build`:
- `a61efd82` — Merge dev/framework: Hxx recursive BackboneElement (ADR-0007)
- `35228d93` — Update from main (origin/build, pushed via `--no-preprocess`)

### Relevant context for next session

- **Auto-IG pending**: result drives next steps. The `.group`-element `contentReference` to local parent Hxx slot is the most novel structural feature in this push — never exercised before in this project. If IG Publisher snapshot generation handles it cleanly, the pattern is validated. If not, fall back is documented in ACTIVE.
- **Why the build-branch diff was 795 files**: not a problem with this push, just a one-time catch-up of file deletions on main (mostly the 113 unreferenced `ACK-*` files from the 2026-04-23 collapse, plus other earlier deletions) finally propagating because `push-to-build.sh` now properly `git rm -rf` synced trees before re-checkout. Future pushes should be small again.
- **The `v2-segment-status` extension on Hxx slots was removed by the inline script** — no consumers in the project enumerate elements by this extension that I'm aware of, but worth keeping in mind if downstream tooling complains.
- **Hxx is no longer a segment by ADR-0007**: it remains in `input/sourceOfTruth/segment/segments/Hxx.json` for now (moving deferred). Tooling that walks `segments/segments/` and assumes segment conformance should either tolerate Hxx's new baseDefinition or filter it out explicitly. The `Hxx` entry in the segments CodeSystem (`meta-resources/segment--v2-cs-segments.json`) is now arguably stale per ADR-0007's open follow-ups; not removed in this session.
- **`fix_dots_placeholder.py` from yesterday is still useful** — it remains the canonical fix for any future literal-`...` instances that surface (e.g., in event or choreography files we haven't grepped yet). `inline_hxx_pattern.py` only handles message-structure files and only converts existing Hxx-typed elements; it does not fix raw `...` literals.

---

## 2026-04-24 — `...` placeholder cleanup + LLM extraction prototype scaffolded

### Completed

**Auto-IG build chase, second pass.** Yesterday's session ended with one `...`-placeholder bug fixed (MFN_Znn) and a push to build. That build failed with the **same class of bug** in `QBP_Q11-A`. A grep across `input/sourceOfTruth/message-structure/message_structures/` found 10 more instances of the same pattern (CH05 query patterns). Wrote `tooling/scripts/fix_dots_placeholder.py` — idempotent with `--dry-run` — to do the substitution across all of them in one batch, plus remove a dangling `StructureDefinition/...` reference in `control-manifests/segments.json`. Cardinality was deliberately **not** changed on these 10 (descriptions are weaker than MFN_Znn's "one or more" rationale; per-file review needed). Section 16 of the V2 mgmt review report rewritten to cover the full set of 11 structures + 6 specific questions for the WG. Commits: `5c4d6d82` (MFN_Znn solo) → `02049383` (10 more + script) → merged to main as `fd4693e2` → pushed to build as `e62ee15c`.

**ADR-0006 Phase 1 prototype scaffolded.** Two new scripts on `dev/framework` (commit `e003713e`, tooling-only — not on main yet, doesn't need to go to build):
- `tooling/scripts/extract_v291_llm.py` — walks a chapter docx via python-docx, identifies candidate tables by **caption-style detection** (`Msg Table Caption` / `Attribute Table Caption`), computes clause numbers from Heading 2/3+ counters (mirrors python-docx extractor logic), renders tables as Markdown, calls Claude Sonnet 4.6 with prompt caching on the static system prompt, validates output with Pydantic models (`MessageStructureRecord`, `SegmentRecord`, `NotExtractable` discriminated union), writes one file per occurrence to `v291-llm/{message-structures,segments}/`. Has `--dry-run`, `--limit N`, `--include-unknown` flags. Reports token usage + cost estimate at end.
- `tooling/scripts/compare_python_vs_llm.py` — Phase 1 stretch goal. Per-occurrence diff between `v291-llm/message-structures/` and `v291-extracted/message-structures/`. Normalizes group-marker quirks (python-docx encodes `[{` and `}]` as `type:"segment"` with empty/`}]` codes — different from how the LLM emits them, so we strip both for fair comparison). Bucket classification: fully_agree / agree_with_metadata_diff / disagree_raw_only / disagree_parsed_only / disagree_both. Writes `v291-llm/comparison-report.md`.

**Dry-run validated the doc-walker.** CH03_PatientAdmin.docx gives 129 candidate tables (108 message_structure, 21 segment). Captions correctly attributed (ADT_A01 → caption "ADT^A01^ADT_A01: ADT Message" at clause 3.3.1, table_idx 2 — matches python-docx output exactly). Filename naming convention also matches (`<structureId>_<chapter>_<tableIndex>.json`).

**Memory + workflow updates.**
- `MEMORY.md` Build Rules updated: "**DEFAULT VERIFICATION PATH IS PUSH-TO-BUILD, not local builds.**" User explicitly retired routine subset builds 2026-04-23 — postproc-g full builds run in <1hr, that's the local fallback when push-to-build can't tell us what we need. Don't propose subset builds as routine.
- New feedback memory `feedback_merge_push_authority.md` — Claude is authorized to do `git checkout main && git merge dev/framework && git push origin main && ./push-to-build.sh` after committing build-relevant work, without asking each time. Still confirm before force-push, before bypassing main, or before merging multi-session work the user hasn't seen.

### Why

- **`...` cleanup**: same bug class kept biting us because the python-docx extractor faithfully copied the literal `...` from V2.9.1, but FHIR element-id semantics use `.` as a path separator. One unified script + a single review-report section is cheaper to maintain than chasing each instance separately.
- **Caption-style detection over heading-text matching**: the V2.9.1 docs put the actual table captions (`ADT^A01^ADT_A01: ADT Message`) in dedicated styles (`Msg Table Caption`, `Attribute Table Caption`), separate from numbered headings (`Heading 3` says "ADT/ACK - Admit/Visit Notification (Event A01)"). Detecting on style is far more reliable than regex-matching the heading text.
- **Per-table LLM call vs per-chapter**: per-table makes each extraction independently auditable + lets us iterate on prompts cheaply. Loses some cross-table context but for the V2 schema that doesn't matter much.
- **Sonnet 4.6 + prompt caching, no thinking**: extraction is a structured table-parsing task — adaptive thinking would be overkill and expensive. Strict JSON via Pydantic gives us schema enforcement without prompt-engineering work.

### Commits this session

On `dev/framework` (with origin):
- `5c4d6d82` — Replace literal '...' segment placeholder with Hxx in MFN_Znn
- `02049383` — Replace literal '...' segment placeholder with Hxx in 10 more message structures
- `e003713e` — Add LLM-mediated V2.9.1 extraction scripts (ADR-0006 Phase 1 prototype)

On `main` / pushed to `build`:
- `fd4693e2` — Merge dev/framework: '...' placeholder fix in 10 more message structures (origin/main)
- `e62ee15c` — Update from main (origin/build)

### Relevant context for next session

- **Background process still running**: `bash_id: bk1o7t4t3` runs `/tmp/build-poller.sh` (3-min poll interval, logs `/tmp/build-status.log`). Either kill it (`kill $(pgrep -f build-poller)`) or just leave it — it's lightweight. The script is at `/tmp/build-poller.sh` (also lightweight, regenerated next session if needed).
- **Pip packages installed this session**: `anthropic==0.97.0`, `pydantic==2.13.3`, plus their deps (httpx, anyio, etc.). Already added to `.claude-dev/provision.sh` so fresh containers will pick them up automatically.
- **Sonnet 4.6 model ID**: `claude-sonnet-4-6` — explicit per the user's request (the `claude-api` skill defaults to Opus 4.7 unless the user names a different model; user named Sonnet 4.6 in CLAUDE.md / JOURNAL hint).
- **The `extract_v291_llm.py` heuristic pre-filter** uses caption styles (`Msg Table Caption` / `Attribute Table Caption`). For chapters where these don't apply (e.g. CH02C vocabulary, CH02A data types may have a different style), pass `--include-unknown` to send all tables to the LLM and let it classify. More expensive but more thorough.
- **The Pydantic discriminated union** in the script (`ExtractionResult` with `classification` field) lets the LLM choose between three shapes per table: `message_structure`, `segment`, or `not_extractable`. The "not_extractable" branch with a one-line reason is intentional — it lets us audit *why* the LLM skipped a table (e.g. "introductory matrix", "vocabulary listing") without pretending we extracted nothing.
- **Lesson on the build-failure pattern**: when an IG Publisher snapshot-gen error mentions `"Unable to find parent path X.Y.Z..."` with double-dot at the end, that's almost certainly the literal-`...` bug. Grep for `StructureDefinition/...` first; that finds it instantly.
- **Lesson on the "set env var across messages" pattern**: a regular `Bash` tool call to `export VAR=value` only sets it in that subshell — it doesn't persist. The user-side `! export VAR=value` form works because the runtime treats it as a session-level command. Tell the user to use the `!` prefix when they need to set an env var that I'll consume later.

---

## 2026-04-23 — ACK collapse, V2 mgmt report sections, push-to-build CI fix, ADR-0006

### Completed

**CI build failure diagnosed and fixed.** Auto-ig-builder rejected the `build` branch with `Template has file extensions: [.js]` — the JS-inlining cleanup from ADR-0004 had landed on `main` but never propagated to `build`. Root cause: `git checkout <ref> -- <path>` only adds/updates files; it does not delete files that exist on the destination but no longer exist on the source. Fix in commit `76a75c5c` — `push-to-build.sh` now `git rm -rf` the synced trees before the cross-branch checkout, producing a faithful mirror of main.

**ACK collapse (commit `418b6b19`).** 115 enumerated `ACK-*` StructureDefinitions reduced to 2: `ACK` (canonical, used by 279 messages) and `ACK-Scheduling` (provisional name for the UAC-repeating outlier covering `ACK^S12-S24, S26, S27`, used by 15 messages). Touchpoints updated: 294 message-file `targetProfile` refs, listing page (`input/pagecontent/message-structures.xml`), CodeSystem (`input/sourceOfTruth/meta-resources/message-structure--v2-cs-message-structures.json`), control manifest. The 113 unreferenced ACK files were moved to `_archive/unreferenced-ack-structures/` (gitignored — present locally, never published, never propagated to main/build). Reusable script: `tooling/scripts/collapse_ack_structures.py` (idempotent, has `--dry-run`). Tag `pre-ack-collapse` marks the pre-state.

**V2 management report grew sections 13–15.** `v291-extracted/v2mgmt-review-report.md` now covers ACK collapse with caption-variant exemplars, NTE description form in MDM_T01/T02, and `GUARANTOR_INSURANCE` group name. The renderer (`render_review_report.py`) was fixed so code spans are extracted to placeholders before the underscore-italic substitution — `` `GUARANTOR_INSURANCE` `` was rendering as `GUARANTOR<em>INSURANCE</em>`.

**V291 review report trimmed.** `v291-canonical/v291-review-report.html` no longer dumps the per-ACK-message table (was 115 rows). Replaced with a "Caption-Description Variants" summary that lists only the non-canonical phrasings with exemplar clauses. The per-structure "Occurrences in V2.9.1" table now collapses to count + first/last clause when there are >20 occurrences (ACK was the trigger; other future high-occurrence structures get the same treatment automatically).

**ADR-0006 written: multi-corpus V2.9.1 extraction.** Captures the rationale for adding two new extraction corpuses (LLM-mediated + pandoc-redo) targeting the same JSON schema as `v291-extracted/`, with a 4-way consensus diagram and a bucket-classification framework for the resulting comparison report. Explicitly notes the LLM corpus is a *validator*, not a *generator* — FHIR resources remain the published artifact.

**Project doc reorganization.** Dropped `SESSION-HANDOFF.md` (had drifted out of sync — its "overwritten each session" header was no longer true). Restructured `JOURNAL.md` with an ACTIVE header at the top (current state, overwritten each handoff) plus a Session History below; older entries (everything before 2026-04-15) moved to `JOURNAL-archive.md`. Updated `MEMORY.md` and `CLAUDE.md` to describe the new file layout.

### Why

- **CI**: a silent staleness was hiding from us that build had never received the JS cleanup. Without the `git rm -rf`, we'd keep republishing yesterday's content even after merging to main.
- **ACK**: 115 near-duplicates were noise in the source-of-truth tree. Collapsing them lets us be *precise* about the one real distinction (UAC repetition in scheduling) and surface it for V2 Management review.
- **Reports**: the V2 mgmt discussion document is for humans to reason over, not for machines to consume. Exhaustive 115-row tables push the actual decisions off-screen.
- **ADR-0006**: two corpuses share parsing blind spots. The only way to establish fidelity at the level this project requires is independent multi-pipeline consensus.
- **Doc reorg**: 1,291-line `JOURNAL.md` was being read at every `/uadf-start` for the marginal value of ~150 lines of recent context. Plus `SESSION-HANDOFF.md` had drifted into a misleading state.

### Commits this session (all on `dev/framework`)

- `76a75c5c` — Fix push-to-build.sh to delete files removed on main
- `418b6b19` — Collapse 115 ACK structures into ACK + ACK-Scheduling
- `0f2c2644` — Reorganize JOURNAL.md, drop SESSION-HANDOFF.md, add ADR-0006
- `3a4eae4b` — Fix collapse_ack_structures.py to rewrite name/title/type fields (caught by post-merge build failure)

The `0f2c2644` commit was originally made on `main` by mistake (the user had merged `dev/framework` → `main` mid-session, leaving HEAD on `main` after the next `git checkout`). It was cherry-picked to `dev/framework` and `main` was reset back to `origin/main` — no force-push occurred and main never had the wrong commit pushed.

### Relevant context for next session

- The `_archive/` directory pattern is now a reusable convention: add to `.gitignore`, move stuff there for "in directory tree but not part of the IG and not committed". Useful for future similar collapses.
- Tag `pre-ack-collapse` is on commit `f6b8c074` — fully recoverable if the collapse turns out to be wrong.
- `apply_canonical_to_fhir.py`'s position-based element matching (with segment-code sanity check) is the right pattern for any FHIR-side bulk-edit script — copy that approach for similar tooling.
- The `claude-api` skill should be triggered when implementing the LLM extraction (it provides current Anthropic SDK guidance and prompt-caching patterns).
- The 4-way consensus framework in ADR-0006 explicitly says LLM hallucinations are a real risk — never trust LLM output as a sole source; only as one of N for consensus.
- **Lesson from the ACK-Scheduling build failure**: when renaming a FHIR StructureDefinition, the IG Publisher validates that differential paths start with the value of `type` (or the structure's logical name). Always rewrite all of: `id`, `url`, `name`, `title`, `type`, plus differential `id`/`path` fields. Missing any of these will fail validation at IG Publisher time, not at file-write time. Run a build (or at least a `validator.jar` pass) after any FHIR resource rename.
- **Lesson from accidentally committing to `main`**: `push-to-build.sh` and similar cross-branch operations leave HEAD wherever they finished. Always `git rev-parse --abbrev-ref HEAD` before committing in a session that has touched multiple branches.

---

## Session Handoff - 2026-04-22

### Completed This Session

**FHIR vs V291 canonical comparison + apply pipeline:**
- Added `--canonical` flag to `compare_message_structures.py` (writes suffixed reports). Confirmed FHIR vs raw = 916 diffs, FHIR vs canonical = 1316 — the +400 represents V291 fixes not yet propagated to FHIR.
- Built `tooling/scripts/apply_canonical_to_fhir.py` to shuttle canonical V291 fixes into FHIR message structure JSON. Filters to canonical-only diffs (raw vs canonical key includes v291_value) so we only propagate fixes we actually made, not pre-existing FHIR/V291 disagreements.
- Applied 581 fixes across 320 message structure files: 538 description (e.g. "Software Segment"→"Software", PRT/OBX qualifier names), 40 optionality (R→O on NTE/PRT/ROL), 3 repetition. Group renames intentionally deferred — they require rewriting element IDs and BackboneElements.
- Post-apply: FHIR vs canonical drops from 1316 → 735 discrepancies (cosmetic 619→140, structural 697→595).
- HTML traceability report at `v291-canonical/fhir-apply-report.html`.

**Build infrastructure:**
- Fixed malformed XML in `input/v2plus.xml` line 244 — the `data-type/` `path-resource` block was missing its `<code>` wrapper and `<system>` element, leaving an orphan `</code>`. IG Publisher rejected the file before it could try R4 vs R5 parsing.
- Full build on postproc-g succeeded (~54 min). qa.html: errors=63189, warn=34776, broken-links=16573 — proportional to subset (8446 errors), all known content gaps (FIXME placeholders, missing value sets, `{{v2-table:XXXX}}` placeholders).
- Added safety guards to `push-to-build.sh`: warns if local main is behind origin/main, and warns if the current branch has IG-relevant commits not yet in main. Triggered today by a push-to-build that succeeded against stale main and silently republished prior content.

**SSH/rsync transient failure investigation:**
- Initial postproc-g connection failed with rsync code 255. Diagnosis sequence: interactive ssh worked but `ssh -t` and rsync both hung. After session was killed via `~.`, retries succeeded. `.bashrc`/`.bash_profile` clean. Concluded transient server-side issue, no fix needed.

**Commits on dev/framework:**
- `20d7802f` — Apply V291 canonical fixes to FHIR message structures (319 files, +7188/-660)
- `f100e596` — Fix malformed path-resource parameter in v2plus.xml
- `6e3fd599` — Add safety guards to push-to-build.sh

**Cross-branch:**
- Merged dev/framework → main (user did this manually). origin/main now at `f100e596`.
- Ran push-to-build.sh after the merge. origin/build at `34bc7ca5` ("Update from main") with latest content.
- Auto-ig-builder kicked off — should be building at `https://build.fhir.org/ig/HL7/v2ig/branches/build/`.

### Current State (at end of 2026-04-22)
- Branch: `dev/framework` (1 commit ahead of origin — the push-to-build.sh guards)
- Last checkpoint: `6e3fd599` — Add safety guards to push-to-build.sh
- Tests: 84 message-structure comparison tests pass; 3 pre-existing failures unchanged (registry drift × 2, ER7 leak)
- Working tree: clean (2 untracked .tiff files still hanging around)

### Relevant Context (carried into 2026-04-23)
- **Canonical-only filter**: `apply_canonical_to_fhir.py`'s `_disc_key()` includes `v291_value` so that "we changed V291 from X to Y here" is treated as a fix-to-shuttle even if raw V291 also disagreed with FHIR. If V291 didn't change between raw and canonical, the disc is filtered out — it's an open FHIR/V291 disagreement, not a fix we made.
- **Position-based element matching**: The apply script finds FHIR elements by 1-indexed position from `extract_fhir_segments()`, then sanity-checks that the segment code matches before patching. This avoids brittleness from element-ID assumptions.
- **Why XML fix happened**: The malformed `path-resource` block on line 244 was a hand-edit error — only one block in the file was bad, all others were well-formed. v2plus-subset.xml unaffected. Not a generator bug.
- **push-to-build.sh stale-main bug**: The script's docstring is explicit ("Always pulls from main"), but the user's mental model was "the script handles everything". The new guards prompt for confirmation if main is behind or if the current branch has unmerged IG content.
- **Auto-ig-builder branch naming**: Still constrained to `[A-Za-z0-9_-]`. We're on `build` (flat name), so this is fine.

---

## Session Handoff - 2026-04-16

### Completed This Session
- **V291 reconciliation**: reduced 94 multi-occurrence differences to 35 (83 fixes in fixes.json)
- **Broken extraction investigation**: QBP_Q11 clause 5.3.3.3 is Word parsing artifact (hidden columns); NMD_N02 second table is ACK^N02^ACK mislabeled by caption reuse
- **Cosmetic fixes**: "Segment" suffix removal (313 changes), dash normalization (81), group names (COMPONENT→COMPONENTS), singular/plural alignment
- **PRT/OBX description audit**: 7 typos, 33 segment-code replacements (ORC→Common Order, RXO→Pharmacy/Treatment Order, etc.), 21 qualified observation group fixes (Patient Observation, Specimen Observation, etc.)
- **Review report**: `v291-canonical/v291-review-report.html` — ACK section with 116 messages, yellow-highlighted non-standard captions, per-structure provenance with events, cardinality recommendations
- **New scripts**: `audit_prt_descriptions.py` (clause refs on every finding), `generate_v291_review_report.py`
- Commits: `148c826a`, `7b982c1a`, `285950ba` (3 ahead of origin)

### Current State (at end of 2026-04-16)
- Branch: `dev/framework` (3 commits ahead of origin)
- Last checkpoint: `285950ba` — Fix qualified observation group PRT descriptions
- 83 fixes total, 35 remaining multi-occurrence differences

---

## Session Handoff - 2026-04-15 20:30 UTC

### Completed This Session

**Message Structure Comparison (FHIR vs V291):**
- Built `tooling/scripts/compare_message_structures.py` — compares 418 FHIR structures against V291, categorizes diffs as structural vs cosmetic, generates JSON/Markdown/HTML reports
- 84 tests in `test/test_compare_message_structures.py`, all passing
- Commit: `c2757bd1`

**V291 Extraction Fixes:**
- Split table continuation: CCM_I21 (5→152 rows), CCR_I16 (35→185), CCU_I20 (11→162) — gender harmony insertions split Word tables
- Choice group markers (`<`, `>`, `|`) now parsed in 22+ structures across CH11/12/16/17
- Clause numbers computed from Word heading hierarchy, replacing internal table indices in all provenance
- Commits: `92bd8482`, `385d0074`

**V291 Internal Consistency Report:**
- Built `tooling/scripts/compare_v291_occurrences.py` — compares multiple occurrences of the same structure ID within V291
- Fine-grained classification: bracket_malformed, cardinality, desc_typo, desc_cosmetic, desc_meaningful, etc.
- `--canonical` flag runs against fixed data so resolved issues drop off
- Commit: `898a88c9`, `15fd3232`

**V291 Canonical Pipeline:**
- `v291-canonical/fixes.json` — declarative manifest of all fixes with traceability (35 entries)
- `tooling/scripts/apply_v291_fixes.py` — clones raw → applies fixes → writes canonical + HTML report
- Supports: bulk bracket normalization, description_titleize, description_replace (with segment_filter), pending_review items
- Commits: `f7ddc5f7`, `01e6b391`, `ad83e520`

**ACK Structure Reconciliation (foundational for the 2026-04-23 collapse):**
- Fixed all ACK descriptions: MSH→"Message Header", MSA→"Message Acknowledgment", SFT→"Software", UAC→"User Authentication Credential", ERR→"Error"
- Fixed ERR cardinality in clauses 5.4.4-5.4.7: `[ ERR ]` → `[{ ERR }]`
- **114 of 115 ACK structures now identical** — ready to collapse into single canonical structure
- 1 outlier (clause 10.4, UAC repeating) flagged as REVIEW-0001 for V2 Management

**FHIR Resource Fixes:**
- Varies: moved from segment/segments/ to data-type/ as abstract data type derived from Base
- Hxx: updated description as "any segment or segment group" placeholder
- I12-I15: created 4 event StructureDefinitions (Patient Referral, CH11)
- V2 mgmt review report expanded to 12 sections (Varies, Hxx, QPD, choice groups, O59, message structure findings)
- Commits: `8d7a54fe`, `69f2024c`

**Remaining V291 consistency (after fixes):** 16 structures, 94 differences (down from 24/311)

### Current State (at end of 2026-04-15)
- Branch: `dev/framework` (up to date with origin, 14 commits this session)
- Last checkpoint: `ad83e520` — Fix ACK descriptions, ERR cardinality, add pending review support
- Tests: 84 message structure comparison tests passing; other test suites not re-run
- Working tree: clean (2 untracked .tiff files)
