@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800fcc8, 0x0800fd50)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800fcc8 --end 0x800fd50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800fcc8: b510        push	{r4, lr}
@   0x0800fcca: 1c04        adds	r4, r0, #0
@   0x0800fccc: 0624        lsls	r4, r4, #24
@   0x0800fcce: 0e24        lsrs	r4, r4, #24
@   0x0800fcd0: 1c20        adds	r0, r4, #0
@   0x0800fcd2: f7ff        fd9f 	bl	0xf814
@   0x0800fcd6: 1c20        adds	r0, r4, #0
@   0x0800fcd8: f7ff        fb5e 	bl	0xf398
@   0x0800fcdc: bc10        pop	{r4}
@   0x0800fcde: bc01        pop	{r0}
@   0x0800fce0: 4700        bx	r0
@   0x0800fce2: 0000        movs	r0, r0
@   0x0800fce4: 0600        lsls	r0, r0, #24
@   0x0800fce6: 0e00        lsrs	r0, r0, #24
@   0x0800fce8: 1c01        adds	r1, r0, #0
@   0x0800fcea: 2801        cmp	r0, #1
@   0x0800fcec: d00a        beq.n	0xfd04
@   0x0800fcee: 2801        cmp	r0, #1
@   0x0800fcf0: dc02        bgt.n	0xfcf8
@   0x0800fcf2: 2800        cmp	r0, #0
@   0x0800fcf4: d003        beq.n	0xfcfe
@   0x0800fcf6: e00a        b.n	0xfd0e
@   0x0800fcf8: 2902        cmp	r1, #2
@   0x0800fcfa: d007        beq.n	0xfd0c
@   0x0800fcfc: e007        b.n	0xfd0e
@   0x0800fcfe: 2280        movs	r2, #128	@ 0x80
@   0x0800fd00: 0492        lsls	r2, r2, #18
@   0x0800fd02: e004        b.n	0xfd0e
@   0x0800fd04: 4a00        ldr	r2, [pc, #0]	@ (0xfd08)
@   0x0800fd06: e002        b.n	0xfd0e
@   0x0800fd08: 0000        movs	r0, r0
@   0x0800fd0a: 0201        lsls	r1, r0, #8
@   0x0800fd0c: 4a01        ldr	r2, [pc, #4]	@ (0xfd14)
@   0x0800fd0e: 1c10        adds	r0, r2, #0
@   0x0800fd10: 4770        bx	lr
@   0x0800fd12: 0000        movs	r0, r0
@   0x0800fd14: 0000        movs	r0, r0
@   0x0800fd16: 0202        lsls	r2, r0, #8
@   0x0800fd18: 0600        lsls	r0, r0, #24
@   0x0800fd1a: 0e00        lsrs	r0, r0, #24
@   0x0800fd1c: 1c01        adds	r1, r0, #0
@   0x0800fd1e: 2801        cmp	r0, #1
@   0x0800fd20: d00c        beq.n	0xfd3c
@   0x0800fd22: 2801        cmp	r0, #1
@   0x0800fd24: dc02        bgt.n	0xfd2c
@   0x0800fd26: 2800        cmp	r0, #0
@   0x0800fd28: d003        beq.n	0xfd32
@   0x0800fd2a: e00c        b.n	0xfd46
@   0x0800fd2c: 2902        cmp	r1, #2
@   0x0800fd2e: d009        beq.n	0xfd44
@   0x0800fd30: e009        b.n	0xfd46
@   0x0800fd32: 4a01        ldr	r2, [pc, #4]	@ (0xfd38)
@   0x0800fd34: e007        b.n	0xfd46
@   0x0800fd36: 0000        movs	r0, r0
@   0x0800fd38: e000        b.n	0xfd3c
@   0x0800fd3a: 0600        lsls	r0, r0, #24
@   0x0800fd3c: 4a00        ldr	r2, [pc, #0]	@ (0xfd40)
@   0x0800fd3e: e002        b.n	0xfd46
@   0x0800fd40: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0800fd44: 4a01        ldr	r2, [pc, #4]	@ (0xfd4c)
@   0x0800fd46: 1c10        adds	r0, r2, #0
@   0x0800fd48: 4770        bx	lr
@   0x0800fd4a: 0000        movs	r0, r0
@   0x0800fd4c: f000        0600 	and.w	r6, r0, #0

        thumb_func_start sub_0800FCC8
sub_0800FCC8: @ 0x0800fcc8
        .incbin "frog_us_baserom.gba", 0xfcc8, 0x88
        thumb_func_end sub_0800FCC8
