@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080317e0, 0x08031824)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80317e0 --end 0x8031824 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080317e0: b510        push	{r4, lr}
@   0x080317e2: 1c0c        adds	r4, r1, #0
@   0x080317e4: 6823        ldr	r3, [r4, #0]
@   0x080317e6: 490b        ldr	r1, [pc, #44]	@ (0x31814)
@   0x080317e8: 6809        ldr	r1, [r1, #0]
@   0x080317ea: 228c        movs	r2, #140	@ 0x8c
@   0x080317ec: 0052        lsls	r2, r2, #1
@   0x080317ee: 1889        adds	r1, r1, r2
@   0x080317f0: 6809        ldr	r1, [r1, #0]
@   0x080317f2: 3a08        subs	r2, #8
@   0x080317f4: 1889        adds	r1, r1, r2
@   0x080317f6: 680a        ldr	r2, [r1, #0]
@   0x080317f8: 0041        lsls	r1, r0, #1
@   0x080317fa: 1809        adds	r1, r1, r0
@   0x080317fc: 0089        lsls	r1, r1, #2
@   0x080317fe: 1889        adds	r1, r1, r2
@   0x08031800: 79c9        ldrb	r1, [r1, #7]
@   0x08031802: 7858        ldrb	r0, [r3, #1]
@   0x08031804: 4281        cmp	r1, r0
@   0x08031806: d307        bcc.n	0x31818
@   0x08031808: 8899        ldrh	r1, [r3, #4]
@   0x0803180a: 0408        lsls	r0, r1, #16
@   0x0803180c: 885a        ldrh	r2, [r3, #2]
@   0x0803180e: 4310        orrs	r0, r2
@   0x08031810: 1818        adds	r0, r3, r0
@   0x08031812: e002        b.n	0x3181a
@   0x08031814: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031816: 0300        lsls	r0, r0, #12
@   0x08031818: 1d98        adds	r0, r3, #6
@   0x0803181a: 6020        str	r0, [r4, #0]
@   0x0803181c: 2001        movs	r0, #1
@   0x0803181e: bc10        pop	{r4}
@   0x08031820: bc02        pop	{r1}
@   0x08031822: 4708        bx	r1

        thumb_func_start sub_080317E0
sub_080317E0: @ 0x080317e0
        .incbin "frog_us_baserom.gba", 0x317e0, 0x44
        thumb_func_end sub_080317E0
