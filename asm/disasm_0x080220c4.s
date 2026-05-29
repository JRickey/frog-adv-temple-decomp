@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080220c4, 0x08022160)  (156 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80220c4 --end 0x8022160 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080220c4: b570        push	{r4, r5, r6, lr}
@   0x080220c6: b084        sub	sp, #16
@   0x080220c8: 2400        movs	r4, #0
@   0x080220ca: 4e24        ldr	r6, [pc, #144]	@ (0x2215c)
@   0x080220cc: 2502        movs	r5, #2
@   0x080220ce: 1c20        adds	r0, r4, #0
@   0x080220d0: 3027        adds	r0, #39	@ 0x27
@   0x080220d2: 00a1        lsls	r1, r4, #2
@   0x080220d4: 1989        adds	r1, r1, r6
@   0x080220d6: 6809        ldr	r1, [r1, #0]
@   0x080220d8: 2281        movs	r2, #129	@ 0x81
@   0x080220da: 9200        str	r2, [sp, #0]
@   0x080220dc: 2203        movs	r2, #3
@   0x080220de: 9201        str	r2, [sp, #4]
@   0x080220e0: 9502        str	r5, [sp, #8]
@   0x080220e2: 9503        str	r5, [sp, #12]
@   0x080220e4: 2210        movs	r2, #16
@   0x080220e6: 2309        movs	r3, #9
@   0x080220e8: f7fe        ffda 	bl	0x210a0
@   0x080220ec: 1c60        adds	r0, r4, #1
@   0x080220ee: 0600        lsls	r0, r0, #24
@   0x080220f0: 0e04        lsrs	r4, r0, #24
@   0x080220f2: 2c02        cmp	r4, #2
@   0x080220f4: d9eb        bls.n	0x220ce
@   0x080220f6: 2403        movs	r4, #3
@   0x080220f8: 4e18        ldr	r6, [pc, #96]	@ (0x2215c)
@   0x080220fa: 2502        movs	r5, #2
@   0x080220fc: 1c20        adds	r0, r4, #0
@   0x080220fe: 3027        adds	r0, #39	@ 0x27
@   0x08022100: 00a1        lsls	r1, r4, #2
@   0x08022102: 1989        adds	r1, r1, r6
@   0x08022104: 6809        ldr	r1, [r1, #0]
@   0x08022106: 22a1        movs	r2, #161	@ 0xa1
@   0x08022108: 9200        str	r2, [sp, #0]
@   0x0802210a: 2203        movs	r2, #3
@   0x0802210c: 9201        str	r2, [sp, #4]
@   0x0802210e: 9502        str	r5, [sp, #8]
@   0x08022110: 9503        str	r5, [sp, #12]
@   0x08022112: 2210        movs	r2, #16
@   0x08022114: 2309        movs	r3, #9
@   0x08022116: f7fe        ffc3 	bl	0x210a0
@   0x0802211a: 1c60        adds	r0, r4, #1
@   0x0802211c: 0600        lsls	r0, r0, #24
@   0x0802211e: 0e04        lsrs	r4, r0, #24
@   0x08022120: 2c05        cmp	r4, #5
@   0x08022122: d9eb        bls.n	0x220fc
@   0x08022124: 2406        movs	r4, #6
@   0x08022126: 4e0d        ldr	r6, [pc, #52]	@ (0x2215c)
@   0x08022128: 2502        movs	r5, #2
@   0x0802212a: 1c20        adds	r0, r4, #0
@   0x0802212c: 3027        adds	r0, #39	@ 0x27
@   0x0802212e: 00a1        lsls	r1, r4, #2
@   0x08022130: 1989        adds	r1, r1, r6
@   0x08022132: 6809        ldr	r1, [r1, #0]
@   0x08022134: 22c1        movs	r2, #193	@ 0xc1
@   0x08022136: 9200        str	r2, [sp, #0]
@   0x08022138: 220a        movs	r2, #10
@   0x0802213a: 9201        str	r2, [sp, #4]
@   0x0802213c: 9502        str	r5, [sp, #8]
@   0x0802213e: 9503        str	r5, [sp, #12]
@   0x08022140: 2210        movs	r2, #16
@   0x08022142: 230a        movs	r3, #10
@   0x08022144: f7fe        ffac 	bl	0x210a0
@   0x08022148: 1c60        adds	r0, r4, #1
@   0x0802214a: 0600        lsls	r0, r0, #24
@   0x0802214c: 0e04        lsrs	r4, r0, #24
@   0x0802214e: 2c07        cmp	r4, #7
@   0x08022150: d9eb        bls.n	0x2212a
@   0x08022152: b004        add	sp, #16
@   0x08022154: bc70        pop	{r4, r5, r6}
@   0x08022156: bc01        pop	{r0}
@   0x08022158: 4700        bx	r0
@   0x0802215a: 0000        movs	r0, r0
@   0x0802215c: 12a8        asrs	r0, r5, #10
@   0x0802215e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080220C4
sub_080220C4: @ 0x080220c4
        .incbin "frog_us_baserom.gba", 0x220c4, 0x9c
        thumb_func_end sub_080220C4
