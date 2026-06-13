@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028600, 0x08028684)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028600 --end 0x8028684 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028600: b570        push	{r4, r5, r6, lr}
@   0x08028602: b084        sub	sp, #16
@   0x08028604: 2600        movs	r6, #0
@   0x08028606: 1c35        adds	r5, r6, #0
@   0x08028608: 3546        adds	r5, #70	@ 0x46
@   0x0802860a: 4918        ldr	r1, [pc, #96]	@ (0x2866c)
@   0x0802860c: 00b0        lsls	r0, r6, #2
@   0x0802860e: 1840        adds	r0, r0, r1
@   0x08028610: 6804        ldr	r4, [r0, #0]
@   0x08028612: 1c30        adds	r0, r6, #0
@   0x08028614: 2105        movs	r1, #5
@   0x08028616: f00b        fca1 	bl	0x33f5c
@   0x0802861a: 0600        lsls	r0, r0, #24
@   0x0802861c: 0900        lsrs	r0, r0, #4
@   0x0802861e: 4914        ldr	r1, [pc, #80]	@ (0x28670)
@   0x08028620: 1840        adds	r0, r0, r1
@   0x08028622: 0c00        lsrs	r0, r0, #16
@   0x08028624: 9000        str	r0, [sp, #0]
@   0x08028626: 2007        movs	r0, #7
@   0x08028628: 9001        str	r0, [sp, #4]
@   0x0802862a: 2003        movs	r0, #3
@   0x0802862c: 9002        str	r0, [sp, #8]
@   0x0802862e: 9003        str	r0, [sp, #12]
@   0x08028630: 1c28        adds	r0, r5, #0
@   0x08028632: 1c21        adds	r1, r4, #0
@   0x08028634: 2210        movs	r2, #16
@   0x08028636: 233a        movs	r3, #58	@ 0x3a
@   0x08028638: f7f8        fd32 	bl	0x210a0
@   0x0802863c: 1c70        adds	r0, r6, #1
@   0x0802863e: 0600        lsls	r0, r0, #24
@   0x08028640: 0e06        lsrs	r6, r0, #24
@   0x08028642: 2e05        cmp	r6, #5
@   0x08028644: d9df        bls.n	0x28606
@   0x08028646: 490b        ldr	r1, [pc, #44]	@ (0x28674)
@   0x08028648: 4a0b        ldr	r2, [pc, #44]	@ (0x28678)
@   0x0802864a: 1888        adds	r0, r1, r2
@   0x0802864c: 2202        movs	r2, #2
@   0x0802864e: 7002        strb	r2, [r0, #0]
@   0x08028650: 4b0a        ldr	r3, [pc, #40]	@ (0x2867c)
@   0x08028652: 18c8        adds	r0, r1, r3
@   0x08028654: 7002        strb	r2, [r0, #0]
@   0x08028656: 3338        adds	r3, #56	@ 0x38
@   0x08028658: 18c8        adds	r0, r1, r3
@   0x0802865a: 7002        strb	r2, [r0, #0]
@   0x0802865c: 4808        ldr	r0, [pc, #32]	@ (0x28680)
@   0x0802865e: 1809        adds	r1, r1, r0
@   0x08028660: 700a        strb	r2, [r1, #0]
@   0x08028662: b004        add	sp, #16
@   0x08028664: bc70        pop	{r4, r5, r6}
@   0x08028666: bc01        pop	{r0}
@   0x08028668: 4700        bx	r0
@   0x0802866a: 0000        movs	r0, r0
@   0x0802866c: 7a98        ldrb	r0, [r3, #10]
@   0x0802866e: 0831        lsrs	r1, r6, #32
@   0x08028670: 0000        movs	r0, r0
@   0x08028672: 0175        lsls	r5, r6, #5
@   0x08028674: 3720        adds	r7, #32
@   0x08028676: 0300        lsls	r0, r0, #12
@   0x08028678: 0f67        lsrs	r7, r4, #29
@   0x0802867a: 0000        movs	r0, r0
@   0x0802867c: 0f9f        lsrs	r7, r3, #30
@   0x0802867e: 0000        movs	r0, r0
@   0x08028680: 107f        asrs	r7, r7, #1

        thumb_func_start sub_08028600
sub_08028600: @ 0x08028600
        .incbin "baserom.gba", 0x28600, 0x84
        thumb_func_end sub_08028600
