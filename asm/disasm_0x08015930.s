@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08015930, 0x080159b0)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8015930 --end 0x80159b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08015930: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08015932: 4657        mov	r7, sl
@   0x08015934: 464e        mov	r6, r9
@   0x08015936: 4645        mov	r5, r8
@   0x08015938: b4e0        push	{r5, r6, r7}
@   0x0801593a: b083        sub	sp, #12
@   0x0801593c: 2600        movs	r6, #0
@   0x0801593e: 4f1a        ldr	r7, [pc, #104]	@ (0x159a8)
@   0x08015940: 2001        movs	r0, #1
@   0x08015942: 4680        mov	r8, r0
@   0x08015944: 4919        ldr	r1, [pc, #100]	@ (0x159ac)
@   0x08015946: 4689        mov	r9, r1
@   0x08015948: 2510        movs	r5, #16
@   0x0801594a: 444d        add	r5, r9
@   0x0801594c: 46aa        mov	sl, r5
@   0x0801594e: 8cf8        ldrh	r0, [r7, #38]	@ 0x26
@   0x08015950: 4130        asrs	r0, r6
@   0x08015952: 4641        mov	r1, r8
@   0x08015954: 4008        ands	r0, r1
@   0x08015956: 2800        cmp	r0, #0
@   0x08015958: d019        beq.n	0x1598e
@   0x0801595a: 0075        lsls	r5, r6, #1
@   0x0801595c: 19ad        adds	r5, r5, r6
@   0x0801595e: 00ed        lsls	r5, r5, #3
@   0x08015960: 4648        mov	r0, r9
@   0x08015962: 182c        adds	r4, r5, r0
@   0x08015964: 7a20        ldrb	r0, [r4, #8]
@   0x08015966: 8821        ldrh	r1, [r4, #0]
@   0x08015968: 8862        ldrh	r2, [r4, #2]
@   0x0801596a: 88a3        ldrh	r3, [r4, #4]
@   0x0801596c: 88e4        ldrh	r4, [r4, #6]
@   0x0801596e: 9400        str	r4, [sp, #0]
@   0x08015970: 4455        add	r5, sl
@   0x08015972: 682c        ldr	r4, [r5, #0]
@   0x08015974: 9401        str	r4, [sp, #4]
@   0x08015976: 8cfc        ldrh	r4, [r7, #38]	@ 0x26
@   0x08015978: 4134        asrs	r4, r6
@   0x0801597a: 4645        mov	r5, r8
@   0x0801597c: 402c        ands	r4, r5
@   0x0801597e: 9402        str	r4, [sp, #8]
@   0x08015980: f7fd        f920 	bl	0x12bc4
@   0x08015984: 4640        mov	r0, r8
@   0x08015986: 40b0        lsls	r0, r6
@   0x08015988: 8d39        ldrh	r1, [r7, #40]	@ 0x28
@   0x0801598a: 4308        orrs	r0, r1
@   0x0801598c: 8538        strh	r0, [r7, #40]	@ 0x28
@   0x0801598e: 1c70        adds	r0, r6, #1
@   0x08015990: 0600        lsls	r0, r0, #24
@   0x08015992: 0e06        lsrs	r6, r0, #24
@   0x08015994: 2e03        cmp	r6, #3
@   0x08015996: d9da        bls.n	0x1594e
@   0x08015998: b003        add	sp, #12
@   0x0801599a: bc38        pop	{r3, r4, r5}
@   0x0801599c: 4698        mov	r8, r3
@   0x0801599e: 46a1        mov	r9, r4
@   0x080159a0: 46aa        mov	sl, r5
@   0x080159a2: bcf0        pop	{r4, r5, r6, r7}
@   0x080159a4: bc01        pop	{r0}
@   0x080159a6: 4700        bx	r0
@   0x080159a8: 6110        str	r0, [r2, #16]
@   0x080159aa: 0300        lsls	r0, r0, #12
@   0x080159ac: 7e18        ldrb	r0, [r3, #24]
@   0x080159ae: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_08015930
sub_08015930: @ 0x08015930
        .incbin "frog_us_baserom.gba", 0x15930, 0x80
        thumb_func_end sub_08015930
