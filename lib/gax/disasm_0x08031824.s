@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031824, 0x08031868)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031824 --end 0x8031868 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031824: b510        push	{r4, lr}
@   0x08031826: 1c0c        adds	r4, r1, #0
@   0x08031828: 6823        ldr	r3, [r4, #0]
@   0x0803182a: 490b        ldr	r1, [pc, #44]	@ (0x31858)
@   0x0803182c: 6809        ldr	r1, [r1, #0]
@   0x0803182e: 228c        movs	r2, #140	@ 0x8c
@   0x08031830: 0052        lsls	r2, r2, #1
@   0x08031832: 1889        adds	r1, r1, r2
@   0x08031834: 6809        ldr	r1, [r1, #0]
@   0x08031836: 3a08        subs	r2, #8
@   0x08031838: 1889        adds	r1, r1, r2
@   0x0803183a: 680a        ldr	r2, [r1, #0]
@   0x0803183c: 0041        lsls	r1, r0, #1
@   0x0803183e: 1809        adds	r1, r1, r0
@   0x08031840: 0089        lsls	r1, r1, #2
@   0x08031842: 1889        adds	r1, r1, r2
@   0x08031844: 7a09        ldrb	r1, [r1, #8]
@   0x08031846: 7858        ldrb	r0, [r3, #1]
@   0x08031848: 4281        cmp	r1, r0
@   0x0803184a: d307        bcc.n	0x3185c
@   0x0803184c: 8899        ldrh	r1, [r3, #4]
@   0x0803184e: 0408        lsls	r0, r1, #16
@   0x08031850: 885a        ldrh	r2, [r3, #2]
@   0x08031852: 4310        orrs	r0, r2
@   0x08031854: 1818        adds	r0, r3, r0
@   0x08031856: e002        b.n	0x3185e
@   0x08031858: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803185a: 0300        lsls	r0, r0, #12
@   0x0803185c: 1d98        adds	r0, r3, #6
@   0x0803185e: 6020        str	r0, [r4, #0]
@   0x08031860: 2001        movs	r0, #1
@   0x08031862: bc10        pop	{r4}
@   0x08031864: bc02        pop	{r1}
@   0x08031866: 4708        bx	r1

        thumb_func_start sub_08031824
sub_08031824: @ 0x08031824
        .incbin "frog_us_baserom.gba", 0x31824, 0x44
        thumb_func_end sub_08031824
