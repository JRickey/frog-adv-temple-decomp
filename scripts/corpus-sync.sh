#!/usr/bin/env bash
# scripts/corpus-sync.sh
#
# Clone or refresh a curated list of agbcc-era GBA decomp repos under
# ~/.cache/decomp-corpus/. Uses --filter=blob:none so we can walk commit
# history and read text blobs on-demand without dragging every binary
# asset across the network.
#
# Detects each repo's toolchain by grep'ing its Makefile and writes
# metadata to ~/.cache/decomp-corpus/.metadata.json. tools/agent/corpus.py
# consumes the metadata to filter by toolchain.
#
# Failures on a single repo are non-fatal: log, continue.

set -u
set -o pipefail

CACHE_DIR="${DECOMP_CORPUS_DIR:-$HOME/.cache/decomp-corpus}"
METADATA="$CACHE_DIR/.metadata.json"

# Curated list, highest-leverage first. Konami GBA + agbcc Pokemon decomps.
# Format: "owner/repo<TAB>one-line note"
REPOS=(
    "testyourmine/cvaos|Castlevania: Aria of Sorrow — Konami GBA, 2003 (same publisher + era as us)"
    "metroidret/mf|Metroid Fusion — agbcc GBA, 2002"
    "metroidret/mzm|Metroid Zero Mission — agbcc GBA, 2004"
    "pret/pokeruby|Pokemon Ruby — pret agbcc, idiom-dense"
    "pret/pokeemerald|Pokemon Emerald — pret agbcc"
    "pret/pokefirered|Pokemon FireRed — pret agbcc"
    "pret/pokepinballrs|Pokemon Pinball R/S — pret agbcc"
)
# NOTE on omissions: jiangzhengwenjz/{cvaos,cvhod} (both 404) and a public
# Castlevania: Harmony of Dissonance decomp do not exist on GitHub as of
# 2026-05-25. testyourmine/cvaos is the only public Konami-GBA decomp.

mkdir -p "$CACHE_DIR"

# Detect toolchain by grep'ing the repo's Makefile(s).
# Returns: "agbcc" | "other"
detect_toolchain() {
    local repo_dir="$1"
    # Look at the top-level Makefile and any Makefile in src/. We treat
    # the presence of the token "agbcc" anywhere in those files as a
    # strong signal — every pret/agbcc-targeted decomp invokes the
    # binary by that name.
    local hit
    hit=$(grep -lE 'agbcc' "$repo_dir"/Makefile "$repo_dir"/*.mk 2>/dev/null | head -1 || true)
    if [ -n "$hit" ]; then
        echo "agbcc"
    else
        echo "other"
    fi
}

# Emit a JSON object (single line) for one repo. Caller assembles the array.
emit_entry() {
    local slug="$1" note="$2" toolchain="$3" status="$4" path="$5" commit="$6"
    # Escape minimal JSON specials in note (just \ and ").
    local esc_note
    esc_note=$(printf '%s' "$note" | sed 's/\\/\\\\/g; s/"/\\"/g')
    printf '{"slug":"%s","note":"%s","toolchain":"%s","status":"%s","path":"%s","head":"%s"}' \
        "$slug" "$esc_note" "$toolchain" "$status" "$path" "$commit"
}

ENTRIES=()
TOTAL=${#REPOS[@]}
IDX=0
FAILURES=()

for line in "${REPOS[@]}"; do
    IDX=$((IDX + 1))
    slug="${line%%|*}"
    note="${line#*|}"
    repo_dir="$CACHE_DIR/${slug//\//__}"
    url="https://github.com/$slug.git"

    echo "[$IDX/$TOTAL] $slug"

    status="ok"
    if [ -d "$repo_dir/.git" ]; then
        if ! git -C "$repo_dir" fetch --quiet --filter=blob:none origin 2>&1 | sed 's/^/  fetch: /'; then
            echo "  fetch failed; keeping existing clone"
            status="stale"
            FAILURES+=("$slug (fetch)")
        fi
    else
        if ! git clone --quiet --filter=blob:none "$url" "$repo_dir" 2>&1 | sed 's/^/  clone: /'; then
            echo "  clone failed; skipping"
            FAILURES+=("$slug (clone)")
            ENTRIES+=("$(emit_entry "$slug" "$note" "unknown" "missing" "$repo_dir" "")")
            continue
        fi
    fi

    commit=$(git -C "$repo_dir" rev-parse HEAD 2>/dev/null || echo "")
    toolchain=$(detect_toolchain "$repo_dir")
    ENTRIES+=("$(emit_entry "$slug" "$note" "$toolchain" "$status" "$repo_dir" "$commit")")
done

# Write metadata file. Plain stdlib bash; build the JSON by hand.
{
    printf '{\n'
    printf '  "synced_at": "%s",\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf '  "cache_dir": "%s",\n' "$CACHE_DIR"
    printf '  "repos": [\n'
    last=$((${#ENTRIES[@]} - 1))
    for i in "${!ENTRIES[@]}"; do
        if [ "$i" -lt "$last" ]; then
            printf '    %s,\n' "${ENTRIES[$i]}"
        else
            printf '    %s\n' "${ENTRIES[$i]}"
        fi
    done
    printf '  ]\n'
    printf '}\n'
} >"$METADATA"

echo
echo "Wrote $METADATA"
du -sh "$CACHE_DIR" 2>/dev/null | sed 's/^/Total disk: /'

if [ ${#FAILURES[@]} -gt 0 ]; then
    echo "Failures: ${FAILURES[*]}"
    exit 0   # non-fatal — corpus.py can still query the repos that landed
fi
