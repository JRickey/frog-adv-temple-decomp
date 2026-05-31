@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013920, 0x08013980)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013920 --end 0x8013980 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013920: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08013922: 4647        mov	r7, r8
@   0x08013924: b480        push	{r7}
@   0x08013926: 1c04        adds	r4, r0, #0
@   0x08013928: 4694        mov	ip, r2
@   0x0801392a: 0609        lsls	r1, r1, #24
@   0x0801392c: 0e09        lsrs	r1, r1, #24
@   0x0801392e: 061b        lsls	r3, r3, #24
@   0x08013930: 0e1d        lsrs	r5, r3, #24
@   0x08013932: 4b0a        ldr	r3, [pc, #40]	@ (0x1395c)
@   0x08013934: 6818        ldr	r0, [r3, #0]
@   0x08013936: 6852        ldr	r2, [r2, #4]
@   0x08013938: 1a80        subs	r0, r0, r2
@   0x0801393a: 4698        mov	r8, r3
@   0x0801393c: 4288        cmp	r0, r1
@   0x0801393e: d31a        bcc.n	0x13976
@   0x08013940: 8822        ldrh	r2, [r4, #0]
@   0x08013942: 2100        movs	r1, #0
@   0x08013944: 42a9        cmp	r1, r5
@   0x08013946: d212        bcs.n	0x1396e
@   0x08013948: 1e6f        subs	r7, r5, #1
@   0x0801394a: 0068        lsls	r0, r5, #1
@   0x0801394c: 1e83        subs	r3, r0, #2
@   0x0801394e: 42b9        cmp	r1, r7
@   0x08013950: da06        bge.n	0x13960
@   0x08013952: 8866        ldrh	r6, [r4, #2]
@   0x08013954: 3402        adds	r4, #2
@   0x08013956: 8022        strh	r2, [r4, #0]
@   0x08013958: 1c32        adds	r2, r6, #0
@   0x0801395a: e003        b.n	0x13964
@   0x0801395c: 5330        strh	r0, [r6, r4]
@   0x0801395e: 0300        lsls	r0, r0, #12
@   0x08013960: 1ae4        subs	r4, r4, r3
@   0x08013962: 8026        strh	r6, [r4, #0]
@   0x08013964: 1c48        adds	r0, r1, #1
@   0x08013966: 0600        lsls	r0, r0, #24
@   0x08013968: 0e01        lsrs	r1, r0, #24
@   0x0801396a: 42a9        cmp	r1, r5
@   0x0801396c: d3ef        bcc.n	0x1394e
@   0x0801396e: 4641        mov	r1, r8
@   0x08013970: 6808        ldr	r0, [r1, #0]
@   0x08013972: 4667        mov	r7, ip
@   0x08013974: 6078        str	r0, [r7, #4]
@   0x08013976: bc08        pop	{r3}
@   0x08013978: 4698        mov	r8, r3
@   0x0801397a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801397c: bc01        pop	{r0}
@   0x0801397e: 4700        bx	r0

        thumb_func_start sub_08013920
sub_08013920: @ 0x08013920
        .incbin "frog_us_baserom.gba", 0x13920, 0x60
        thumb_func_end sub_08013920
