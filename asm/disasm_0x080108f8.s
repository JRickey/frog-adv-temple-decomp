@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080108f8, 0x08010958)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80108f8 --end 0x8010958 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080108f8: b530        push	{r4, r5, lr}
@   0x080108fa: 4c11        ldr	r4, [pc, #68]	@ (0x10940)
@   0x080108fc: 4b11        ldr	r3, [pc, #68]	@ (0x10944)
@   0x080108fe: 6820        ldr	r0, [r4, #0]
@   0x08010900: 6859        ldr	r1, [r3, #4]
@   0x08010902: 1a40        subs	r0, r0, r1
@   0x08010904: 2807        cmp	r0, #7
@   0x08010906: d915        bls.n	0x10934
@   0x08010908: 7a98        ldrb	r0, [r3, #10]
@   0x0801090a: 2817        cmp	r0, #23
@   0x0801090c: d901        bls.n	0x10912
@   0x0801090e: 2000        movs	r0, #0
@   0x08010910: 7298        strb	r0, [r3, #10]
@   0x08010912: 490d        ldr	r1, [pc, #52]	@ (0x10948)
@   0x08010914: 4a0d        ldr	r2, [pc, #52]	@ (0x1094c)
@   0x08010916: 7a9d        ldrb	r5, [r3, #10]
@   0x08010918: 00a8        lsls	r0, r5, #2
@   0x0801091a: 1880        adds	r0, r0, r2
@   0x0801091c: 6800        ldr	r0, [r0, #0]
@   0x0801091e: 6008        str	r0, [r1, #0]
@   0x08010920: 480b        ldr	r0, [pc, #44]	@ (0x10950)
@   0x08010922: 6048        str	r0, [r1, #4]
@   0x08010924: 480b        ldr	r0, [pc, #44]	@ (0x10954)
@   0x08010926: 6088        str	r0, [r1, #8]
@   0x08010928: 6888        ldr	r0, [r1, #8]
@   0x0801092a: 7a98        ldrb	r0, [r3, #10]
@   0x0801092c: 3001        adds	r0, #1
@   0x0801092e: 7298        strb	r0, [r3, #10]
@   0x08010930: 6820        ldr	r0, [r4, #0]
@   0x08010932: 6058        str	r0, [r3, #4]
@   0x08010934: f006        fb64 	bl	0x17000
@   0x08010938: bc30        pop	{r4, r5}
@   0x0801093a: bc01        pop	{r0}
@   0x0801093c: 4700        bx	r0
@   0x0801093e: 0000        movs	r0, r0
@   0x08010940: 5330        strh	r0, [r6, r4]
@   0x08010942: 0300        lsls	r0, r0, #12
@   0x08010944: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08010946: 0300        lsls	r0, r0, #12
@   0x08010948: 00d4        lsls	r4, r2, #3
@   0x0801094a: 0400        lsls	r0, r0, #16
@   0x0801094c: 68a8        ldr	r0, [r5, #8]
@   0x0801094e: 0830        lsrs	r0, r6, #32
@   0x08010950: 1c00        adds	r0, r0, #0
@   0x08010952: 0600        lsls	r0, r0, #24
@   0x08010954: 0090        lsls	r0, r2, #2
@   0x08010956: 8000        strh	r0, [r0, #0]
