@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023514, 0x08023538)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023514 --end 0x8023538 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023514: b500        push	{lr}
@   0x08023516: b081        sub	sp, #4
@   0x08023518: 4905        ldr	r1, [pc, #20]	@ (0x23530)
@   0x0802351a: 4b06        ldr	r3, [pc, #24]	@ (0x23534)
@   0x0802351c: 2000        movs	r0, #0
@   0x0802351e: 9000        str	r0, [sp, #0]
@   0x08023520: 205f        movs	r0, #95	@ 0x5f
@   0x08023522: 224c        movs	r2, #76	@ 0x4c
@   0x08023524: f7fd        fff4 	bl	0x21510
@   0x08023528: b001        add	sp, #4
@   0x0802352a: bc01        pop	{r0}
@   0x0802352c: 4700        bx	r0
@   0x0802352e: 0000        movs	r0, r0
@   0x08023530: 1488        asrs	r0, r1, #18
@   0x08023532: 0831        lsrs	r1, r6, #32
@   0x08023534: 6110        str	r0, [r2, #16]
@   0x08023536: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023514
sub_08023514: @ 0x08023514
        .incbin "frog_us_baserom.gba", 0x23514, 0x24
        thumb_func_end sub_08023514
