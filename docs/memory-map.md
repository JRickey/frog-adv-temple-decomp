# Memory map

Symbolic names for ROM/EWRAM/IWRAM/MMIO addresses as they're discovered.
Add an entry the moment a name lands in C or in an asm comment, with one
line of context.

## EWRAM (`0x02000000` — `0x02040000`)

(none named yet)

## IWRAM (`0x03000000` — `0x03008000`)

| Address | Symbol | Purpose | First reference |
|---|---|---|---|
| `0x03003480` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034A0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034B0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x030034B4` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03003550` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03005330` | `gGameStuff` (base) | Game-state struct | `src/game/game_mode.c` |
| `0x0300533A` | `gGameStuff.mode` | Game-state mode byte (drives AgbMain dispatch) | `SetGameMode_06` |
| `0x030035E0` | (TBD) | EWRAM/IWRAM ptr in AgbMain pool | AgbMain literal pool 2 |
| `0x03007F00` | `_start_svc_stack` (top) | Supervisor-mode SP | `_start` |
| `0x03007FA0` | `_start_irq_stack` (top) | IRQ-mode SP | `_start` |
| `0x03007FFC` | BIOS IRQ vector slot | BIOS reads this to dispatch HW IRQ | `_start` installs `IntrMain` here |

## MMIO (`0x04000000` — `0x04000400`)

| Address | Symbol | Purpose | First reference |
|---|---|---|---|
| `0x04000200` | `REG_IE` | IRQ enable mask (low 16 bits of IE_IF word) | `IntrMain` |
| `0x04000202` | `REG_IF` | IRQ pending mask | `IntrMain` ack store |
| `0x04000204` | (literal) | Used by AgbMain (likely `REG_WAITCNT` or waitcnt-adjacent) | AgbMain literal pool 1 |

## ROM (`0x08000000` — `0x08400000`)

| Address | Symbol | Notes |
|---|---|---|
| `0x080000C0` | `_start` | ARM crt0 entry |
| `0x080000FC` | `IntrEnable` | ARM, 24 bytes |
| `0x08000114` | `IntrDisable` | ARM, 24 bytes |
| `0x0800012C` | `IntrMain` | ARM IRQ dispatcher + shared literal pool |
| `0x0800022C` | (literal) | `IntrMain` pool: `0x03007FFC` |
| `0x08000230` | (literal) | `IntrMain` pool: `0x080002A5` (`AgbMain` thumb ptr) |
| `0x08000234` | (literal) | `IntrMain` pool: `0x08035D9C` (`gIntrTable`) |
| `0x08000238` | (literal) | `IntrMain` pool: `0x082F9010` (state used by `sub_08000240`) |
| `0x0800023C` | (literal) | `IntrMain` pool: `0x0802FFD9` (thumb fn used by `sub_08000240`) |
| `0x08000240` | `sub_08000240` | ARM, IRQ-wait-style helper |
| `0x080002A4` | `AgbMain` | First Thumb fn; 26-entry state-machine dispatcher |
| `0x080002E4` | (data) | `AgbMain` jump table base (26 × 4 bytes) |
| `0x080004C4` | (TBD) | Next Thumb function after `AgbMain` (200+ bytes) |
| `0x08002444` | `SetGameMode_06` | Writes 6 to `gGameStuff.mode` |
| `0x08002760` | `SetGameMode_07` | Writes 7 to `gGameStuff.mode` |
| `0x080052C0` | `SetGameMode_15` (predicted) | Pattern match: writes 15 — pending peel |
| `0x08035D9C` | `gIntrTable` | IRQ handler dispatch table (indexed by IRQ source × 4) |
| `0x0802FFD8` | (TBD) | Thumb function called by `sub_08000240` |
| `0x082F9010` | (TBD) | State flag read by `sub_08000240` |
