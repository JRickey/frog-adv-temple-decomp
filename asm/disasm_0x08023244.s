@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023244, 0x080232cc)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023244 --end 0x80232cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023244: b530        push	{r4, r5, lr}
@   0x08023246: 2400        movs	r4, #0
@   0x08023248: 4d1f        ldr	r5, [pc, #124]	@ (0x232c8)
@   0x0802324a: 00a0        lsls	r0, r4, #2
@   0x0802324c: 1940        adds	r0, r0, r5
@   0x0802324e: 6800        ldr	r0, [r0, #0]
@   0x08023250: 1c21        adds	r1, r4, #0
@   0x08023252: 310c        adds	r1, #12
@   0x08023254: f7fe        fbb2 	bl	0x219bc
@   0x08023258: 1c60        adds	r0, r4, #1
@   0x0802325a: 0600        lsls	r0, r0, #24
@   0x0802325c: 0e04        lsrs	r4, r0, #24
@   0x0802325e: 2c0d        cmp	r4, #13
@   0x08023260: d9f3        bls.n	0x2324a
@   0x08023262: 200c        movs	r0, #12
@   0x08023264: 210e        movs	r1, #14
@   0x08023266: f7fd        febd 	bl	0x20fe4
@   0x0802326a: 200c        movs	r0, #12
@   0x0802326c: 210e        movs	r1, #14
@   0x0802326e: f7e2        fd4f 	bl	0x5d10
@   0x08023272: 200f        movs	r0, #15
@   0x08023274: 2111        movs	r1, #17
@   0x08023276: f7fd        feb5 	bl	0x20fe4
@   0x0802327a: 200f        movs	r0, #15
@   0x0802327c: 2111        movs	r1, #17
@   0x0802327e: f7e2        fd47 	bl	0x5d10
@   0x08023282: 2012        movs	r0, #18
@   0x08023284: 2112        movs	r1, #18
@   0x08023286: f7fd        fead 	bl	0x20fe4
@   0x0802328a: 2012        movs	r0, #18
@   0x0802328c: 2112        movs	r1, #18
@   0x0802328e: f7e2        fd3f 	bl	0x5d10
@   0x08023292: 2013        movs	r0, #19
@   0x08023294: 2116        movs	r1, #22
@   0x08023296: f7fd        fea5 	bl	0x20fe4
@   0x0802329a: 2013        movs	r0, #19
@   0x0802329c: 2116        movs	r1, #22
@   0x0802329e: f7e2        fd37 	bl	0x5d10
@   0x080232a2: 2017        movs	r0, #23
@   0x080232a4: 2118        movs	r1, #24
@   0x080232a6: f7fd        fe9d 	bl	0x20fe4
@   0x080232aa: 2017        movs	r0, #23
@   0x080232ac: 2118        movs	r1, #24
@   0x080232ae: f7e2        fd2f 	bl	0x5d10
@   0x080232b2: 2019        movs	r0, #25
@   0x080232b4: 2119        movs	r1, #25
@   0x080232b6: f7fd        fe95 	bl	0x20fe4
@   0x080232ba: 2019        movs	r0, #25
@   0x080232bc: 2119        movs	r1, #25
@   0x080232be: f7e2        fd27 	bl	0x5d10
@   0x080232c2: bc30        pop	{r4, r5}
@   0x080232c4: bc01        pop	{r0}
@   0x080232c6: 4700        bx	r0
@   0x080232c8: 16b8        asrs	r0, r7, #26
@   0x080232ca: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08023244
sub_08023244: @ 0x08023244
        .incbin "frog_us_baserom.gba", 0x23244, 0x88
        thumb_func_end sub_08023244
