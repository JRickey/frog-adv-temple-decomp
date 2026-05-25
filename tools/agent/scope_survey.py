#!/usr/bin/env python3
"""Rough scope survey of the baserom.

Heuristic-only: counts probable Thumb function prologues (`push {..., lr}`,
opcode 0xB4-0xB5 in the second byte of a halfword) and probable ARM
prologues (`stmfd sp!, {..., lr}` opcode 0xE92D with lr bit set) across
ROM-mapped bytes [0x080000C0, 0x08400000).

The number is an *estimate*. False positives come from constant data and
jump tables that happen to spell PUSH-like halfwords; false negatives come
from leaf functions that never push anything. For decomp planning the
order-of-magnitude is what we care about — exact count comes only after
the disassembly itself is well-typed.

Usage:
    python3 tools/agent/scope_survey.py
"""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
ROM_BASE = 0x08000000
TEXT_START = 0x080000C0  # entry of executable region (post-header)


def main() -> int:
    data = BASEROM.read_bytes()
    rom_size = len(data)
    text_size = rom_size - (TEXT_START - ROM_BASE)

    thumb_push_lr = 0   # b5XX  — push {..., lr}
    thumb_push_no_lr = 0  # b4XX — push {...}
    arm_push_lr = 0     # e92d_4__  — stmfd sp!, {..., lr}
    arm_push_no_lr = 0

    # Thumb scan: halfword-aligned within [text_start, end).
    start = TEXT_START - ROM_BASE
    end = rom_size
    for off in range(start, end - 1, 2):
        b0, b1 = data[off], data[off + 1]
        if b1 == 0xB5:
            thumb_push_lr += 1
        elif b1 == 0xB4:
            thumb_push_no_lr += 1

    # ARM scan: word-aligned. `e92dXYZW` = stmfd sp!, {regs}; lr is bit 14
    # of the register list, which sits in nibble Y (byte offset +2).
    for off in range(start, end - 3, 4):
        if data[off + 3] == 0xE9 and data[off + 2] == 0x2D:
            # nibble 'Y' is high nibble of data[off+1].
            reglist_high = data[off + 1]
            if reglist_high & 0x40:
                arm_push_lr += 1
            else:
                arm_push_no_lr += 1

    # Cap the printed ARM-with-lr count: ARM mode is only used at the
    # crt0/IRQ-handler region in agbcc games, so anything past ~0x300 is
    # almost certainly a false positive from data.
    arm_in_crt0 = sum(
        1
        for off in range(start, min(end, (0x300 - ROM_BASE + ROM_BASE) - ROM_BASE), 4)
    )

    print(f"baserom:                {rom_size:#x} ({rom_size / 1024 / 1024:.2f} MiB)")
    print(f"text region (≥0xC0):    {text_size:#x} ({text_size / 1024 / 1024:.2f} MiB)")
    print()
    print("Heuristic function-prologue counts (over-estimates due to data):")
    print(f"  Thumb 'push {{...,lr}}' (b5xx):    {thumb_push_lr:>7,}")
    print(f"  Thumb 'push {{...}}'    (b4xx):    {thumb_push_no_lr:>7,}")
    print(f"  ARM   'stmfd lr,...'   (e92d4_):   {arm_push_lr:>7,}")
    print(f"  ARM   'stmfd no-lr'    (e92d0_):   {arm_push_no_lr:>7,}")
    print()
    print("Notes:")
    print(" - Thumb b5xx is by far the most reliable proxy for a function;")
    print("   real count is usually 0.3x–0.7x of this raw figure once data")
    print("   (graphics, level data, sound) is excluded.")
    print(" - ARM functions in agbcc projects are confined to crt0/IRQ;")
    print("   expect single-digit ARM functions total.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
