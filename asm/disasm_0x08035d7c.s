@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08035d7c, 0x08035d84)  (8 bytes, thumb-callable interwork thunk)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8035d7c --end 0x8035d84 --mode thumb
@
@ The first 4 bytes are Thumb (bx pc; nop) — a standard thumb-callable
@ ARM interwork trampoline. The next 4 bytes are an ARM `b` to 0xfc
@ (IntrEnable). Declare with thumb_func_start so the linker treats the
@ symbol as Thumb-callable (low bit set) and emits direct BL relocations
@ from Thumb callers without inserting an interwork veneer.

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08035d7c: 4778        bx	pc
@   0x08035d7e: 46c0        nop                @ (mov r8, r8)
@   0x08035d80: eaff28dd    b	0xfc           @ ARM-mode b IntrEnable

        thumb_func_start sub_08035D7C
sub_08035D7C: @ 0x08035d7c
        .incbin "frog_us_baserom.gba", 0x35d7c, 0x8
        thumb_func_end sub_08035D7C
