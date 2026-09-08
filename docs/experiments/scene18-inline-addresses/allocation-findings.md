# Scene18 fresh initialization diagnosis

## Result and preserved best

No accepted decompilation. `reproduced-best/source.c` remains 732 bytes with
4 differing bytes / 4 instruction residuals. Its oracle was rerun on paired
HEAD cca193ec (accepted Scroll_UpdateCameraAlt retained), so it does not rely
on the older worker checkout's changing build outputs. Paired tracked source
and linker were restored exactly; final `make check` passed.

The residual is solely at +0xa..+0x10: target loads/adds initial state address
in r0 then materializes zero in r1 and stores; candidate uses r1/r0 respectively.

## Compiler explanation

The immutable predecessor inline-helpers dumps show the address as pseudo110,
constant773 as pseudo111 and zero as pseudo112. `expanded.i.flow` retains
pseudo111; `expanded.i.combine` folds it into `(plus r7 const773)` and deletes
the separate constant instruction. `expanded.i.lreg` assigns110 to r1 and112
to r0. Thus this is already decided by local allocation, not by final reload.
Reload subsequently reconstructs the large-offset load/add pair.

The inspected clean-room compiler source local-alloc.c:1435 computes quantity
priority from floor_log2(refs)*refs*size divided by actual quantity lifetime.
Both remaining pseudos have two references; the later-defined zero has the
shorter quantity lifetime and wins r0. The printed REG_LIVE_LENGTH of zero is
4 only because update_equiv_regs doubles it; local-alloc.c:850 explicitly says
that doubling does NOT affect local-allocation priority. Do not infer priority
from the lreg summary's printed live_length alone.

This suggests a future discriminator: find an evidence-backed initializer
expansion that keeps the initial offset/address in one combined quantity with
additional actual references through local allocation, without changing the
late stack-slot assignment or inventing no-op arithmetic/asm barriers. No such
ordinary source idiom was established in this run. An actual shared initializer
from neighboring clean-room code would be better evidence than source mutation.

## New trials (all immutable source/configuration/oracle files)

- full-frame: existing SceneLoop_21/22 struct-frame idiom; 776 bytes,671 diff.
  Exposing all fields together changes pointer hoisting across the whole loop.
- control-array: adjacent SceneLoop_20 control-byte-array idiom;660 bytes,595
  diff. Avoids small-struct promotion but uses base+byte-offset addressing and
  broadens CSE, so it does not preserve target address expressions.
- builtin-clear: initial declaration used wrong size_t and failed Werror.
  Correct-size trial uses agbcc's actual unsigned-long size_t from
  tools/agbcc/include/stddef.h:10;700 bytes,650 diff. Standard memset lowering
  follows compiler expr.c:8165/1779 clear_storage path, but taking state address
  early swaps the accept/state slots and reproduces the earlier pointer trial.
- phase-pointer: use a meaningful phase pointer at the three existing phase
  calls, before explicitly addressing initial state. Restores the state-slot
  order but holds a new offset in r9;744 bytes,679 diff. Not accepted.
- canonical-for: equivalent for(state=0; mode condition;) instead of explicit
  goto-tail/do-while;732 bytes,4 diff, identical residual. Fresh -da dumps show
  initial address118 and zero120 have the same post-combine graph and opposite
  physical allocation as the predecessor. This rejects loop-spelling as the
  missing distinction; do not replay while/for permutations without new evidence.

## Validation and cautions

Starting make check passed. Auto-peel attempted the existing Sound_ServiceQueue
region and its boundary detector failed on sandbox IPC EPERM; no peel changes
were made. There was no need for new callees to reproduce the best candidate.

After exact tracked-file restoration, make initially reused the just-produced
source object and diagnosed duplicate Scene18 definitions against restored ASM.
A forced rebuild of only src/game/sub_08003864.o followed by make and make check
passed. Always verify source freshness after same-second restoration; do not
accept a restored text file as proof the corresponding object was rebuilt.

No compiler binary, baserom, SHA1 metadata, header, or other accepted function
was changed. No commit. Model gpt-6-astra, inherited effort. Per-worker cached
input, uncached input, output, and total usage unavailable (null).
