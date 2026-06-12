@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026944, 0x080269ac)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026944 --end 0x80269ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026944: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08026946: b084        sub	sp, #16
@   0x08026948: 2600        movs	r6, #0
@   0x0802694a: 1c35        adds	r5, r6, #0
@   0x0802694c: 350f        adds	r5, #15
@   0x0802694e: 4913        ldr	r1, [pc, #76]	@ (0x2699c)
@   0x08026950: 00b0        lsls	r0, r6, #2
@   0x08026952: 1840        adds	r0, r0, r1
@   0x08026954: 6804        ldr	r4, [r0, #0]
@   0x08026956: 1c30        adds	r0, r6, #0
@   0x08026958: 210c        movs	r1, #12
@   0x0802695a: f00d        faff 	bl	0x33f5c
@   0x0802695e: 0600        lsls	r0, r0, #24
@   0x08026960: 0900        lsrs	r0, r0, #4
@   0x08026962: 490f        ldr	r1, [pc, #60]	@ (0x269a0)
@   0x08026964: 1840        adds	r0, r0, r1
@   0x08026966: 0c00        lsrs	r0, r0, #16
@   0x08026968: 9000        str	r0, [sp, #0]
@   0x0802696a: 2702        movs	r7, #2
@   0x0802696c: 9701        str	r7, [sp, #4]
@   0x0802696e: 2003        movs	r0, #3
@   0x08026970: 9002        str	r0, [sp, #8]
@   0x08026972: 9003        str	r0, [sp, #12]
@   0x08026974: 1c28        adds	r0, r5, #0
@   0x08026976: 1c21        adds	r1, r4, #0
@   0x08026978: 2210        movs	r2, #16
@   0x0802697a: 2331        movs	r3, #49	@ 0x31
@   0x0802697c: f7fa        fb90 	bl	0x210a0
@   0x08026980: 1c70        adds	r0, r6, #1
@   0x08026982: 0600        lsls	r0, r0, #24
@   0x08026984: 0e06        lsrs	r6, r0, #24
@   0x08026986: 2e19        cmp	r6, #25
@   0x08026988: d9df        bls.n	0x2694a
@   0x0802698a: 4806        ldr	r0, [pc, #24]	@ (0x269a4)
@   0x0802698c: 4906        ldr	r1, [pc, #24]	@ (0x269a8)
@   0x0802698e: 1840        adds	r0, r0, r1
@   0x08026990: 7007        strb	r7, [r0, #0]
@   0x08026992: b004        add	sp, #16
@   0x08026994: bcf0        pop	{r4, r5, r6, r7}
@   0x08026996: bc01        pop	{r0}
@   0x08026998: 4700        bx	r0
@   0x0802699a: 0000        movs	r0, r0
@   0x0802699c: 5a74        ldrh	r4, [r6, r1]
@   0x0802699e: 0831        lsrs	r1, r6, #32
@   0x080269a0: 0000        movs	r0, r0
@   0x080269a2: 0141        lsls	r1, r0, #5
@   0x080269a4: 3720        adds	r7, #32
@   0x080269a6: 0300        lsls	r0, r0, #12
@   0x080269a8: 0397        lsls	r7, r2, #14

        thumb_func_start sub_08026944
sub_08026944: @ 0x08026944
        .incbin "baserom.gba", 0x26944, 0x68
        thumb_func_end sub_08026944
