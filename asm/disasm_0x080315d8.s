@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080315d8, 0x08031638)  (96 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80315d8 --end 0x8031638 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080315d8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080315da: 2500        movs	r5, #0
@   0x080315dc: e01e        b.n	0x3161c
@   0x080315de: 6808        ldr	r0, [r1, #0]
@   0x080315e0: 218a        movs	r1, #138	@ 0x8a
@   0x080315e2: 0049        lsls	r1, r1, #1
@   0x080315e4: 1840        adds	r0, r0, r1
@   0x080315e6: 6800        ldr	r0, [r0, #0]
@   0x080315e8: 0129        lsls	r1, r5, #4
@   0x080315ea: 1808        adds	r0, r1, r0
@   0x080315ec: 6800        ldr	r0, [r0, #0]
@   0x080315ee: 1c0c        adds	r4, r1, #0
@   0x080315f0: 1c6e        adds	r6, r5, #1
@   0x080315f2: 2800        cmp	r0, #0
@   0x080315f4: d011        beq.n	0x3161a
@   0x080315f6: 4f0e        ldr	r7, [pc, #56]	@ (0x31630)
@   0x080315f8: 480e        ldr	r0, [pc, #56]	@ (0x31634)
@   0x080315fa: 6800        ldr	r0, [r0, #0]
@   0x080315fc: 218a        movs	r1, #138	@ 0x8a
@   0x080315fe: 0049        lsls	r1, r1, #1
@   0x08031600: 1840        adds	r0, r0, r1
@   0x08031602: 6801        ldr	r1, [r0, #0]
@   0x08031604: 1861        adds	r1, r4, r1
@   0x08031606: 6808        ldr	r0, [r1, #0]
@   0x08031608: 7800        ldrb	r0, [r0, #0]
@   0x0803160a: 0080        lsls	r0, r0, #2
@   0x0803160c: 19c0        adds	r0, r0, r7
@   0x0803160e: 6802        ldr	r2, [r0, #0]
@   0x08031610: 1c28        adds	r0, r5, #0
@   0x08031612: f002        fb65 	bl	0x33ce0
@   0x08031616: 2800        cmp	r0, #0
@   0x08031618: d1ee        bne.n	0x315f8
@   0x0803161a: 1c35        adds	r5, r6, #0
@   0x0803161c: 4905        ldr	r1, [pc, #20]	@ (0x31634)
@   0x0803161e: 6808        ldr	r0, [r1, #0]
@   0x08031620: 7800        ldrb	r0, [r0, #0]
@   0x08031622: 3004        adds	r0, #4
@   0x08031624: 4285        cmp	r5, r0
@   0x08031626: dbda        blt.n	0x315de
@   0x08031628: bcf0        pop	{r4, r5, r6, r7}
@   0x0803162a: bc01        pop	{r0}
@   0x0803162c: 4700        bx	r0
@   0x0803162e: 0000        movs	r0, r0
@   0x08031630: dcdc        bgt.n	0x315ec
@   0x08031632: 083d        lsrs	r5, r7, #32
@   0x08031634: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08031636: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080315D8
sub_080315D8: @ 0x080315d8
        .incbin "frog_us_baserom.gba", 0x315d8, 0x60
        thumb_func_end sub_080315D8
