# Scroll and blit recovery packets

These are restart briefs, not newly verified decomp results. The source state
was inspected at `14c3dfb7`; the recovery observations below came from earlier
experiments. No candidates were applied while preparing these packets.

## Shared restart procedure

Run `make check-infra`, retrieve the target evidence brief, inspect the cited
source and establish a fresh ROM baseline. Preserve the original worktrees
and ignored scratch. Before running experiments there, integrate the current
workflow/oracle tooling in a reviewed change or use an isolated checkout of
the current campaign branch and copy only the chosen candidate. The old
worktree oracle still needs manual artifact invalidation; the current oracle
handles content changes itself. Do not replay old mutation scripts blindly.

Evidence prerequisites identify the questions to investigate; observations
are not automatically verified just because they appear earlier in the DAG.
Finish accepted source work with a clean build and `make check`.

## BlitEntityTileFrame1 — 0x0801288c

Current source: `src/engine/sub_0801288c.c`. It contains eleven pinned
register declarations, including two distinct r1 locals. The recovery restored
the original source; no acceptable depin landed. The original report of ten
pins undercounted the declarations.

Historical recovery source: commit
`63238672e88afafa2071b12decaefa920a16dafe`, appended section in
`docs/depin-worklist.md`. Its reusable findings are reproduced here so this
brief does not require that worktree or transcript to be loaded.

- Removing uninitialized `hold5`/`hold6` and canceled arithmetic left nine
  differing bytes: the r7 save/restore and signed-coordinate-load zero-index
  choice changed. Explicit initialization, narrow locals, operand ordering
  and an explicit r7 zero-index local did not recover the target shape.
- Removing only `stride2 asm("r3")` left three differing bytes at offsets
  +0x84/+0x86/+0x88: the row-stride load used r0 instead of r3. Signedness,
  scope, subtraction forms and inline row-advance helpers did not solve it.
- A candidate that reused the column counter as an integer pointer and then
  stride matched but was rejected as misleading source. Do not ship it.
- The interrupted draft had 219 differing bytes. It is not the best starting
  point simply because it was the last agent edit.

Local recovery worktree: `.claude/worktrees/agent-ad20b591104eadfa1`.
Scratch: `nonmatchings/BlitEntityTileFrame1/`, notably `RESUME.md`,
`pinned_orig.c`, `blend_noholds.c`, `stride_direct.c`, and
`resume_results.json`. Scratch and the private instrumented compiler are
optional local artifacts; their existence is not a portability guarantee.
The shared installed compiler was not modified during recovery.

Next test: audit the descriptor and sibling blitters, especially
`src/engine/sub_08012664.c`, `src/engine/sub_0801297c.c`, and the
Scroll_FlushTilemapWindow boundary. Compare field widths, coordinate loads,
row counters and pointer lifetimes. Predict which genuine live value explains
the r7 save and which row-advance lifetime selects r3 before modifying C.
A three-byte residual does not justify more arbitrary statement permutations.
Relevant prior success: `compiler.inline-selector-return-width`.

## ScrollUpdate_Pass0 — 0x0800f814

Range: [0x0800F814, 0x0800FCC8), 1204 bytes. The function remains in
`asm/disasm_0x0800f814.s`; its destination C file is only a scaffold.
Historical recovery source: commit
`fb57886c271c0941a71d639e63b2d8cb8b056c90`,
`docs/scroll-update-pass0.md`. No matching C replacement landed.

The recovered interpretation is vertical tilemap scrolling: move committed Y
one pixel toward requested Y, save the hardware scroll offset, and refill a
32-entry row at eight-pixel boundaries. The recovery identified unsigned
16-bit step/column/offset/copy counters and signed clip halfwords at
`0x030063C0 + layer * 16`, offsets 0 and 2. Recheck these observations against
the assembly before adopting shared layouts or names.

- An initial jump to the outer test reproduced the target branch to
  0x0800FC94; an ordinary for-loop draft duplicated the test. Pass1's
  top-tested outer loop is not a template to copy unchanged.
- A linker-assigned `gScrollClipSpans` symbol produced the target signed-load
  form; an absolute pointer macro produced unsigned loads and extension shifts.
- The destination base is spilled but is not thereby volatile: the upward
  loop loads it once at 0x0800FC52 and reuses r7 at 0x0800FC60.
- The target carries source in r8, columns in r9, pixels in sl and source
  offset in ip. The unpinned candidate instead assigned destination base to
  sl and working source to ip. Scopes, inline copying, aliases, volatility,
  statement ordering and selected optimization flags did not converge.
- The reported best diagnostic variant had 983 differing bytes, 315
  instruction differences and 1172 output bytes. Its do/while(0) wrapper is
  not evidence of an original macro. These are historical scores.

Local recovery worktree: `.claude/worktrees/agent-a66c6fbfddd1ec20f`.
Scratch: `nonmatchings/ScrollUpdate_Pass0/resume/`, including
`original-draft.c`, `structural-reference.c`, `best.c`, `best.patch`,
`best-oracle.txt` and RTL dumps. The patch was made against the recovery
worktree's original HEAD; inspect its context before applying elsewhere.

Next test: compare direction branches and Pass1 to reconstruct entry/test
control flow and the exact 16-bit counter boundaries. Audit caller parameter
width and clip-span signedness before allocation tuning. Predict the lifetime
that should spill the destination while keeping source in r8; test this
against the target and compiler pass output. The current structural residual
is not a justification for a NAKED fallback or a coloring-only permuter run.
