@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080338a8, 0x080338ec)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80338a8 --end 0x80338ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080338a8: 0400        lsls	r0, r0, #16
@   0x080338aa: 0c00        lsrs	r0, r0, #16
@   0x080338ac: 2200        movs	r2, #0
@   0x080338ae: 2804        cmp	r0, #4
@   0x080338b0: d108        bne.n	0x338c4
@   0x080338b2: 4902        ldr	r1, [pc, #8]	@ (0x338bc)
@   0x080338b4: 4802        ldr	r0, [pc, #8]	@ (0x338c0)
@   0x080338b6: 6008        str	r0, [r1, #0]
@   0x080338b8: e012        b.n	0x338e0
@   0x080338ba: 0000        movs	r0, r0
@   0x080338bc: 65e4        str	r4, [r4, #92]	@ 0x5c
@   0x080338be: 0300        lsls	r0, r0, #12
@   0x080338c0: 8e98        ldrh	r0, [r3, #52]	@ 0x34
@   0x080338c2: 082f        lsrs	r7, r5, #32
@   0x080338c4: 2840        cmp	r0, #64	@ 0x40
@   0x080338c6: d107        bne.n	0x338d8
@   0x080338c8: 4901        ldr	r1, [pc, #4]	@ (0x338d0)
@   0x080338ca: 4802        ldr	r0, [pc, #8]	@ (0x338d4)
@   0x080338cc: 6008        str	r0, [r1, #0]
@   0x080338ce: e007        b.n	0x338e0
@   0x080338d0: 65e4        str	r4, [r4, #92]	@ 0x5c
@   0x080338d2: 0300        lsls	r0, r0, #12
@   0x080338d4: 8ea4        ldrh	r4, [r4, #52]	@ 0x34
@   0x080338d6: 082f        lsrs	r7, r5, #32
@   0x080338d8: 4902        ldr	r1, [pc, #8]	@ (0x338e4)
@   0x080338da: 4803        ldr	r0, [pc, #12]	@ (0x338e8)
@   0x080338dc: 6008        str	r0, [r1, #0]
@   0x080338de: 2201        movs	r2, #1
@   0x080338e0: 1c10        adds	r0, r2, #0
@   0x080338e2: 4770        bx	lr
@   0x080338e4: 65e4        str	r4, [r4, #92]	@ 0x5c
@   0x080338e6: 0300        lsls	r0, r0, #12
@   0x080338e8: 8e98        ldrh	r0, [r3, #52]	@ 0x34
@   0x080338ea: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_080338A8
sub_080338A8: @ 0x080338a8
        .incbin "frog_us_baserom.gba", 0x338a8, 0x44
        thumb_func_end sub_080338A8
