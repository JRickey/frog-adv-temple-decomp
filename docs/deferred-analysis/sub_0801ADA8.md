# Deferred analysis: sub_0801ADA8

Credits-roll tilemap-script interpreter. Slice `asm/disasm_0x0801ada8.s`
(0x0801ada8..0x0801b0ac, 0x304 bytes) carries TWO functions:
sub_0801ADA8 (0x1ada8..0x1b094, the interpreter) and an orphan tail
function at 0x1b098 (`sub_0801B098`, 16 B, no callers/refs in the ROM:
`gGameStuff.pendingMode = arg + 8`). Removing the slice requires
reproducing BOTH plus the 2-byte alignment gap at 0x1b096 and the trailing
pool word at 0x1b0a8.

Caller: sub_0801B224 (`result = sub_0801ADA8(arg); state->lastTime = *timer;`).
Signature: `u8 sub_0801ADA8(u8 arg)`. Returns 0 normally, 0xFE on
user-cancel (gIwram_5398 == 16 or 32 = mapped UP/RIGHT exit keys).

## Semantics (fully reverse-engineered, high confidence)

State struct at 0x03006440:
  +0x0C const u16 *pc      script cursor into sCreditsTilemapEng (0x081bee64)
  +0x14 u16 *front         front BG double-buffer
  +0x24 u16 *back          back BG double-buffer
  +0x30 u16 cursor         column within the current row
  +0x32 u16 swapped        page-flip latch

Opcodes (u16 at *pc): 0xFFFF=END (flip pages, wait, DMA-clear both bufs),
0xFFFE=WAIT_B (in-place input wait), 0xFFFC=WAIT_A (clear gIwram_5398,
wait, then dispatch sub_0801AC84 / sub_0801AD10 alternating on
*(u32*)0x03003544), 0xFFFD=LITERAL_RUN (operand-0xE0E7 indexes the
credits tilemap, 3 halfwords/glyph: writes [front+cursor*2] and
[front+cursor*2+64]), default=raw literal (writes 0 + *pc).

The flashing "press button" prompt tile is 0xE0E4, written to
[front+108] toggling every >3 frames (gGameStuff._unk00 timer) while
polling input via sub_080004C4 into gIwram_5398 (0x03005398).

## Drift

Best stuck point: byte_diff 720, diff_count 359 (of ~210 insns) — i.e.
essentially the whole body is mis-colored, NOT a localized fold.

Root cause is a GLOBAL high-register allocation scheme that agbcc 2.x will
not adopt from any clean-C shape:

  baserom:  r9 = &gIwram_5398 (held across the whole fn, the input slot),
            ip = sCreditsTilemapEng (reloaded `mov ip,rN` at each loop top),
            r8 = arg, r5/r6 = state. r9 is RE-PURPOSED to &state in the
            END-path tail (0x1b008 `mov r9, &state`), so it is NOT a single
            stable pointer — a single `register asm("r9")` pin can model
            the dominant use but not the tail re-purpose.
  agbcc:    ip = &gIwram_5398, r9 = &state — the EXACT OPPOSITE high-reg
            assignment, plus extra `mov r0,ip`/`mov r3,r9` shuffles.

Second independent driver: the wait-loop is the documented two-stage
shared-global pattern. baserom reserves `sub sp,#8` to SPILL r2=&gGameStuff
to [sp,#4] across `bl sub_080004C4`, so the snapshot `frameStart = *(timer)`
uses the cached pointer while the loop-top count-check RELOADS the timer
address via a PC literal. agbcc instead reloads &gGameStuff after the bl
(`sub sp,#4`, no spill) because the count-check (absolute) makes the cached
pointer dead across the bl. This is the same "reload-for-check vs
cached-for-snapshot, pointer live across bl" split that left sub_0802EA80
and sub_08017364 stuck at ~90% diff with no source lever. Appears 3x here
(WAIT_A, WAIT_B, END-wait sub-loops), so it dominates.

## Levers tried (all floored 359..370)

1. cached `GameStuff *gs = &gGameStuff` for snapshot + absolute
   `gGameStuff._unk00` for the count-check (the faithful two-stage shape).
   -> still `sub sp,#4`, no spill; 384.
2. move `table = sCreditsTilemapEng` INSIDE the loop (to get the
   per-iteration `mov ip,rN` reload). -> 370.
3. `register u8 arg asm("r8")` — no-op, agbcc already kept arg in r8.
4. `register vu16 *vmIn asm("r9") = &gIwram_5398`, route ALL gIwram_5398
   r/w through *vmIn. -> 359 (best). The r9 pin is fought by the END-tail
   re-purpose of r9 to &state, and ip still gets &gIwram_5398 not the table.

Permuter NOT run: .venv missing in the worktree (and main), and a 359/210
diff is far outside permuter's ~40 useful range anyway — this is a global
coloring scheme, not statement-ordering.

## Next ideas for a future attempt

- Try pinning the TABLE (sCreditsTilemapEng) to a register and leaving
  gIwram_5398 unpinned, to flip the ip/r9 assignment the other way; or
  pin table to `asm("sl")` and input to `asm("r9")` simultaneously.
- The END-tail re-purpose of r9->&state suggests the function may need r9
  unpinned in the tail (scope the pin to the loop body only via a nested
  block, or accept the tail as a separate diff region).
- Instrument agbcc local-alloc/reload to see WHY ip wins for &gIwram_5398
  over r9 (the prologue saves r8,r9 but ip is call-clobbered, so caching
  the loop-invariant input slot in r9 should be cheaper — agbcc's cost
  model disagrees).

## Best-effort C (byte_diff 720 / diff_count 359; do NOT ship — make check fails)

```c

extern u32 sub_080004C4(void);

extern const u8 sCreditsTilemapEng[];
extern u16 gIwram_5398;

/* opcodes in the credits-roll tilemap script stream (state->pc points into it) */
#define CREDIT_OP_LITERAL_RUN 0xFFFD /* operand indexes sCreditsTilemapEng (3 halfwords/glyph) */
#define CREDIT_OP_WAIT_A 0xFFFC      /* flush front page, wait for input */
#define CREDIT_OP_WAIT_B 0xFFFE      /* wait for input in place */
#define CREDIT_OP_END 0xFFFF         /* end of script: flip pages, wait, clear */

#define CREDIT_TILE_PROMPT 0xE0E4 /* flashing "press button" prompt tile */
#define CREDIT_GLYPH_BASE 0xE0E7  /* operand - this = glyph index into the tilemap */

struct CreditsState {
    u8 _pad00[12];
    const u16 *pc; /* +0x0C: script cursor into sCreditsTilemapEng */
    u8 _pad10[4];
    u16 *front; /* +0x14: front BG buffer */
    u8 _pad18[28];
    u16 *back;  /* +0x24: back BG buffer */
    u8 _pad28[4];
    u16 cursor; /* +0x30: column within the current row */
    u16 swapped; /* +0x32: page-swap latch */
};


u8 sub_0801ADA8(u8 a0)
{
    register u8 arg asm("r8");
    register vu16 *vmIn asm("r9");
    struct CreditsState *state;
    GameStuff *gs;
    const u16 *op;
    u16 opcode;
    const u8 *table;
    u32 frameStart;
    u32 flash;
    vu16 wait;
    vu32 *dma;
    u16 input;
    u16 *oldFront;
    u16 *oldBack;

    arg = a0;
    vmIn = (vu16 *)0x03005398;
    state = (struct CreditsState *)0x03006440;
    if (*state->pc == CREDIT_OP_END) {
        goto end_script;
    }

    for (;;) {
        table = sCreditsTilemapEng;
        op = state->pc;
        opcode = *op;

        if (opcode == CREDIT_OP_WAIT_B) {
            frameStart = 0;
            flash = 0;
            do {
                input = *vmIn;
                if (input == 16 || input == 32) {
                    goto exit_fe;
                }
                gs = &gGameStuff;
                state = (struct CreditsState *)0x03006440;
                for (;;) {
                    while (gGameStuff._unk00 - frameStart > 3) {
                        if (flash != 0) {
                            *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                        } else {
                            *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                        }
                        flash = (flash == 0) ? 1 : 0;
                        frameStart = gs->_unk00;
                        *vmIn = sub_080004C4();
                    }
                    input = *vmIn;
                    if (input == 16 || input == 32) {
                        break;
                    }
                }
            } while (input != 32);
            goto exit_fe;
        }

        if (opcode == CREDIT_OP_WAIT_A) {
            *vmIn = 0;
            frameStart = 0;
            gs = &gGameStuff;
            state = (struct CreditsState *)0x03006440;
            flash = 0;
            for (;;) {
                while (gGameStuff._unk00 - frameStart > 3) {
                    if (flash != 0) {
                        *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                    } else {
                        *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                    }
                    flash = (flash == 0) ? 1 : 0;
                    frameStart = gs->_unk00;
                    *vmIn = sub_080004C4();
                }
                input = *vmIn;
                if (input == 16) {
                    break;
                }
                if (input == 32) {
                    break;
                }
            }
            if (input == 32) {
                goto exit_fe;
            }

            if (*(u32 *)0x03003544 == 0) {
                *(u32 *)0x03003544 = 1;
                (*(u8 *)0x03003541)++;
                sub_0801AC84(arg);
            } else {
                *(u32 *)0x03003544 = 0;
                (*(u8 *)0x03003541)++;
                sub_0801AD10(arg);
            }
            goto after_dispatch;
        }

        if (opcode == CREDIT_OP_LITERAL_RUN) {
            u32 glyph;

            state->pc = op + 1;
            glyph = (u16)(op[1] - CREDIT_GLYPH_BASE);
            *(u16 *)((u8 *)state->front + state->cursor * 2) =
                *(const u16 *)((u8 *)table + ((glyph * 3 + 1) << 1));
            *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) =
                *(const u16 *)((u8 *)table + ((glyph * 3 + 2) << 1));
            state->pc = op + 2;
        } else {
            *(u16 *)((u8 *)state->front + state->cursor * 2) = 0;
            *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) = *op;
            state->pc = op + 1;
        }

        state->cursor++;
        if (*state->pc == CREDIT_OP_END) {
            break;
        }
    }

after_dispatch:
    state = (struct CreditsState *)0x03006440;
    if (*state->pc != CREDIT_OP_END) {
        goto bump_pc;
    }

end_script:
    state->cursor = 0;
    if (state->swapped == 0) {
        state->swapped = 1;
        oldBack = state->back;
        state->back = state->front;
        state->front = oldBack;
        goto bump_pc;
    }

    frameStart = 0;
    flash = 0;
    for (;;) {
        input = *vmIn;
        if (input == 16 || input == 32) {
            goto do_swap;
        }
        gs = &gGameStuff;
        for (;;) {
            while (gGameStuff._unk00 - frameStart > 3) {
                if (flash != 0) {
                    *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                } else {
                    *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                }
                flash = (flash == 0) ? 1 : 0;
                frameStart = gs->_unk00;
                *vmIn = sub_080004C4();
            }
            input = *vmIn;
            state = (struct CreditsState *)0x03006440;
            if (input == 32) {
                goto exit_fe;
            }
            if (input == 16 || input == 32) {
                goto do_swap;
            }
        }
    }

do_swap:
    state = (struct CreditsState *)0x03006440;
    state->swapped = 0;
    oldBack = state->back;
    oldFront = state->front;
    state->back = oldFront;
    state->front = oldBack;

    wait = 0;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldFront;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldFront + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldBack;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldBack + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

bump_pc:
    state->pc++;
    *vmIn = 0;
    return 0;

exit_fe:
    *vmIn = 0;
    return 0xFE;
}

void sub_0801B098(u8 arg)
{
    gGameStuff.pendingMode = arg + 8;
}
```
