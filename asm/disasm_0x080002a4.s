@ AgbMain: the master game loop dispatcher. Entered from _start at
@ 0x080000EC via the thumb pointer stored at 0x08000230.
@
@ Range:  [0x080002a4, 0x08000430)  (396 bytes, thumb mode)
@
@ Structure:
@   prologue (0x2A4-0x2D3): one-time init (sub_08000430 + sub_08020BC0),
@     then a forever-loop reading gGameStuff.mode (offset 9) and dispatching
@     to one of 26 case bodies via a jump table.
@   literal pool 1 (0x2D4-0x2E3): 4 words (REG_WAITCNT addr, WAITCNT init
@     value, gGameStuff base, jump-table base).
@   jump table (0x2E4-0x34B): 26 word entries — case bodies for modes 4..29.
@     Indexed by `(mode - 4) << 2`. Case 24 (mode 28) shares its body with
@     the default "out of range" case at 0x426.
@   case bodies (0x34C-0x42B): one body per mode. All tiny (6-8 byte
@     bl + b.n trampolines) except case 0 (mode 4) at 0x34C which is
@     the substantial title-screen / boot body.
@   tail literal (0x42C): single word 0x03003540, referenced by a case
@     body at 0x41E.
@
@ Stage-1 refinement: prologue + pool 1 are real mnemonics; jump table
@ and case bodies are still .incbin. Future stages will refine the rest.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start AgbMain
AgbMain: @ 0x080002a4
        push    {lr}
        ldr     r1, .LAgbMain_reg204            @ -> 0x04000204 (REG_WAITCNT?)
        ldr     r2, .LAgbMain_const4014         @ -> 0x00004014 (init value)
        adds    r0, r2, #0                      @ r0 = 0x4014
        strh    r0, [r1, #0]                    @ *(0x04000204) = 0x4014
        bl      sub_08000430                    @ Init1 (TBD)
        ldr     r1, .LAgbMain_gGameStuff        @ -> 0x03005330
        movs    r0, #4
        strb    r0, [r1, #9]                    @ gGameStuff.mode = 4 (initial state)
        .4byte  0xfc82f020                      @ bl sub_08020BC0 (TBD, "tick" / "VBlank wait")
.LAgbMain_loopTop:                               @ 0x080002bc — case bodies branch back here
        ldr     r0, .LAgbMain_gGameStuff
        ldrb    r0, [r0, #9]                    @ r0 = gGameStuff.mode
        subs    r0, #4                          @ idx = mode - 4
        cmp     r0, #25
        bls     .LAgbMain_dispatch
        .short  0xe0ae                          @ b.n 0x426 (default case, inside .incbin)
.LAgbMain_dispatch:
        lsls    r0, r0, #2                      @ idx <<= 2
        ldr     r1, .LAgbMain_jumpTablePtr
        adds    r0, r0, r1                      @ &jumpTable[idx]
        ldr     r0, [r0, #0]                    @ case target
        mov     pc, r0                          @ goto case (Thumb -> Thumb, no thumb-bit needed)
        .short  0                               @ alignment pad before literal pool
.LAgbMain_reg204:
        .word   0x04000204
.LAgbMain_const4014:
        .word   0x00004014
.LAgbMain_gGameStuff:
        .word   0x03005330
.LAgbMain_jumpTablePtr:
        .word   0x080002E4                      @ -> jump-table base (next byte)
@ Jump table + case bodies + tail literal: still .incbin. Range:
@   [0x080002E4, 0x08000430)  =  0x14C bytes.
        .incbin "frog_us_baserom.gba", 0x2E4, 0x14C
        thumb_func_end AgbMain
