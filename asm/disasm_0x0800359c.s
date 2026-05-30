@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800359c, 0x080035d0)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800359c --end 0x80035d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800359c: b500        push	{lr}
@   0x0800359e: b082        sub	sp, #8
@   0x080035a0: 4809        ldr	r0, [pc, #36]	@ (0x35c8)
@   0x080035a2: 4b0a        ldr	r3, [pc, #40]	@ (0x35cc)
@   0x080035a4: 2101        movs	r1, #1
@   0x080035a6: 9100        str	r1, [sp, #0]
@   0x080035a8: 2103        movs	r1, #3
@   0x080035aa: 9101        str	r1, [sp, #4]
@   0x080035ac: 2180        movs	r1, #128	@ 0x80
@   0x080035ae: 220b        movs	r2, #11
@   0x080035b0: f002        ffec 	bl	0x658c
@   0x080035b4: 200b        movs	r0, #11
@   0x080035b6: 2100        movs	r1, #0
@   0x080035b8: f009        fc6e 	bl	0xce98
@   0x080035bc: f006        fb7e 	bl	0x9cbc
@   0x080035c0: b002        add	sp, #8
@   0x080035c2: bc01        pop	{r0}
@   0x080035c4: 4700        bx	r0
@   0x080035c6: 0000        movs	r0, r0
@   0x080035c8: 6110        str	r0, [r2, #16]
@   0x080035ca: 0300        lsls	r0, r0, #12
@   0x080035cc: 9aec        ldr	r2, [sp, #944]	@ 0x3b0
@   0x080035ce: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_0800359C
sub_0800359C: @ 0x0800359c
        .incbin "frog_us_baserom.gba", 0x359c, 0x34
        thumb_func_end sub_0800359C
