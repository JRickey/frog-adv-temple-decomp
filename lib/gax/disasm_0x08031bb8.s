@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08031bb8, 0x08031c04)  (76 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8031bb8 --end 0x8031c04 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08031bb8: b530        push	{r4, r5, lr}
@   0x08031bba: 1c02        adds	r2, r0, #0
@   0x08031bbc: 1c0b        adds	r3, r1, #0
@   0x08031bbe: 681c        ldr	r4, [r3, #0]
@   0x08031bc0: 2a03        cmp	r2, #3
@   0x08031bc2: dd16        ble.n	0x31bf2
@   0x08031bc4: 480e        ldr	r0, [pc, #56]	@ (0x31c00)
@   0x08031bc6: 6801        ldr	r1, [r0, #0]
@   0x08031bc8: 2587        movs	r5, #135	@ 0x87
@   0x08031bca: 006d        lsls	r5, r5, #1
@   0x08031bcc: 1948        adds	r0, r1, r5
@   0x08031bce: 7800        ldrb	r0, [r0, #0]
@   0x08031bd0: 2800        cmp	r0, #0
@   0x08031bd2: d00e        beq.n	0x31bf2
@   0x08031bd4: 1c08        adds	r0, r1, #0
@   0x08031bd6: 30c0        adds	r0, #192	@ 0xc0
@   0x08031bd8: 6801        ldr	r1, [r0, #0]
@   0x08031bda: 00d0        lsls	r0, r2, #3
@   0x08031bdc: 1a80        subs	r0, r0, r2
@   0x08031bde: 0080        lsls	r0, r0, #2
@   0x08031be0: 1840        adds	r0, r0, r1
@   0x08031be2: 1c01        adds	r1, r0, #0
@   0x08031be4: 3970        subs	r1, #112	@ 0x70
@   0x08031be6: 2200        movs	r2, #0
@   0x08031be8: 7860        ldrb	r0, [r4, #1]
@   0x08031bea: 2800        cmp	r0, #0
@   0x08031bec: d100        bne.n	0x31bf0
@   0x08031bee: 2201        movs	r2, #1
@   0x08031bf0: 76ca        strb	r2, [r1, #27]
@   0x08031bf2: 6818        ldr	r0, [r3, #0]
@   0x08031bf4: 3002        adds	r0, #2
@   0x08031bf6: 6018        str	r0, [r3, #0]
@   0x08031bf8: 2001        movs	r0, #1
@   0x08031bfa: bc30        pop	{r4, r5}
@   0x08031bfc: bc02        pop	{r1}
@   0x08031bfe: 4708        bx	r1
@   0x08031c00: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031c02: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08031BB8
sub_08031BB8: @ 0x08031bb8
        .incbin "frog_us_baserom.gba", 0x31bb8, 0x4c
        thumb_func_end sub_08031BB8
