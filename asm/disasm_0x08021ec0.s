@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021ec0, 0x08021eec)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021ec0 --end 0x8021eec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021ec0: b500        push	{lr}
@   0x08021ec2: b084        sub	sp, #16
@   0x08021ec4: 466b        mov	r3, sp
@   0x08021ec6: 8802        ldrh	r2, [r0, #0]
@   0x08021ec8: 801a        strh	r2, [r3, #0]
@   0x08021eca: 466a        mov	r2, sp
@   0x08021ecc: 8840        ldrh	r0, [r0, #2]
@   0x08021ece: 8050        strh	r0, [r2, #2]
@   0x08021ed0: 8808        ldrh	r0, [r1, #0]
@   0x08021ed2: 8110        strh	r0, [r2, #8]
@   0x08021ed4: 8848        ldrh	r0, [r1, #2]
@   0x08021ed6: 8150        strh	r0, [r2, #10]
@   0x08021ed8: 4668        mov	r0, sp
@   0x08021eda: 2100        movs	r1, #0
@   0x08021edc: 2201        movs	r2, #1
@   0x08021ede: f7ff        fc79 	bl	0x217d4
@   0x08021ee2: 0600        lsls	r0, r0, #24
@   0x08021ee4: 0e00        lsrs	r0, r0, #24
@   0x08021ee6: b004        add	sp, #16
@   0x08021ee8: bc02        pop	{r1}
@   0x08021eea: 4708        bx	r1

        thumb_func_start sub_08021EC0
sub_08021EC0: @ 0x08021ec0
        .incbin "frog_us_baserom.gba", 0x21ec0, 0x2c
        thumb_func_end sub_08021EC0
