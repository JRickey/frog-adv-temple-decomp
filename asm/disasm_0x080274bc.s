@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080274bc, 0x08027510)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80274bc --end 0x8027510 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080274bc: b570        push	{r4, r5, r6, lr}
@   0x080274be: b084        sub	sp, #16
@   0x080274c0: 2600        movs	r6, #0
@   0x080274c2: 1c35        adds	r5, r6, #0
@   0x080274c4: 3535        adds	r5, #53	@ 0x35
@   0x080274c6: 4911        ldr	r1, [pc, #68]	@ (0x2750c)
@   0x080274c8: 00b0        lsls	r0, r6, #2
@   0x080274ca: 1840        adds	r0, r0, r1
@   0x080274cc: 6804        ldr	r4, [r0, #0]
@   0x080274ce: 1c30        adds	r0, r6, #0
@   0x080274d0: 210f        movs	r1, #15
@   0x080274d2: f00c        fd43 	bl	0x33f5c
@   0x080274d6: 0600        lsls	r0, r0, #24
@   0x080274d8: 0900        lsrs	r0, r0, #4
@   0x080274da: 2181        movs	r1, #129	@ 0x81
@   0x080274dc: 0409        lsls	r1, r1, #16
@   0x080274de: 1840        adds	r0, r0, r1
@   0x080274e0: 0c00        lsrs	r0, r0, #16
@   0x080274e2: 9000        str	r0, [sp, #0]
@   0x080274e4: 2006        movs	r0, #6
@   0x080274e6: 9001        str	r0, [sp, #4]
@   0x080274e8: 2003        movs	r0, #3
@   0x080274ea: 9002        str	r0, [sp, #8]
@   0x080274ec: 9003        str	r0, [sp, #12]
@   0x080274ee: 1c28        adds	r0, r5, #0
@   0x080274f0: 1c21        adds	r1, r4, #0
@   0x080274f2: 2210        movs	r2, #16
@   0x080274f4: 2331        movs	r3, #49	@ 0x31
@   0x080274f6: f7f9        fdd3 	bl	0x210a0
@   0x080274fa: 1c70        adds	r0, r6, #1
@   0x080274fc: 0600        lsls	r0, r0, #24
@   0x080274fe: 0e06        lsrs	r6, r0, #24
@   0x08027500: 2e13        cmp	r6, #19
@   0x08027502: d9de        bls.n	0x274c2
@   0x08027504: b004        add	sp, #16
@   0x08027506: bc70        pop	{r4, r5, r6}
@   0x08027508: bc01        pop	{r0}
@   0x0802750a: 4700        bx	r0
@   0x0802750c: 667c        str	r4, [r7, #100]	@ 0x64
@   0x0802750e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080274BC
sub_080274BC: @ 0x080274bc
        .incbin "baserom.gba", 0x274bc, 0x54
        thumb_func_end sub_080274BC
