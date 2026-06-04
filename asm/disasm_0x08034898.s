@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034898, 0x08034900)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034898 --end 0x8034900 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034898: b500        push	{lr}
@   0x0803489a: b085        sub	sp, #20
@   0x0803489c: 9004        str	r0, [sp, #16]
@   0x0803489e: a804        add	r0, sp, #16
@   0x080348a0: 4669        mov	r1, sp
@   0x080348a2: f7ff        fc17 	bl	0x340d4
@   0x080348a6: 2100        movs	r1, #0
@   0x080348a8: 9800        ldr	r0, [sp, #0]
@   0x080348aa: 2802        cmp	r0, #2
@   0x080348ac: d100        bne.n	0x348b0
@   0x080348ae: 2101        movs	r1, #1
@   0x080348b0: 2900        cmp	r1, #0
@   0x080348b2: d116        bne.n	0x348e2
@   0x080348b4: 2100        movs	r1, #0
@   0x080348b6: 2801        cmp	r0, #1
@   0x080348b8: d800        bhi.n	0x348bc
@   0x080348ba: 2101        movs	r1, #1
@   0x080348bc: 2900        cmp	r1, #0
@   0x080348be: d110        bne.n	0x348e2
@   0x080348c0: 2100        movs	r1, #0
@   0x080348c2: 2804        cmp	r0, #4
@   0x080348c4: d100        bne.n	0x348c8
@   0x080348c6: 2101        movs	r1, #1
@   0x080348c8: 2900        cmp	r1, #0
@   0x080348ca: d007        beq.n	0x348dc
@   0x080348cc: 9801        ldr	r0, [sp, #4]
@   0x080348ce: 4902        ldr	r1, [pc, #8]	@ (0x348d8)
@   0x080348d0: 2800        cmp	r0, #0
@   0x080348d2: d012        beq.n	0x348fa
@   0x080348d4: 3101        adds	r1, #1
@   0x080348d6: e010        b.n	0x348fa
@   0x080348d8: ffff        7fff 			@ <UNDEFINED> instruction: 0xffff7fff
@   0x080348dc: 9902        ldr	r1, [sp, #8]
@   0x080348de: 2900        cmp	r1, #0
@   0x080348e0: da01        bge.n	0x348e6
@   0x080348e2: 2000        movs	r0, #0
@   0x080348e4: e00a        b.n	0x348fc
@   0x080348e6: 291e        cmp	r1, #30
@   0x080348e8: dcf0        bgt.n	0x348cc
@   0x080348ea: 201e        movs	r0, #30
@   0x080348ec: 1a40        subs	r0, r0, r1
@   0x080348ee: 9903        ldr	r1, [sp, #12]
@   0x080348f0: 40c1        lsrs	r1, r0
@   0x080348f2: 9801        ldr	r0, [sp, #4]
@   0x080348f4: 2800        cmp	r0, #0
@   0x080348f6: d000        beq.n	0x348fa
@   0x080348f8: 4249        negs	r1, r1
@   0x080348fa: 1c08        adds	r0, r1, #0
@   0x080348fc: b005        add	sp, #20
@   0x080348fe: bd00        pop	{pc}

        thumb_func_start sub_08034898
sub_08034898: @ 0x08034898
        .incbin "frog_us_baserom.gba", 0x34898, 0x68
        thumb_func_end sub_08034898
