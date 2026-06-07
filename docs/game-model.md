# Game model — Frogger's Adventures: Temple of the Frog

High-level design of the game, for **coloring the data** (turning `_field_NN` /
`gIwram_XXXX` into semantic names). Source: project owner's description
(2026-06-07). Mark anything inferred-from-code as `(inferred)`.

## What the game is
A **2D top-down grid maze** game. The player pilots Frogger through discrete
grid levels, one tile at a time.

## Structure
- **5 worlds**, **3 levels each** (15 levels total).
- Per world, the three levels are:
  1. **Collect 3 orbs**, then reach the exit.
  2. **Collect 5 orbs**, then reach the exit.
  3. **Boss level** — different success mechanics per world. Final world's boss:
     Frogger must have collected **50 coins**.

## Controls & movement (grid-based)
- **D-pad**: move one tile up / down / left / right (no diagonals).
- **L / R**: rotate Frogger's **facing** (counter/clockwise).
- **A (jump)**: hop **2 tiles** in the current facing direction, skipping over
  the first tile (clears a pit; but jumping over **active spikes kills him**).
- **B (tongue)**: extend tongue **1 tile in front** of facing to collect a
  **butterfly** that sits on a tile Frogger can't stand on.
- Frogger **must always occupy a tile**: if he leaves a **moving tile**, he is
  vacuumed to be centered on a single tile.

→ (inferred) This explains the **8 move opcodes** seen at the entity move-state
  byte: 4 directions × {step 1 tile, jump 2 tiles}. Tongue and rotate are likely
  their own states/opcodes.

## Entities, hazards, collectibles
- **Enemies**: move in **preprogrammed patterns on a loop** (not reactive AI).
  → (inferred) the per-entity "MotionDesc" (dx/dy/mode) + a looping path/pattern.
- **Hazards**: spikes (toggle active/inactive), pits, anything that kills on
  contact. Falling off the stage also kills.
- **Collectibles**: **butterflies**, **coins**, **orbs**.
- **Checkpoint** tile: respawn point; Frogger respawns there on death.
- **Moving tiles**: platforms that carry Frogger; leaving one re-centers him.

## Death / lives
- Death on: any hazard contact, or falling off the stage.
- **Lives** + **continues** system. Death → respawn at last checkpoint (or
  level start) until lives run out.

## Mapping onto known data (decomp ↔ game) — (inferred unless noted)
- **Grid unit = 24**: entity X/Y are sub-coordinates; `coord / 24` = tile index
  (the `*24` / `/24` math throughout). A tile is 24 units. (verify exact unit.)
- **Entity pool** `gEntities[128]` (0x03003720, 0x38 stride): `field_00` =
  kind/type byte; `x`/`y` (+2/+4) = sub-coords; `field_06` = active actor id;
  `field_0A` = entity-type id (keys the sEntityProc* tables); `field_1A` = move
  opcode / dispatch state (the 4..11 directional move opcodes); `field_1B` =
  active-entity count (slot 0 only); `field_24/26` = AABB half-extents (collision
  box); `field_2A/30/31/32` = MotionDesc (sel / dx / dy / mode = movement);
  `status` (+0x34) = flag bits (0x04/0x08/0x40/0x8000).
- **Player = entity slot 0** ("the player header"); other slots are
  enemies/objects/collectibles.
- **`gGameStuff`** (0x03005330): `mode` = top-level GameMode; `pendingMode` =
  scene/level-type id (keys sEntityProc*); `rngSeed`; `_unk0C` = unlocked-worlds
  bitmap (→ the 5 worlds); `_step24` = attract-cycle counter.
- **`gIwram_35E0`** = player move/input scratch: tile coords (`_field_8/_A`),
  entity tile coords (`_field_18/19`), latched target id (`_field_1A`),
  committed move-destination tile (`_field_1C/1E`), flags (`_field_10`: bit
  0x40 = tile-coords-changed, 0x02/0x04 = collision/hop flags), collided
  id/kind (`_field_C/D`).
- **`gIwram_6110`** (ModeControl): `liveCount`, `state`, `spawnMask`,
  `flagBank0/1` (event/collision flag banks, init -1), `configTable` (per-state
  spawn-record table), `threshold`, `limit`.

## Open questions (to resolve before deep naming)
- Exact direction encoding (bitmask 1/2/4/8 = U/D/L/R, or index 0-3?).
- Full enemy/object **type** enumeration (to name the entity-type byte + the
  17-entry sEntityProc* dispatch tables — is that index the level/scene, the
  entity type, or the game mode?).
- Where the HUD counters live (orbs collected, coins, butterflies, lives,
  continues) and the per-level goal (3-orb / 5-orb / boss-kind).
