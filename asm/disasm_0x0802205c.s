@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802205c, 0x080220c4)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802205c --end 0x80220c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802205c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802205e: b084        sub	sp, #16
@   0x08022060: 2400        movs	r4, #0
@   0x08022062: 4f0b        ldr	r7, [pc, #44]	@ (0x22090)
@   0x08022064: 2503        movs	r5, #3
@   0x08022066: 2604        movs	r6, #4
@   0x08022068: 2001        movs	r0, #1
@   0x0802206a: 4020        ands	r0, r4
@   0x0802206c: 2800        cmp	r0, #0
@   0x0802206e: d111        bne.n	0x22094
@   0x08022070: 1c20        adds	r0, r4, #0
@   0x08022072: 3019        adds	r0, #25
@   0x08022074: 00a1        lsls	r1, r4, #2
@   0x08022076: 19c9        adds	r1, r1, r7
@   0x08022078: 6809        ldr	r1, [r1, #0]
@   0x0802207a: 2261        movs	r2, #97	@ 0x61
@   0x0802207c: 9200        str	r2, [sp, #0]
@   0x0802207e: 9601        str	r6, [sp, #4]
@   0x08022080: 9502        str	r5, [sp, #8]
@   0x08022082: 9503        str	r5, [sp, #12]
@   0x08022084: 2200        movs	r2, #0
@   0x08022086: 2305        movs	r3, #5
@   0x08022088: f7ff        f80a 	bl	0x210a0
@   0x0802208c: e010        b.n	0x220b0
@   0x0802208e: 0000        movs	r0, r0
@   0x08022090: 1074        asrs	r4, r6, #1
@   0x08022092: 0831        lsrs	r1, r6, #32
@   0x08022094: 1c20        adds	r0, r4, #0
@   0x08022096: 3019        adds	r0, #25
@   0x08022098: 00a1        lsls	r1, r4, #2
@   0x0802209a: 19c9        adds	r1, r1, r7
@   0x0802209c: 6809        ldr	r1, [r1, #0]
@   0x0802209e: 2271        movs	r2, #113	@ 0x71
@   0x080220a0: 9200        str	r2, [sp, #0]
@   0x080220a2: 9601        str	r6, [sp, #4]
@   0x080220a4: 9502        str	r5, [sp, #8]
@   0x080220a6: 9503        str	r5, [sp, #12]
@   0x080220a8: 2200        movs	r2, #0
@   0x080220aa: 2306        movs	r3, #6
@   0x080220ac: f7fe        fff8 	bl	0x210a0
@   0x080220b0: 1c60        adds	r0, r4, #1
@   0x080220b2: 0600        lsls	r0, r0, #24
@   0x080220b4: 0e04        lsrs	r4, r0, #24
@   0x080220b6: 2c0d        cmp	r4, #13
@   0x080220b8: d9d6        bls.n	0x22068
@   0x080220ba: b004        add	sp, #16
@   0x080220bc: bcf0        pop	{r4, r5, r6, r7}
@   0x080220be: bc01        pop	{r0}
@   0x080220c0: 4700        bx	r0

        thumb_func_start sub_0802205C
sub_0802205C: @ 0x0802205c
        .incbin "frog_us_baserom.gba", 0x2205c, 0x68
        thumb_func_end sub_0802205C
