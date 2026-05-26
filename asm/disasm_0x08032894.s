@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08032894, 0x08032904)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8032894 --end 0x8032904 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08032894: b530        push	{r4, r5, lr}
@   0x08032896: 4684        mov	ip, r0
@   0x08032898: 1c0d        adds	r5, r1, #0
@   0x0803289a: 1c14        adds	r4, r2, #0
@   0x0803289c: 303d        adds	r0, #61	@ 0x3d
@   0x0803289e: 2200        movs	r2, #0
@   0x080328a0: 7002        strb	r2, [r0, #0]
@   0x080328a2: 20ff        movs	r0, #255	@ 0xff
@   0x080328a4: 0200        lsls	r0, r0, #8
@   0x080328a6: 4661        mov	r1, ip
@   0x080328a8: 8508        strh	r0, [r1, #40]	@ 0x28
@   0x080328aa: 20c0        movs	r0, #192	@ 0xc0
@   0x080328ac: 0200        lsls	r0, r0, #8
@   0x080328ae: 86c8        strh	r0, [r1, #54]	@ 0x36
@   0x080328b0: 313f        adds	r1, #63	@ 0x3f
@   0x080328b2: 2001        movs	r0, #1
@   0x080328b4: 7008        strb	r0, [r1, #0]
@   0x080328b6: 005b        lsls	r3, r3, #1
@   0x080328b8: 3914        subs	r1, #20
@   0x080328ba: 700b        strb	r3, [r1, #0]
@   0x080328bc: 0618        lsls	r0, r3, #24
@   0x080328be: 2800        cmp	r0, #0
@   0x080328c0: d001        beq.n	0x328c6
@   0x080328c2: 1c58        adds	r0, r3, #1
@   0x080328c4: 7008        strb	r0, [r1, #0]
@   0x080328c6: 4663        mov	r3, ip
@   0x080328c8: 332a        adds	r3, #42	@ 0x2a
@   0x080328ca: 2000        movs	r0, #0
@   0x080328cc: 7018        strb	r0, [r3, #0]
@   0x080328ce: 4663        mov	r3, ip
@   0x080328d0: 639a        str	r2, [r3, #56]	@ 0x38
@   0x080328d2: 4660        mov	r0, ip
@   0x080328d4: 303c        adds	r0, #60	@ 0x3c
@   0x080328d6: 7004        strb	r4, [r0, #0]
@   0x080328d8: 9803        ldr	r0, [sp, #12]
@   0x080328da: 8698        strh	r0, [r3, #52]	@ 0x34
@   0x080328dc: 881c        ldrh	r4, [r3, #0]
@   0x080328de: 8b99        ldrh	r1, [r3, #28]
@   0x080328e0: 1860        adds	r0, r4, r1
@   0x080328e2: 8458        strh	r0, [r3, #34]	@ 0x22
@   0x080328e4: 0228        lsls	r0, r5, #8
@   0x080328e6: 8018        strh	r0, [r3, #0]
@   0x080328e8: 805a        strh	r2, [r3, #2]
@   0x080328ea: 839a        strh	r2, [r3, #28]
@   0x080328ec: 83da        strh	r2, [r3, #30]
@   0x080328ee: 841a        strh	r2, [r3, #32]
@   0x080328f0: 829a        strh	r2, [r3, #20]
@   0x080328f2: 82da        strh	r2, [r3, #22]
@   0x080328f4: 809a        strh	r2, [r3, #4]
@   0x080328f6: 80da        strh	r2, [r3, #6]
@   0x080328f8: 819a        strh	r2, [r3, #12]
@   0x080328fa: 81da        strh	r2, [r3, #14]
@   0x080328fc: 825a        strh	r2, [r3, #18]
@   0x080328fe: bc30        pop	{r4, r5}
@   0x08032900: bc01        pop	{r0}
@   0x08032902: 4700        bx	r0

        thumb_func_start sub_08032894
sub_08032894: @ 0x08032894
        .incbin "frog_us_baserom.gba", 0x32894, 0x70
        thumb_func_end sub_08032894
