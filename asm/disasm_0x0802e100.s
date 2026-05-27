@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e100, 0x0802e13c)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e100 --end 0x802e13c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e100: b500        push	{lr}
@   0x0802e102: 1c03        adds	r3, r0, #0
@   0x0802e104: 2b00        cmp	r3, #0
@   0x0802e106: d015        beq.n	0x2e134
@   0x0802e108: 0c1a        lsrs	r2, r3, #16
@   0x0802e10a: 20ff        movs	r0, #255	@ 0xff
@   0x0802e10c: 4002        ands	r2, r0
@   0x0802e10e: 4808        ldr	r0, [pc, #32]	@ (0x2e130)
@   0x0802e110: 6800        ldr	r0, [r0, #0]
@   0x0802e112: 2190        movs	r1, #144	@ 0x90
@   0x0802e114: 0049        lsls	r1, r1, #1
@   0x0802e116: 1840        adds	r0, r0, r1
@   0x0802e118: 6801        ldr	r1, [r0, #0]
@   0x0802e11a: 0090        lsls	r0, r2, #2
@   0x0802e11c: 1840        adds	r0, r0, r1
@   0x0802e11e: 6800        ldr	r0, [r0, #0]
@   0x0802e120: 4298        cmp	r0, r3
@   0x0802e122: d107        bne.n	0x2e134
@   0x0802e124: 1c10        adds	r0, r2, #0
@   0x0802e126: f001        fc63 	bl	0x2f9f0
@   0x0802e12a: 2001        movs	r0, #1
@   0x0802e12c: e003        b.n	0x2e136
@   0x0802e12e: 0000        movs	r0, r0
@   0x0802e130: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e132: 0300        lsls	r0, r0, #12
@   0x0802e134: 2000        movs	r0, #0
@   0x0802e136: bc02        pop	{r1}
@   0x0802e138: 4708        bx	r1

        thumb_func_start sub_0802E100
sub_0802E100: @ 0x0802e100
        .incbin "frog_us_baserom.gba", 0x2e100, 0x3c
        thumb_func_end sub_0802E100
