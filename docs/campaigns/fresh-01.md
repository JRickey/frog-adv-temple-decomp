# First untouched-function campaign

Base: `2582f699d829cd375f15ffb8941471eaa4d611d7`. Accepted game-source commit: `679a8ed9adec766c20246dc265e370365e325745`.
Harness correction: `d9b08000` (linker destination lookup).

| Target | Address | Result |
|---|---|---|
| LevelLayout_SpawnGroup317A4C | 0x080296b8 | 88-byte unpinned C match, first integrated candidate |
| Menu_ApplyCursorRoute | 0x08018188 | 72-byte unpinned C match, first integrated candidate |
| Eeprom_StartTimer candidate | 0x08033948 | Deferred; original assembly restored |

These functions had no C definitions when selected by the picker. This is a
campaign on previously assembly-only targets, not a claim that no historical
agent ever inspected their disassembly. No register pins or NAKED fallbacks
were added. Assembly-function count decreased from 245 to 243. The public
estimated pure-C count increased from 727 to 729.

## Accepted semantics and interfaces

The entity routine initializes slots 50..54 from the first five pointers in
sLevelLayoutPtrs. The group name retains its data anchor because a more specific
level/actor identity is not established. Its natural modulo expression and u8
loop match the target; the existing SpawnRecord layout and exact initializer
prototype now live in entity_spawn.h and are included by the new caller and
callee. Other older const-void declarations remain separate cleanup work.

The menu routine maps cursor 0/1/2 to FILE_SELECT/OPTIONS/MENU_07 routing and
clears two dispatch bytes. A direct switch with named cursor/route values
matches. Unexpected cursor values leave state unchanged. MENU_07 keeps its
established mode identifier rather than inventing a screen meaning.

## Harness findings

The brief skipped linker entries without address-range comments, suggesting
an older C file despite the picker identifying the correct predecessor. The
fix reads actual section order, stops at intervening assembly and never uses
the following C file as an append destination. Four regression cases cover it.

Renaming a target before matching loses its original name-based address-cache
entry. A newer-compiler timer trial moved the preceding function by four bytes;
the unseeded new name was compared at its current address rather than flagged
as drift. That result is not a codegen score against the proper target range.
Known new-name aliases were then seeded from the original baseline entries.
For future trials, retain the original name until the function matches, then
rename and refresh addresses only from a verified matching ROM.

The brief's full struct cross-reference output can be large. This campaign
used bounded output and focused source reads; no automatic context-size or
usage optimization is claimed.

## Timer handoff

The observed routine saves IME, disables it, enables the selected timer IRQ,
re-enables IME, clears the timeout flag, installs a countdown and writes timer
reload/control halfwords. Its direct caller passes a three-halfword record.
The accepted live tree retains the original assembly and unchanged timer APIs.

The best readable candidate has 100 bytes and seven differing bytes over five
instructions at +0x10/+0x12/+0x14/+0x16/+0x18. The index load and constant 8
initialization occur in the wrong order, with swapped low-register roles.

Representative trial results:

| Source hypothesis | Observation |
|---|---|
| Struct config fields; separate pointer updates | 96 bytes, 50 byte / 24 instruction differences |
| Combined ordinary-pointer post-increment stores | Correct complete write tail; 14 byte / 10 instruction residual with index local |
| Direct mask expression without index local | 100 bytes, seven byte /five instruction residual |
| Typed mask, explicit IRQ locals, equivalent bit formula | Same seven-byte residual |
| Narrow inline helper boundaries | Changed allocation/pool order; did not match |
| Volatile index | Four byte /four instruction residual; no established semantic justification |
| Newer compiler | Predecessor moved four bytes; not accepted and score not comparable |
| -fno-schedule-insns | Installed old compiler rejects the option |

A related public decomp timer helper in the local pokeemerald corpus uses
ordinary timer pointers and post-increment assignments. Its role is an idiom
comparison, not evidence of original Frogger source or a matching result.
An early claim that pointer-object volatility was necessary was rejected.
Another claim misattributed current generated assembly to an earlier candidate;
immutable per-trial oracle reports corrected it. Workers must not inspect a
changing generated .s and infer which source/configuration produced it.

Local scratch: nonmatchings/fresh-campaign/timer/. RESUME.md, best-readable.c,
resume.patch and per-trial oracle logs preserve the handoff. The reconstructed
patch has not been re-applied after restoration; inspect it and rerun the
oracle. Local ignored scratch is not guaranteed to exist in a fresh clone.

Next discriminating work: examine gcc/expr.c and expmed.c shift-count expansion
and RTL before/after allocation for the ordinary u8 index. Explain why the load
is delayed past the constant move before trying more source variations. This
campaign spent too many similar trials on that residual; future escalation
should happen earlier once several source shapes produce identical output.

## Verification and routing

Both accepted functions matched on their first integrated oracle runs. A clean
build and make check reproduce ROM SHA1
7b4c27009198df18555e63fb5dcad223eaf09815. Final progress reports zero ROM byte
differences. Address snapshots and README statistics were refreshed. The
infrastructure gate passes 47 tests plus evidence/campaign validation.

Sol prepared and reviewed the entity candidate; Terra prepared/analyzed the
timer candidate; Astra integrated, owned builds, diagnosed the timer and wrote
the menu routine. The accompanying ledger records review corrections. Token
usage and selected reasoning effort remain unavailable (null); this small,
unequal workload is not a controlled model ranking.
