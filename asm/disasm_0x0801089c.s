@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801089c, 0x080108f8)  (92 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801089c --end 0x80108f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801089c: b530        push	{r4, r5, lr}
@   0x0801089e: 4c10        ldr	r4, [pc, #64]	@ (0x108e0)
@   0x080108a0: 4b10        ldr	r3, [pc, #64]	@ (0x108e4)
@   0x080108a2: 6820        ldr	r0, [r4, #0]
@   0x080108a4: 6859        ldr	r1, [r3, #4]
@   0x080108a6: 1a40        subs	r0, r0, r1
@   0x080108a8: 2807        cmp	r0, #7
@   0x080108aa: d915        bls.n	0x108d8
@   0x080108ac: 7a98        ldrb	r0, [r3, #10]
@   0x080108ae: 2817        cmp	r0, #23
@   0x080108b0: d901        bls.n	0x108b6
@   0x080108b2: 2000        movs	r0, #0
@   0x080108b4: 7298        strb	r0, [r3, #10]
@   0x080108b6: 490c        ldr	r1, [pc, #48]	@ (0x108e8)
@   0x080108b8: 4a0c        ldr	r2, [pc, #48]	@ (0x108ec)
@   0x080108ba: 7a9d        ldrb	r5, [r3, #10]
@   0x080108bc: 00a8        lsls	r0, r5, #2
@   0x080108be: 1880        adds	r0, r0, r2
@   0x080108c0: 6800        ldr	r0, [r0, #0]
@   0x080108c2: 6008        str	r0, [r1, #0]
@   0x080108c4: 480a        ldr	r0, [pc, #40]	@ (0x108f0)
@   0x080108c6: 6048        str	r0, [r1, #4]
@   0x080108c8: 480a        ldr	r0, [pc, #40]	@ (0x108f4)
@   0x080108ca: 6088        str	r0, [r1, #8]
@   0x080108cc: 6888        ldr	r0, [r1, #8]
@   0x080108ce: 7a98        ldrb	r0, [r3, #10]
@   0x080108d0: 3001        adds	r0, #1
@   0x080108d2: 7298        strb	r0, [r3, #10]
@   0x080108d4: 6820        ldr	r0, [r4, #0]
@   0x080108d6: 6058        str	r0, [r3, #4]
@   0x080108d8: bc30        pop	{r4, r5}
@   0x080108da: bc01        pop	{r0}
@   0x080108dc: 4700        bx	r0
@   0x080108de: 0000        movs	r0, r0
@   0x080108e0: 5330        strh	r0, [r6, r4]
@   0x080108e2: 0300        lsls	r0, r0, #12
@   0x080108e4: 6480        str	r0, [r0, #72]	@ 0x48
@   0x080108e6: 0300        lsls	r0, r0, #12
@   0x080108e8: 00d4        lsls	r4, r2, #3
@   0x080108ea: 0400        lsls	r0, r0, #16
@   0x080108ec: 68a8        ldr	r0, [r5, #8]
@   0x080108ee: 0830        lsrs	r0, r6, #32
@   0x080108f0: 1c00        adds	r0, r0, #0
@   0x080108f2: 0600        lsls	r0, r0, #24
@   0x080108f4: 0090        lsls	r0, r2, #2
@   0x080108f6: 8000        strh	r0, [r0, #0]
