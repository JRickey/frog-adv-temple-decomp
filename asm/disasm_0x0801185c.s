@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801185c, 0x08011884)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801185c --end 0x8011884 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801185c: b500        push	{lr}
@   0x0801185e: 1c01        adds	r1, r0, #0
@   0x08011860: 0609        lsls	r1, r1, #24
@   0x08011862: 0e09        lsrs	r1, r1, #24
@   0x08011864: 4806        ldr	r0, [pc, #24]	@ (0x11880)
@   0x08011866: 8800        ldrh	r0, [r0, #0]
@   0x08011868: 0600        lsls	r0, r0, #24
@   0x0801186a: 0e00        lsrs	r0, r0, #24
@   0x0801186c: 226b        movs	r2, #107	@ 0x6b
@   0x0801186e: 4350        muls	r0, r2
@   0x08011870: 3007        adds	r0, #7
@   0x08011872: f022        facf 	bl	0x33e14
@   0x08011876: 0600        lsls	r0, r0, #24
@   0x08011878: 0e00        lsrs	r0, r0, #24
@   0x0801187a: bc02        pop	{r1}
@   0x0801187c: 4708        bx	r1
@   0x0801187e: 0000        movs	r0, r0
@   0x08011880: 0006        movs	r6, r0
@   0x08011882: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801185C
sub_0801185C: @ 0x0801185c
        .incbin "frog_us_baserom.gba", 0x1185c, 0x28
        thumb_func_end sub_0801185C
