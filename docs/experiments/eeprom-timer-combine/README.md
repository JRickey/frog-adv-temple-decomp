# EEPROM timer combine investigation

This standalone reproduction is diagnostic, not a matching implementation.
The live function at 0x08033948 remains assembly. Installed old_agbcc SHA256:
`5041c5dd57875aad111b8e239bac9dedfda95729430b65aa271fd54400c08dcf`.

From the repository root, use a new scratch directory for each run:

```sh
trial=$(mktemp -d /tmp/eeprom-trace.XXXXXX)
cpp=$(tools/find_cpp.sh)
"$cpp" -P docs/experiments/eeprom-timer-combine/source.c -o "$trial/source.i"
tools/agbcc/bin/old_agbcc -O2 -mthumb-interwork -fhex-asm -da -dumpbase "$trial/source.i" -o "$trial/output.s" "$trial/source.i"
```

The checked-in excerpts show the discriminating result: RTL expansion and CSE
retain index load insn 30 before constant-8 insn 32. Combine deletes insn 30 and
folds its byte memory operand into shift insn 33. Local allocation retains this.
Reload, visible in the greg dump, inserts insn 93 after constant 8 and assigns
r1 to mask/result and r2 to index. Final output reproduces the known residual.
The target instead loads r1 before initializing r2 to 8.

This rejects frontend expansion as the earliest cause. The installed compiler
supports -da, but emits no separately named reload dump. Its gcc/thumb.md
variable shift requires a register count; gcc/reload1.c inserts the operand
load before its consumer. Use gcc/, not gcc_arm/, for this old compiler.

Next test: instrument combine's acceptance of this memory-count substitution
in a private compiler copy. A diagnostic veto of this one substitution should
restore load-before-constant; inspect allocation separately. Such a modified
compiler is a causal experiment only and cannot establish a project match.
Then seek a justified source or interface shape that avoids the same fold
under the stock compiler. Stop if the veto does not restore the predicted
order; revisit the trace instead of varying source blindly.

The full immutable local package, including checksums and all pass dumps, is
in nonmatchings/timer-investigation/trace/20260908T_timer_best_readable_rtl_v2/.
These excerpts and source preserve the finding when ignored scratch is absent.
