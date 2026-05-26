@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e600, 0x0800e6a8)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e600 --end 0x800e6a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e600: b510        push	{r4, lr}
@   0x0800e602: 0600        lsls	r0, r0, #24
@   0x0800e604: 0e00        lsrs	r0, r0, #24
@   0x0800e606: 4a1c        ldr	r2, [pc, #112]	@ (0xe678)
@   0x0800e608: 21f0        movs	r1, #240	@ 0xf0
@   0x0800e60a: 8011        strh	r1, [r2, #0]
@   0x0800e60c: 3204        adds	r2, #4
@   0x0800e60e: 4b1b        ldr	r3, [pc, #108]	@ (0xe67c)
@   0x0800e610: 1c19        adds	r1, r3, #0
@   0x0800e612: 8011        strh	r1, [r2, #0]
@   0x0800e614: 3204        adds	r2, #4
@   0x0800e616: 4b1a        ldr	r3, [pc, #104]	@ (0xe680)
@   0x0800e618: 1c19        adds	r1, r3, #0
@   0x0800e61a: 8011        strh	r1, [r2, #0]
@   0x0800e61c: 3202        adds	r2, #2
@   0x0800e61e: 4b19        ldr	r3, [pc, #100]	@ (0xe684)
@   0x0800e620: 1c19        adds	r1, r3, #0
@   0x0800e622: 8011        strh	r1, [r2, #0]
@   0x0800e624: 4b18        ldr	r3, [pc, #96]	@ (0xe688)
@   0x0800e626: 4919        ldr	r1, [pc, #100]	@ (0xe68c)
@   0x0800e628: 6159        str	r1, [r3, #20]
@   0x0800e62a: 3180        adds	r1, #128	@ 0x80
@   0x0800e62c: 6259        str	r1, [r3, #36]	@ 0x24
@   0x0800e62e: 4c18        ldr	r4, [pc, #96]	@ (0xe690)
@   0x0800e630: 4918        ldr	r1, [pc, #96]	@ (0xe694)
@   0x0800e632: 680a        ldr	r2, [r1, #0]
@   0x0800e634: 0051        lsls	r1, r2, #1
@   0x0800e636: 1889        adds	r1, r1, r2
@   0x0800e638: 00c9        lsls	r1, r1, #3
@   0x0800e63a: 1909        adds	r1, r1, r4
@   0x0800e63c: 680a        ldr	r2, [r1, #0]
@   0x0800e63e: 0081        lsls	r1, r0, #2
@   0x0800e640: 1889        adds	r1, r1, r2
@   0x0800e642: 6809        ldr	r1, [r1, #0]
@   0x0800e644: 60d9        str	r1, [r3, #12]
@   0x0800e646: 2100        movs	r1, #0
@   0x0800e648: 2200        movs	r2, #0
@   0x0800e64a: 7219        strb	r1, [r3, #8]
@   0x0800e64c: 8598        strh	r0, [r3, #44]	@ 0x2c
@   0x0800e64e: 4912        ldr	r1, [pc, #72]	@ (0xe698)
@   0x0800e650: 4812        ldr	r0, [pc, #72]	@ (0xe69c)
@   0x0800e652: 6008        str	r0, [r1, #0]
@   0x0800e654: 4812        ldr	r0, [pc, #72]	@ (0xe6a0)
@   0x0800e656: 6048        str	r0, [r1, #4]
@   0x0800e658: 4812        ldr	r0, [pc, #72]	@ (0xe6a4)
@   0x0800e65a: 6088        str	r0, [r1, #8]
@   0x0800e65c: 6888        ldr	r0, [r1, #8]
@   0x0800e65e: 861a        strh	r2, [r3, #48]	@ 0x30
@   0x0800e660: 865a        strh	r2, [r3, #50]	@ 0x32
@   0x0800e662: 2008        movs	r0, #8
@   0x0800e664: 72d8        strb	r0, [r3, #11]
@   0x0800e666: 39d4        subs	r1, #212	@ 0xd4
@   0x0800e668: 22ed        movs	r2, #237	@ 0xed
@   0x0800e66a: 0192        lsls	r2, r2, #6
@   0x0800e66c: 1c10        adds	r0, r2, #0
@   0x0800e66e: 8008        strh	r0, [r1, #0]
@   0x0800e670: bc10        pop	{r4}
@   0x0800e672: bc01        pop	{r0}
@   0x0800e674: 4700        bx	r0
@   0x0800e676: 0000        movs	r0, r0
@   0x0800e678: 0040        lsls	r0, r0, #1
@   0x0800e67a: 0400        lsls	r0, r0, #16
@   0x0800e67c: 70a0        strb	r0, [r4, #2]
@   0x0800e67e: 0000        movs	r0, r0
@   0x0800e680: 0808        lsrs	r0, r1, #32
@   0x0800e682: 0000        movs	r0, r0
@   0x0800e684: 3f3f        subs	r7, #63	@ 0x3f
@   0x0800e686: 0000        movs	r0, r0
@   0x0800e688: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0800e68a: 0300        lsls	r0, r0, #12
@   0x0800e68c: fbc2        0600 	smlal	r0, r6, r2, r0
@   0x0800e690: 1254        asrs	r4, r2, #9
@   0x0800e692: 080c        lsrs	r4, r1, #32
@   0x0800e694: 34b0        adds	r4, #176	@ 0xb0
@   0x0800e696: 0300        lsls	r0, r0, #12
@   0x0800e698: 00d4        lsls	r4, r2, #3
@   0x0800e69a: 0400        lsls	r0, r0, #16
@   0x0800e69c: 38b0        subs	r0, #176	@ 0xb0
@   0x0800e69e: 080e        lsrs	r6, r1, #32
@   0x0800e6a0: fb80        0600 	smull	r0, r6, r0, r0
@   0x0800e6a4: 00c0        lsls	r0, r0, #3
@   0x0800e6a6: 8000        strh	r0, [r0, #0]

        thumb_func_start sub_0800E600
sub_0800E600: @ 0x0800e600
        .incbin "frog_us_baserom.gba", 0xe600, 0xa8
        thumb_func_end sub_0800E600
