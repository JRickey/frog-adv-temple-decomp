@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x082f9994, 0x082f99e8)  (0x54 bytes)
@
@ A 7-record stride-12 block of shape {u16 a, u16 b, u32 flags, u32 z}
@ -- the same shape as sUnkDispatchData_82F9920 extracted in iter-17.
@ This block is the back-pointer target of sModeConfigTables_2F99E8[0]
@ (the first anchor at 0x082f99e8 stores 0x082f9994 in its ptr field).
@ No direct pool-load references in the still-asm code, so the block
@ stays raw until either a consumer surfaces OR the 0x082f99e8 cluster
@ ptr field gets re-expressed as a C extern in a future pass.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_082f9994
        .type   text_082f9994, %object
text_082f9994:
        .incbin "frog_us_baserom.gba", 0x002f9994, 0x00000054
        .size   text_082f9994, . - text_082f9994
