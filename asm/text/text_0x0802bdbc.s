@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bdbc, 0x0802bf58)  (0x19c bytes)
@
@ Post-peel chunk after sub_0802BC94.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802bdbc
        .type   text_0802bdbc, %object
text_0802bdbc:
        .incbin "frog_us_baserom.gba", 0x0002bdbc, 0x0000019c
        .size   text_0802bdbc, . - text_0802bdbc
