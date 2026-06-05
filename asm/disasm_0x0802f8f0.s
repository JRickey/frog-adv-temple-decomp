@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f8f0, 0x0802f930)  (64 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f8f0 --end 0x802f930 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f8f0: 1c02        adds	r2, r0, #0
@   0x0802f8f2: 2a03        cmp	r2, #3
@   0x0802f8f4: dc0c        bgt.n	0x2f910
@   0x0802f8f6: 4805        ldr	r0, [pc, #20]	@ (0x2f90c)
@   0x0802f8f8: 6801        ldr	r1, [r0, #0]
@   0x0802f8fa: 0090        lsls	r0, r2, #2
@   0x0802f8fc: 3110        adds	r1, #16
@   0x0802f8fe: 1809        adds	r1, r1, r0
@   0x0802f900: 6808        ldr	r0, [r1, #0]
@   0x0802f902: 22b0        movs	r2, #176	@ 0xb0
@   0x0802f904: 0092        lsls	r2, r2, #2
@   0x0802f906: 4310        orrs	r0, r2
@   0x0802f908: 6008        str	r0, [r1, #0]
@   0x0802f90a: e00d        b.n	0x2f928
@   0x0802f90c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f90e: 0300        lsls	r0, r0, #12
@   0x0802f910: 3a04        subs	r2, #4
@   0x0802f912: 4806        ldr	r0, [pc, #24]	@ (0x2f92c)
@   0x0802f914: 6800        ldr	r0, [r0, #0]
@   0x0802f916: 30c8        adds	r0, #200	@ 0xc8
@   0x0802f918: 6800        ldr	r0, [r0, #0]
@   0x0802f91a: 0191        lsls	r1, r2, #6
@   0x0802f91c: 1809        adds	r1, r1, r0
@   0x0802f91e: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0802f920: 2280        movs	r2, #128	@ 0x80
@   0x0802f922: 0092        lsls	r2, r2, #2
@   0x0802f924: 4310        orrs	r0, r2
@   0x0802f926: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0802f928: 4770        bx	lr
@   0x0802f92a: 0000        movs	r0, r0
@   0x0802f92c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f92e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802F8F0
sub_0802F8F0: @ 0x0802f8f0
        .incbin "frog_us_baserom.gba", 0x2f8f0, 0x40
        thumb_func_end sub_0802F8F0
