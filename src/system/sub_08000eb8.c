#include "game.h"
#include "types.h"

/* sub_08000EB8 — mode 9 handler.
 *
 * Status: DEFERRED. Scaffold + callee peels landed; C body postponed.
 *
 * Shape (transcribed from asm/disasm_0x08000eb8.s):
 *   - 624 bytes, ~156 Thumb instructions
 *   - Prologue: push {r4, r5, lr} + sub sp, #332  (332-byte local frame)
 *   - Initialises [sp+0x148] (substate) = 0; calls sub_08020BC0(buf, …)
 *   - 9-way jump table on substate (sp+0x148):
 *       case 0  → 0xef0   case 1 → 0xf14   case 2 → 0xf3c
 *       case 3  → 0xf6c   case 4 → 0xf90   case 5 → 0xfb8
 *       case 6  → 0xff8   case 7 → 0x1050  case 8 → 0x1090
 *   - case 6 fans out to: sub_0800A2D8, sub_080008DC, sub_0800A328,
 *     sub_080094F8, sub_08009984, sub_08000E0C (just peeled),
 *     then increments gGameStuff[20] (u32).
 *   - case 8 has its own counter at sp+0x140, gates on sub_080106B8,
 *     then writes gGameStuff.mode = 4 (which exits the loop).
 *   - Tail: if gGameStuff.state (offset 9) is 9 or 24, loops back to top;
 *     else pops 332+lr and returns.
 *
 * Why deferred (per playbook honesty-check):
 *   - Sibling sub_08000918 (mode 8, identical shape — 596 bytes, 14-way
 *     dispatch, same state-loop tail) is still asm. The class hasn't been
 *     cracked yet.
 *   - 6 distinct adjacent IWRAM bases in pool literals
 *     (0x03005330, 0x03005398, 0x03003720, 0x03006110, 0x03005328,
 *     0x03003480) — adjacent-IWRAM-base CSE-fold is a known unmatchable
 *     class without the linker-assigned-symbol trick from
 *     docs/codegen-notes.md, and there are too many bases here to
 *     bulk-convert without a separate pass.
 *   - The 332-byte stack buffer is passed by pointer (r0 = sp) to 18
 *     different callees. Modelling it as a local struct vs. char[332]
 *     vs. typed sub-objects changes which IWRAM-base load anchors agbcc
 *     picks — high blast radius for register-allocation drift.
 *   - 29 pool entries means several adjacent loads of the same address
 *     (each `gGameStuff` reload at a case head); the baserom re-emits
 *     `ldr` rather than caching, which the corpus has only matched with
 *     a per-case local-pointer-shadow idiom that's hard to apply at 9
 *     cases.
 *
 * Prerequisites for a future attempt:
 *   1. Crack sub_08000918 first (smaller-but-equivalent shape, more
 *      cases but same total scale). If 918 stays as NAKED, this one
 *      should ship as NAKED too.
 *   2. Promote at least 0x03005330, 0x03003720, 0x03005398, 0x03005328
 *      to linker-assigned IWRAM symbols so the adjacent-IWRAM-base
 *      CSE-fold is defeated structurally before this fn is touched.
 *   3. Type the 332-byte stack buffer once sub_08020BC0 is decomped
 *      (its first arg is the same buffer — that's where the layout
 *      gets pinned).
 *
 * Caller: AgbMain mode 9 dispatch (src/system/agb_main.c).
 * Callees peeled this iter: sub_08000E0C (172 B, uses r8 — likely
 * NAKED-class on its own).
 */
