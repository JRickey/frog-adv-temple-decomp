@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08024024, 0x08024048)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8024024 --end 0x8024048 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024024: b500        push	{lr}
@   0x08024026: b081        sub	sp, #4
@   0x08024028: 4905        ldr	r1, [pc, #20]	@ (0x24040)
@   0x0802402a: 4b06        ldr	r3, [pc, #24]	@ (0x24044)
@   0x0802402c: 2000        movs	r0, #0
@   0x0802402e: 9000        str	r0, [sp, #0]
@   0x08024030: 2074        movs	r0, #116	@ 0x74
@   0x08024032: 2204        movs	r2, #4
@   0x08024034: f7fd        fa6c 	bl	0x21510
@   0x08024038: b001        add	sp, #4
@   0x0802403a: bc01        pop	{r0}
@   0x0802403c: 4700        bx	r0
@   0x0802403e: 0000        movs	r0, r0
@   0x08024040: 2228        movs	r2, #40	@ 0x28
@   0x08024042: 0831        lsrs	r1, r6, #32
@   0x08024044: 6110        str	r0, [r2, #16]
@   0x08024046: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08024024
sub_08024024: @ 0x08024024
        .incbin "frog_us_baserom.gba", 0x24024, 0x24
        thumb_func_end sub_08024024
