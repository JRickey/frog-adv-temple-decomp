<!--
  Adapted from Mizuchi (https://github.com/macabeus/mizuchi),
  mizuchi.example.yaml :: plugins.claude-runner.softTimeout.prompt
  + the "stall" guidance from
  https://github.com/macabeus/mizuchi/issues/30
  Copyright (c) 2025 macabeus, MIT License. See ATTRIBUTION.md.

  Injected when N consecutive iterations show no reduction in diff_count.
-->

You have iterated several times without reducing the diff count. Repeating near-identical attempts is the most common failure mode in this loop.

Stop refining your current approach. Try a **fundamentally different** strategy. Some options:

- Restructure control flow: replace nested if/else with goto+label (or vice versa). agbcc 2.x's codegen is sensitive to source-level control flow.
- Change variable types: `u8`/`s8`/`u16`/`s16`/`u32`/`s32` — promotion/extension rules differ and the wrong choice shifts which Thumb instructions get emitted.
- Pin a register: `register T x asm("rN");` to force a specific allocation if the diff shows wrong-register usage.
- Reorder local variable declarations: agbcc allocates stack slots in declaration order; reordering can fix offset mismatches.
- Inspect the diff for `ldr` vs `ldrh` vs `ldrb` — width mismatches are the dominant class of agbcc/GBA failures and almost always trace back to a wrong field type in a struct.
- If the issue is in a called function's prologue/epilogue, the bug is probably in the function's signature (param count, types, return type).

If after one more attempt with a genuinely different approach you still can't match, stop. Revert your edits to the C file with `git checkout -- <file>`, leave the asm in place, and report:
1. The minimal `diff_count` you achieved
2. Which mismatch kind dominated (INSERTION / OPCODE_MISMATCH / etc.)
3. Your best hypothesis for what the underlying obstacle is
