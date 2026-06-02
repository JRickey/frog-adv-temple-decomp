@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b954, 0x0801b9e4)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b954 --end 0x801b9e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b954: b510        push	{r4, lr}
@   0x0801b956: 0600        lsls	r0, r0, #24
@   0x0801b958: 0e00        lsrs	r0, r0, #24
@   0x0801b95a: 4917        ldr	r1, [pc, #92]	@ (0x1b9b8)
@   0x0801b95c: 23f0        movs	r3, #240	@ 0xf0
@   0x0801b95e: 800b        strh	r3, [r1, #0]
@   0x0801b960: 4a16        ldr	r2, [pc, #88]	@ (0x1b9bc)
@   0x0801b962: 4c17        ldr	r4, [pc, #92]	@ (0x1b9c0)
@   0x0801b964: 1c21        adds	r1, r4, #0
@   0x0801b966: 8011        strh	r1, [r2, #0]
@   0x0801b968: 4916        ldr	r1, [pc, #88]	@ (0x1b9c4)
@   0x0801b96a: 800b        strh	r3, [r1, #0]
@   0x0801b96c: 3202        adds	r2, #2
@   0x0801b96e: 2130        movs	r1, #48	@ 0x30
@   0x0801b970: 8011        strh	r1, [r2, #0]
@   0x0801b972: 3202        adds	r2, #2
@   0x0801b974: 4b14        ldr	r3, [pc, #80]	@ (0x1b9c8)
@   0x0801b976: 1c19        adds	r1, r3, #0
@   0x0801b978: 8011        strh	r1, [r2, #0]
@   0x0801b97a: 4b14        ldr	r3, [pc, #80]	@ (0x1b9cc)
@   0x0801b97c: 4c14        ldr	r4, [pc, #80]	@ (0x1b9d0)
@   0x0801b97e: 1c21        adds	r1, r4, #0
@   0x0801b980: 8019        strh	r1, [r3, #0]
@   0x0801b982: 8819        ldrh	r1, [r3, #0]
@   0x0801b984: 2208        movs	r2, #8
@   0x0801b986: 4051        eors	r1, r2
@   0x0801b988: 8019        strh	r1, [r3, #0]
@   0x0801b98a: 4a12        ldr	r2, [pc, #72]	@ (0x1b9d4)
@   0x0801b98c: 4b12        ldr	r3, [pc, #72]	@ (0x1b9d8)
@   0x0801b98e: 1c19        adds	r1, r3, #0
@   0x0801b990: 8011        strh	r1, [r2, #0]
@   0x0801b992: 4a12        ldr	r2, [pc, #72]	@ (0x1b9dc)
@   0x0801b994: 2400        movs	r4, #0
@   0x0801b996: 2100        movs	r1, #0
@   0x0801b998: 8191        strh	r1, [r2, #12]
@   0x0801b99a: 81d1        strh	r1, [r2, #14]
@   0x0801b99c: f7ff        fcea 	bl	0x1b374
@   0x0801b9a0: 480f        ldr	r0, [pc, #60]	@ (0x1b9e0)
@   0x0801b9a2: 7044        strb	r4, [r0, #1]
@   0x0801b9a4: 7304        strb	r4, [r0, #12]
@   0x0801b9a6: f005        f901 	bl	0x20bac
@   0x0801b9aa: 2010        movs	r0, #16
@   0x0801b9ac: f005        f8ec 	bl	0x20b88
@   0x0801b9b0: bc10        pop	{r4}
@   0x0801b9b2: bc01        pop	{r0}
@   0x0801b9b4: 4700        bx	r0
@   0x0801b9b6: 0000        movs	r0, r0
@   0x0801b9b8: 0040        lsls	r0, r0, #1
@   0x0801b9ba: 0400        lsls	r0, r0, #16
@   0x0801b9bc: 0044        lsls	r4, r0, #1
@   0x0801b9be: 0400        lsls	r0, r0, #16
@   0x0801b9c0: 70a0        strb	r0, [r4, #2]
@   0x0801b9c2: 0000        movs	r0, r0
@   0x0801b9c4: 0042        lsls	r2, r0, #1
@   0x0801b9c6: 0400        lsls	r0, r0, #16
@   0x0801b9c8: 0808        lsrs	r0, r1, #32
@   0x0801b9ca: 0000        movs	r0, r0
@   0x0801b9cc: 004a        lsls	r2, r1, #1
@   0x0801b9ce: 0400        lsls	r0, r0, #16
@   0x0801b9d0: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801b9d2: 0000        movs	r0, r0
@   0x0801b9d4: 000e        movs	r6, r1
@   0x0801b9d6: 0400        lsls	r0, r0, #16
@   0x0801b9d8: 1f08        subs	r0, r1, #4
@   0x0801b9da: 0000        movs	r0, r0
@   0x0801b9dc: 3550        adds	r5, #80	@ 0x50
@   0x0801b9de: 0300        lsls	r0, r0, #12
@   0x0801b9e0: 3540        adds	r5, #64	@ 0x40
@   0x0801b9e2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801B954
sub_0801B954: @ 0x0801b954
        .incbin "frog_us_baserom.gba", 0x1b954, 0x90
        thumb_func_end sub_0801B954
