@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080222bc, 0x08022360)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80222bc --end 0x8022360 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080222bc: b570        push	{r4, r5, r6, lr}
@   0x080222be: 464e        mov	r6, r9
@   0x080222c0: 4645        mov	r5, r8
@   0x080222c2: b460        push	{r5, r6}
@   0x080222c4: b084        sub	sp, #16
@   0x080222c6: 4921        ldr	r1, [pc, #132]	@ (0x2234c)
@   0x080222c8: 20d5        movs	r0, #213	@ 0xd5
@   0x080222ca: 4681        mov	r9, r0
@   0x080222cc: 9000        str	r0, [sp, #0]
@   0x080222ce: 2508        movs	r5, #8
@   0x080222d0: 9501        str	r5, [sp, #4]
@   0x080222d2: 2002        movs	r0, #2
@   0x080222d4: 4680        mov	r8, r0
@   0x080222d6: 9002        str	r0, [sp, #8]
@   0x080222d8: 9003        str	r0, [sp, #12]
@   0x080222da: 2031        movs	r0, #49	@ 0x31
@   0x080222dc: 2210        movs	r2, #16
@   0x080222de: 230d        movs	r3, #13
@   0x080222e0: f7fe        fede 	bl	0x210a0
@   0x080222e4: 491a        ldr	r1, [pc, #104]	@ (0x22350)
@   0x080222e6: 26e5        movs	r6, #229	@ 0xe5
@   0x080222e8: 9600        str	r6, [sp, #0]
@   0x080222ea: 9501        str	r5, [sp, #4]
@   0x080222ec: 2403        movs	r4, #3
@   0x080222ee: 9402        str	r4, [sp, #8]
@   0x080222f0: 9403        str	r4, [sp, #12]
@   0x080222f2: 2032        movs	r0, #50	@ 0x32
@   0x080222f4: 2210        movs	r2, #16
@   0x080222f6: 230d        movs	r3, #13
@   0x080222f8: f7fe        fed2 	bl	0x210a0
@   0x080222fc: 4915        ldr	r1, [pc, #84]	@ (0x22354)
@   0x080222fe: 4648        mov	r0, r9
@   0x08022300: 9000        str	r0, [sp, #0]
@   0x08022302: 9501        str	r5, [sp, #4]
@   0x08022304: 9402        str	r4, [sp, #8]
@   0x08022306: 9403        str	r4, [sp, #12]
@   0x08022308: 2033        movs	r0, #51	@ 0x33
@   0x0802230a: 2210        movs	r2, #16
@   0x0802230c: 230d        movs	r3, #13
@   0x0802230e: f7fe        fec7 	bl	0x210a0
@   0x08022312: 4911        ldr	r1, [pc, #68]	@ (0x22358)
@   0x08022314: 9600        str	r6, [sp, #0]
@   0x08022316: 9501        str	r5, [sp, #4]
@   0x08022318: 9402        str	r4, [sp, #8]
@   0x0802231a: 9403        str	r4, [sp, #12]
@   0x0802231c: 2034        movs	r0, #52	@ 0x34
@   0x0802231e: 2210        movs	r2, #16
@   0x08022320: 230d        movs	r3, #13
@   0x08022322: f7fe        febd 	bl	0x210a0
@   0x08022326: 490d        ldr	r1, [pc, #52]	@ (0x2235c)
@   0x08022328: 9600        str	r6, [sp, #0]
@   0x0802232a: 9501        str	r5, [sp, #4]
@   0x0802232c: 4640        mov	r0, r8
@   0x0802232e: 9002        str	r0, [sp, #8]
@   0x08022330: 9403        str	r4, [sp, #12]
@   0x08022332: 2035        movs	r0, #53	@ 0x35
@   0x08022334: 2210        movs	r2, #16
@   0x08022336: 230d        movs	r3, #13
@   0x08022338: f7fe        feb2 	bl	0x210a0
@   0x0802233c: b004        add	sp, #16
@   0x0802233e: bc18        pop	{r3, r4}
@   0x08022340: 4698        mov	r8, r3
@   0x08022342: 46a1        mov	r9, r4
@   0x08022344: bc70        pop	{r4, r5, r6}
@   0x08022346: bc01        pop	{r0}
@   0x08022348: 4700        bx	r0
@   0x0802234a: 0000        movs	r0, r0
@   0x0802234c: 0df4        lsrs	r4, r6, #23
@   0x0802234e: 0831        lsrs	r1, r6, #32
@   0x08022350: 0e14        lsrs	r4, r2, #24
@   0x08022352: 0831        lsrs	r1, r6, #32
@   0x08022354: 0e44        lsrs	r4, r0, #25
@   0x08022356: 0831        lsrs	r1, r6, #32
@   0x08022358: 0e74        lsrs	r4, r6, #25
@   0x0802235a: 0831        lsrs	r1, r6, #32
@   0x0802235c: 0e94        lsrs	r4, r2, #26
@   0x0802235e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080222BC
sub_080222BC: @ 0x080222bc
        .incbin "frog_us_baserom.gba", 0x222bc, 0xa4
        thumb_func_end sub_080222BC
