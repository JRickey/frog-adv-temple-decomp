# Scene18 helper boundaries and initial allocation

These are diagnostic candidates, not accepted game code. `hand-expanded.c`
produced 732 bytes with 75 differing bytes; `inline-candidate.c` produces the
same size with four differing bytes. It contains unresolved local interfaces
and address literals which still require cleanup before acceptance.

The inline bodies are independently supported by the adjacent existing
Mode11_SetupEntities, Scene_InitHitboxes and Mode12_SetupAndUpdate routines.
Inlining their stack-array arguments substitutes direct frame-relative
expressions into hard argument moves during expansion. This recovers call
scheduling and the case-4 pointer recomputation that manual expansion obscured.
The remaining initial zero store uses the opposite r0/r1 allocation.

Reproduce in an isolated configured checkout of cca193eca2fb90d93eb90fdccb3836b36245d9b5:
copy one candidate to `src/game/sub_08003864.c`, remove only
`asm/disasm_0x08003864.o(.text)` from linker.ld, then run:

```sh
python3 tools/agent/compile_and_view_assembly.py GameMode_Scene18 --human
```

The compiler identity and observed four-byte result are preserved beside this
file. Neither candidate passes the whole-ROM gate. Do not copy a predecessor's
complete linker script over unrelated accepted changes. Restore both owned
source and linker changes, then clean rebuild before using the checkout again.

[Allocation findings](allocation-findings.md) describe the fresh compiler-pass
investigation, rejected canonical-for/control-frame/memset variants, and the
next evidence required. Detailed RTL and full trial packets remain in ignored
`nonmatchings/large-five/GameMode_Scene18` in the two worker checkouts. Paths
inside the copied configuration identify the original diagnostic checkout.

The checked-in C is clang-formatted. Both formatted candidates were rerun on the camera plus HUD-interface base a780e55b: 732/75 and 732/4 remain unchanged. `formatted-reproduction.json` records their exact hashes and the fresh oracle logs are adjacent. Original configuration hashes refer to the unformatted diagnostic source.
