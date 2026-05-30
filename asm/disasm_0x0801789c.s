@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801789c, 0x080178fc)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801789c --end 0x80178fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801789c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801789e: 1c07        adds	r7, r0, #0
@   0x080178a0: 0409        lsls	r1, r1, #16
@   0x080178a2: 0c0e        lsrs	r6, r1, #16
@   0x080178a4: 0612        lsls	r2, r2, #24
@   0x080178a6: 0e15        lsrs	r5, r2, #24
@   0x080178a8: 2400        movs	r4, #0
@   0x080178aa: 42ac        cmp	r4, r5
@   0x080178ac: d20e        bcs.n	0x178cc
@   0x080178ae: 1930        adds	r0, r6, r4
@   0x080178b0: 0400        lsls	r0, r0, #16
@   0x080178b2: 0c00        lsrs	r0, r0, #16
@   0x080178b4: 00e1        lsls	r1, r4, #3
@   0x080178b6: 1879        adds	r1, r7, r1
@   0x080178b8: f01c        f936 	bl	0x33b28
@   0x080178bc: 0400        lsls	r0, r0, #16
@   0x080178be: 2800        cmp	r0, #0
@   0x080178c0: d118        bne.n	0x178f4
@   0x080178c2: 1c60        adds	r0, r4, #1
@   0x080178c4: 0600        lsls	r0, r0, #24
@   0x080178c6: 0e04        lsrs	r4, r0, #24
@   0x080178c8: 42ac        cmp	r4, r5
@   0x080178ca: d3f0        bcc.n	0x178ae
@   0x080178cc: 2400        movs	r4, #0
@   0x080178ce: 42ac        cmp	r4, r5
@   0x080178d0: d20e        bcs.n	0x178f0
@   0x080178d2: 1930        adds	r0, r6, r4
@   0x080178d4: 0400        lsls	r0, r0, #16
@   0x080178d6: 0c00        lsrs	r0, r0, #16
@   0x080178d8: 00e1        lsls	r1, r4, #3
@   0x080178da: 1879        adds	r1, r7, r1
@   0x080178dc: f01c        f996 	bl	0x33c0c
@   0x080178e0: 0400        lsls	r0, r0, #16
@   0x080178e2: 2800        cmp	r0, #0
@   0x080178e4: d106        bne.n	0x178f4
@   0x080178e6: 1c60        adds	r0, r4, #1
@   0x080178e8: 0600        lsls	r0, r0, #24
@   0x080178ea: 0e04        lsrs	r4, r0, #24
@   0x080178ec: 42ac        cmp	r4, r5
@   0x080178ee: d3f0        bcc.n	0x178d2
@   0x080178f0: 2001        movs	r0, #1
@   0x080178f2: e000        b.n	0x178f6
@   0x080178f4: 2000        movs	r0, #0
@   0x080178f6: bcf0        pop	{r4, r5, r6, r7}
@   0x080178f8: bc02        pop	{r1}
@   0x080178fa: 4708        bx	r1

        thumb_func_start sub_0801789C
sub_0801789C: @ 0x0801789c
        .incbin "frog_us_baserom.gba", 0x1789c, 0x60
        thumb_func_end sub_0801789C
