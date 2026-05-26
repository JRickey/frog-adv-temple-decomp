@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800658c, 0x08006600)  (116 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800658c --end 0x8006600 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800658c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800658e: 464f        mov	r7, r9
@   0x08006590: 4646        mov	r6, r8
@   0x08006592: b4c0        push	{r6, r7}
@   0x08006594: 4684        mov	ip, r0
@   0x08006596: 9807        ldr	r0, [sp, #28]
@   0x08006598: 4681        mov	r9, r0
@   0x0800659a: 9a08        ldr	r2, [sp, #32]
@   0x0800659c: 4690        mov	r8, r2
@   0x0800659e: 2600        movs	r6, #0
@   0x080065a0: 2200        movs	r2, #0
@   0x080065a2: 4667        mov	r7, ip
@   0x080065a4: 803a        strh	r2, [r7, #0]
@   0x080065a6: 2400        movs	r4, #0
@   0x080065a8: 2500        movs	r5, #0
@   0x080065aa: 4660        mov	r0, ip
@   0x080065ac: 6044        str	r4, [r0, #4]
@   0x080065ae: 6085        str	r5, [r0, #8]
@   0x080065b0: 8182        strh	r2, [r0, #12]
@   0x080065b2: 6102        str	r2, [r0, #16]
@   0x080065b4: 2001        movs	r0, #1
@   0x080065b6: 84b8        strh	r0, [r7, #36]	@ 0x24
@   0x080065b8: 84fa        strh	r2, [r7, #38]	@ 0x26
@   0x080065ba: 853a        strh	r2, [r7, #40]	@ 0x28
@   0x080065bc: 4660        mov	r0, ip
@   0x080065be: 302a        adds	r0, #42	@ 0x2a
@   0x080065c0: 7006        strb	r6, [r0, #0]
@   0x080065c2: 3001        adds	r0, #1
@   0x080065c4: 7006        strb	r6, [r0, #0]
@   0x080065c6: 3001        adds	r0, #1
@   0x080065c8: 7006        strb	r6, [r0, #0]
@   0x080065ca: 85fa        strh	r2, [r7, #46]	@ 0x2e
@   0x080065cc: 3005        adds	r0, #5
@   0x080065ce: 7006        strb	r6, [r0, #0]
@   0x080065d0: 4660        mov	r0, ip
@   0x080065d2: 6144        str	r4, [r0, #20]
@   0x080065d4: 6185        str	r5, [r0, #24]
@   0x080065d6: 4662        mov	r2, ip
@   0x080065d8: 61d4        str	r4, [r2, #28]
@   0x080065da: 6215        str	r5, [r2, #32]
@   0x080065dc: 3033        adds	r0, #51	@ 0x33
@   0x080065de: 7006        strb	r6, [r0, #0]
@   0x080065e0: 4647        mov	r7, r8
@   0x080065e2: 7097        strb	r7, [r2, #2]
@   0x080065e4: 3801        subs	r0, #1
@   0x080065e6: 464a        mov	r2, r9
@   0x080065e8: 7002        strb	r2, [r0, #0]
@   0x080065ea: 3802        subs	r0, #2
@   0x080065ec: 7001        strb	r1, [r0, #0]
@   0x080065ee: 4667        mov	r7, ip
@   0x080065f0: 637b        str	r3, [r7, #52]	@ 0x34
@   0x080065f2: bc18        pop	{r3, r4}
@   0x080065f4: 4698        mov	r8, r3
@   0x080065f6: 46a1        mov	r9, r4
@   0x080065f8: bcf0        pop	{r4, r5, r6, r7}
@   0x080065fa: bc01        pop	{r0}
@   0x080065fc: 4700        bx	r0

        thumb_func_start sub_0800658C
sub_0800658C: @ 0x0800658c
        .incbin "frog_us_baserom.gba", 0x658c, 0x74
        thumb_func_end sub_0800658C
