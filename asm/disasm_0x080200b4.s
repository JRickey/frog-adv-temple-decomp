@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080200b4, 0x080201a8)  (244 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80200b4 --end 0x80201a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080200b4: b500        push	{lr}
@   0x080200b6: b081        sub	sp, #4
@   0x080200b8: 490e        ldr	r1, [pc, #56]	@ (0x200f4)
@   0x080200ba: 9800        ldr	r0, [sp, #0]
@   0x080200bc: 4008        ands	r0, r1
@   0x080200be: 2108        movs	r1, #8
@   0x080200c0: 4308        orrs	r0, r1
@   0x080200c2: 490d        ldr	r1, [pc, #52]	@ (0x200f8)
@   0x080200c4: 4008        ands	r0, r1
@   0x080200c6: 21c0        movs	r1, #192	@ 0xc0
@   0x080200c8: 0089        lsls	r1, r1, #2
@   0x080200ca: 4308        orrs	r0, r1
@   0x080200cc: 490b        ldr	r1, [pc, #44]	@ (0x200fc)
@   0x080200ce: 4008        ands	r0, r1
@   0x080200d0: 21c0        movs	r1, #192	@ 0xc0
@   0x080200d2: 0489        lsls	r1, r1, #18
@   0x080200d4: 4308        orrs	r0, r1
@   0x080200d6: 490a        ldr	r1, [pc, #40]	@ (0x20100)
@   0x080200d8: 4008        ands	r0, r1
@   0x080200da: 21e0        movs	r1, #224	@ 0xe0
@   0x080200dc: 0309        lsls	r1, r1, #12
@   0x080200de: 4308        orrs	r0, r1
@   0x080200e0: 9000        str	r0, [sp, #0]
@   0x080200e2: 4808        ldr	r0, [pc, #32]	@ (0x20104)
@   0x080200e4: 7d00        ldrb	r0, [r0, #20]
@   0x080200e6: 2804        cmp	r0, #4
@   0x080200e8: d841        bhi.n	0x2016e
@   0x080200ea: 0080        lsls	r0, r0, #2
@   0x080200ec: 4906        ldr	r1, [pc, #24]	@ (0x20108)
@   0x080200ee: 1840        adds	r0, r0, r1
@   0x080200f0: 6800        ldr	r0, [r0, #0]
@   0x080200f2: 4687        mov	pc, r0
@   0x080200f4: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080200f8: 00ff        lsls	r7, r7, #3
@   0x080200fa: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x080200fe: 00ff        lsls	r7, r7, #3
@   0x08020100: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08020104: 3480        adds	r4, #128	@ 0x80
@   0x08020106: 0300        lsls	r0, r0, #12
@   0x08020108: 010c        lsls	r4, r1, #4
@   0x0802010a: 0802        lsrs	r2, r0, #32
@   0x0802010c: 0120        lsls	r0, r4, #4
@   0x0802010e: 0802        lsrs	r2, r0, #32
@   0x08020110: 0130        lsls	r0, r6, #4
@   0x08020112: 0802        lsrs	r2, r0, #32
@   0x08020114: 0140        lsls	r0, r0, #5
@   0x08020116: 0802        lsrs	r2, r0, #32
@   0x08020118: 0150        lsls	r0, r2, #5
@   0x0802011a: 0802        lsrs	r2, r0, #32
@   0x0802011c: 0160        lsls	r0, r4, #5
@   0x0802011e: 0802        lsrs	r2, r0, #32
@   0x08020120: 4802        ldr	r0, [pc, #8]	@ (0x2012c)
@   0x08020122: 9900        ldr	r1, [sp, #0]
@   0x08020124: 4001        ands	r1, r0
@   0x08020126: 20c0        movs	r0, #192	@ 0xc0
@   0x08020128: 0080        lsls	r0, r0, #2
@   0x0802012a: e01e        b.n	0x2016a
@   0x0802012c: 00ff        lsls	r7, r7, #3
@   0x0802012e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x08020132: 9900        ldr	r1, [sp, #0]
@   0x08020134: 4001        ands	r1, r0
@   0x08020136: 20c0        movs	r0, #192	@ 0xc0
@   0x08020138: 00c0        lsls	r0, r0, #3
@   0x0802013a: e016        b.n	0x2016a
@   0x0802013c: 00ff        lsls	r7, r7, #3
@   0x0802013e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x08020142: 9900        ldr	r1, [sp, #0]
@   0x08020144: 4001        ands	r1, r0
@   0x08020146: 2090        movs	r0, #144	@ 0x90
@   0x08020148: 0100        lsls	r0, r0, #4
@   0x0802014a: e00e        b.n	0x2016a
@   0x0802014c: 00ff        lsls	r7, r7, #3
@   0x0802014e: ffff        4802 	vtbl.8	d20, {d15}, d2
@   0x08020152: 9900        ldr	r1, [sp, #0]
@   0x08020154: 4001        ands	r1, r0
@   0x08020156: 20c0        movs	r0, #192	@ 0xc0
@   0x08020158: 0100        lsls	r0, r0, #4
@   0x0802015a: e006        b.n	0x2016a
@   0x0802015c: 00ff        lsls	r7, r7, #3
@   0x0802015e: ffff        480b 	vtbl.8	d20, {d15}, d11
@   0x08020162: 9900        ldr	r1, [sp, #0]
@   0x08020164: 4001        ands	r1, r0
@   0x08020166: 20f0        movs	r0, #240	@ 0xf0
@   0x08020168: 0100        lsls	r0, r0, #4
@   0x0802016a: 4301        orrs	r1, r0
@   0x0802016c: 9100        str	r1, [sp, #0]
@   0x0802016e: 4909        ldr	r1, [pc, #36]	@ (0x20194)
@   0x08020170: 4809        ldr	r0, [pc, #36]	@ (0x20198)
@   0x08020172: 6008        str	r0, [r1, #0]
@   0x08020174: 4809        ldr	r0, [pc, #36]	@ (0x2019c)
@   0x08020176: 6048        str	r0, [r1, #4]
@   0x08020178: 4809        ldr	r0, [pc, #36]	@ (0x201a0)
@   0x0802017a: 6088        str	r0, [r1, #8]
@   0x0802017c: 6888        ldr	r0, [r1, #8]
@   0x0802017e: 4909        ldr	r1, [pc, #36]	@ (0x201a4)
@   0x08020180: 4668        mov	r0, sp
@   0x08020182: 2202        movs	r2, #2
@   0x08020184: f7f9        fab2 	bl	0x196ec
@   0x08020188: b001        add	sp, #4
@   0x0802018a: bc01        pop	{r0}
@   0x0802018c: 4700        bx	r0
@   0x0802018e: 0000        movs	r0, r0
@   0x08020190: 00ff        lsls	r7, r7, #3
@   0x08020192: ffff        00d4 	vshr.u64	q8, q2, #1
@   0x08020196: 0400        lsls	r0, r0, #16
@   0x08020198: 4c18        ldr	r4, [pc, #96]	@ (0x201fc)
@   0x0802019a: 081e        lsrs	r6, r3, #32
@   0x0802019c: f000        0600 	and.w	r6, r0, #0
@   0x080201a0: 0400        lsls	r0, r0, #16
@   0x080201a2: 8000        strh	r0, [r0, #0]
@   0x080201a4: 5418        strb	r0, [r3, r0]
@   0x080201a6: 081e        lsrs	r6, r3, #32

        thumb_func_start sub_080200B4
sub_080200B4: @ 0x080200b4
        .incbin "frog_us_baserom.gba", 0x200b4, 0xf4
        thumb_func_end sub_080200B4
