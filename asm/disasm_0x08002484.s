@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002484, 0x080024e4)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002484 --end 0x80024e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002484: b570        push	{r4, r5, r6, lr}
@   0x08002486: 1c05        adds	r5, r0, #0
@   0x08002488: 1c0e        adds	r6, r1, #0
@   0x0800248a: f008        f849 	bl	0xa520
@   0x0800248e: 4912        ldr	r1, [pc, #72]	@ (0x24d8)
@   0x08002490: 4c12        ldr	r4, [pc, #72]	@ (0x24dc)
@   0x08002492: 7aa2        ldrb	r2, [r4, #10]
@   0x08002494: 0090        lsls	r0, r2, #2
@   0x08002496: 1840        adds	r0, r0, r1
@   0x08002498: 6800        ldr	r0, [r0, #0]
@   0x0800249a: f031        fc1d 	bl	0x33cd8
@   0x0800249e: 4910        ldr	r1, [pc, #64]	@ (0x24e0)
@   0x080024a0: 7aa2        ldrb	r2, [r4, #10]
@   0x080024a2: 0090        lsls	r0, r2, #2
@   0x080024a4: 1840        adds	r0, r0, r1
@   0x080024a6: 6800        ldr	r0, [r0, #0]
@   0x080024a8: f031        fc16 	bl	0x33cd8
@   0x080024ac: f007        fad4 	bl	0x9a58
@   0x080024b0: f006        fe6a 	bl	0x9188
@   0x080024b4: f7fe        fa12 	bl	0x8dc
@   0x080024b8: f007        ff36 	bl	0xa328
@   0x080024bc: f007        f81c 	bl	0x94f8
@   0x080024c0: f007        fa60 	bl	0x9984
@   0x080024c4: 1c28        adds	r0, r5, #0
@   0x080024c6: 1c31        adds	r1, r6, #0
@   0x080024c8: f7ff        fcac 	bl	0x1e24
@   0x080024cc: 6960        ldr	r0, [r4, #20]
@   0x080024ce: 3001        adds	r0, #1
@   0x080024d0: 6160        str	r0, [r4, #20]
@   0x080024d2: bc70        pop	{r4, r5, r6}
@   0x080024d4: bc01        pop	{r0}
@   0x080024d6: 4700        bx	r0
@   0x080024d8: 0cb8        lsrs	r0, r7, #18
@   0x080024da: 080c        lsrs	r4, r1, #32
@   0x080024dc: 5330        strh	r0, [r6, r4]
@   0x080024de: 0300        lsls	r0, r0, #12
@   0x080024e0: 0d40        lsrs	r0, r0, #21
@   0x080024e2: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_08002484
sub_08002484: @ 0x08002484
        .incbin "frog_us_baserom.gba", 0x2484, 0x60
        thumb_func_end sub_08002484
