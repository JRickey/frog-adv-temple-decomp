@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08006a74, 0x08006aac)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8006a74 --end 0x8006aac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08006a74: b570        push	{r4, r5, r6, lr}
@   0x08006a76: 4646        mov	r6, r8
@   0x08006a78: b440        push	{r6}
@   0x08006a7a: 1c04        adds	r4, r0, #0
@   0x08006a7c: 9d05        ldr	r5, [sp, #20]
@   0x08006a7e: 062d        lsls	r5, r5, #24
@   0x08006a80: 0e2d        lsrs	r5, r5, #24
@   0x08006a82: 2600        movs	r6, #0
@   0x08006a84: 7021        strb	r1, [r4, #0]
@   0x08006a86: 2000        movs	r0, #0
@   0x08006a88: 4680        mov	r8, r0
@   0x08006a8a: 8062        strh	r2, [r4, #2]
@   0x08006a8c: 7123        strb	r3, [r4, #4]
@   0x08006a8e: f00f        ffd7 	bl	0x16a40
@   0x08006a92: 7165        strb	r5, [r4, #5]
@   0x08006a94: 4640        mov	r0, r8
@   0x08006a96: 7360        strb	r0, [r4, #13]
@   0x08006a98: 7320        strb	r0, [r4, #12]
@   0x08006a9a: 6166        str	r6, [r4, #20]
@   0x08006a9c: 8226        strh	r6, [r4, #16]
@   0x08006a9e: 8266        strh	r6, [r4, #18]
@   0x08006aa0: bc08        pop	{r3}
@   0x08006aa2: 4698        mov	r8, r3
@   0x08006aa4: bc70        pop	{r4, r5, r6}
@   0x08006aa6: bc01        pop	{r0}
@   0x08006aa8: 4700        bx	r0

        thumb_func_start sub_08006A74
sub_08006A74: @ 0x08006a74
        .incbin "frog_us_baserom.gba", 0x6a74, 0x38
        thumb_func_end sub_08006A74
