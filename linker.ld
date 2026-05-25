/* Linker script for Frogger's Adventures: Temple of the Frog (USA).
 *
 * This is a SKELETON. A real matching build needs:
 *   - EWRAM/IWRAM symbol layout cribbed from the disassembly
 *   - `.text` filled in with the asm and (eventually) C objects in baserom
 *     address order — each `asm/disasm_0xADDR.o(.text)` slice represents
 *     a contiguous range of un-decompiled functions
 *   - `.rodata` for data tables (when extracted from the baserom)
 *   - `.data` for any initialized RAM data the ROM ships with
 *
 * Build it up as the disassembly progresses. See `tools/agent/pick_target.py`
 * for the layout-order invariant — function entries here must match baserom
 * address order or the per-function diff will report layout drift.
 */

MEMORY {
    ewram : ORIGIN = 0x02000000 LENGTH = 256K
    iwram : ORIGIN = 0x03000000 LENGTH = 32K
    rom : ORIGIN = 0x08000000 LENGTH = 32M
}

SECTIONS {
    ewram (NOLOAD) : ALIGN(4) {
        /* Add ewram globals here as the disassembly identifies them. */
    } >ewram

    iwram (NOLOAD) : ALIGN(4) {
        /* Add iwram globals here. */
    } >iwram

    .text : ALIGN(4) {
        /* Crt0 / interrupt handlers go first.
         * src/crt0.o(.text);
         *
         * Then asm slices interleaved with C objects in baserom address
         * order. As functions get decompiled, asm slices shrink/split.
         *
         * asm/disasm_0x08000000.o(.text);
         * ...
         */
    } >rom

    .rodata : ALIGN(4) {
        /* Read-only data tables. */
    } >rom

    .data : ALIGN(2) {
        /* Initialized RAM data (copied from ROM at boot). */
    } >rom
}
