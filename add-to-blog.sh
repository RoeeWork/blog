#!/usr/bin/env bash
#
# add-to-blog.sh — incrementally add/update a CTF writeup from Obsidian
# into the Jekyll blog, without touching existing posts or the vault.
#
# Usage:
#   ./add-to-blog.sh <obsidian-source> <blog-root>
#
#   <obsidian-source>  Either:
#                         - a single writeup .md file, e.g.
#                           ~/vault/CTF/OverTheWire/Bandit/bandit10.md
#                         - or a whole category directory, e.g.
#                           ~/vault/CTF/OverTheWire/Bandit
#                       Must live somewhere under a "CTF" folder in the vault.
#   <blog-root>         Path to the blog repo root (the dir containing ctf/).
#
# Examples:
#   # Add a single new writeup (and its pics, if it has its own pics/ dir)
#   ./add-to-blog.sh ~/vault/CTF/OverTheWire/Bandit/bandit10.md ~/code/blog
#
#   # Re-sync a whole category (adds new writeups, updates edited ones,
#   # merges in any new pics) — existing files are never deleted.
#   ./add-to-blog.sh ~/vault/CTF/OverTheWire/Bandit ~/code/blog
#
# Guarantees:
#   - The Obsidian vault is NEVER modified (we only ever read from it,
#     and do all conversion in a scratch temp dir).
#   - Existing files already in the blog are never deleted. Existing
#     pics are never overwritten (cp -n / no-clobber merge). Re-running
#     on a writeup you already added will refresh that one .md file
#     (handy if you edited it) but leave everything else alone.

set -euo pipefail

usage() {
    echo "Usage: $0 <obsidian-source> <blog-root>"
    exit 1
}

[[ $# -eq 2 ]] || usage

SOURCE="$(realpath "$1")"
BLOG_ROOT="$(realpath "$2")"

[[ -e "$SOURCE" ]] || { echo "Error: '$SOURCE' does not exist."; exit 1; }
[[ -d "$BLOG_ROOT/ctf" ]] || { echo "Error: '$BLOG_ROOT/ctf' not found — is '$BLOG_ROOT' really the blog root?"; exit 1; }

# ------------------------------------------------------------------
# Work out where this maps to under blog/ctf/, based on the source's
# path relative to the "CTF" folder in the vault.
#   .../CTF/OverTheWire/Bandit/bandit10.md -> ctf/overthewire/bandit
# ------------------------------------------------------------------
case "$SOURCE" in
    */CTF/*) REL="${SOURCE#*/CTF/}" ;;
    *)
        echo "Error: source must live somewhere under a 'CTF' directory in the vault."
        exit 1
        ;;
esac

if [[ -f "$SOURCE" ]]; then
    SRC_DIR="$(dirname "$SOURCE")"
    REL_DIR="$(dirname "$REL")"
else
    SRC_DIR="$SOURCE"
    REL_DIR="$REL"
fi

DEST_REL="$(echo "$REL_DIR" | tr '[:upper:]' '[:lower:]')"
DEST_DIR="$BLOG_ROOT/ctf/$DEST_REL"
PICS_PATH="ctf/$DEST_REL"

echo "[*] Source:      $SOURCE"
echo "[*] Blog target: $DEST_DIR"

mkdir -p "$DEST_DIR"

# ------------------------------------------------------------------
# Scratch copy — all conversion happens here. The vault is only ever
# read from, never written to.
# ------------------------------------------------------------------
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

if [[ -f "$SOURCE" ]]; then
    cp -a "$SOURCE" "$WORK/"
    [[ -d "$SRC_DIR/pics" ]] && cp -a "$SRC_DIR/pics" "$WORK/"
else
    cp -a "$SRC_DIR/." "$WORK/"
fi

echo "[*] Converting Markdown..."

export PICS_PATH

find "$WORK" -maxdepth 1 -type f -name "*.md" | while read -r file; do
    title="$(basename "$file" .md)"
    tmp="$(mktemp)"

    if ! head -n1 "$file" | grep -q '^---$'; then
        {
            echo "---"
            echo "layout: post"
            echo "title: \"$title\""
            echo "---"
            echo
        } > "$tmp"
    fi

    perl -pe '
        # ------------------------------------------------
        # Obsidian images
        # ------------------------------------------------

        # ![[pics/image.png|alt text]]  or  ![[image.png|alt text]]
        # (an optional literal "pics/" in the source is stripped and
        # always re-added below — every image ends up in pics/ in the
        # output regardless of how the Obsidian link was written)
        s{!\[\[(?:pics/)?([^|\]]+)\|([^\]]+)\]\]}{
            my $img = $1;
            my $alt = $2;
            $img =~ s/ /%20/g;
            "![$alt]({{ '\''/$ENV{PICS_PATH}/'\'' . '\''pics/$img'\'' | relative_url }})";
        }eg;

        # ![[pics/image.png]]  or  ![[image.png]]
        s{!\[\[(?:pics/)?([^\]]+)\]\]}{
            my $img = $1;
            $img =~ s/ /%20/g;
            "![]({{ '\''/$ENV{PICS_PATH}/'\'' . '\''pics/$img'\'' | relative_url }})";
        }eg;

        # ------------------------------------------------
        # Obsidian wiki links
        # ------------------------------------------------

        # [[page|alias]]
        s{\[\[([^|\]]+)\|([^\]]+)\]\]}{
            "[$2]($1.md)";
        }eg;

        # [[page]]
        s{\[\[([^\]]+)\]\]}{
            "[$1]($1.md)";
        }eg;
    ' "$file" >> "$tmp"

    mv "$tmp" "$file"
done

echo "[*] Merging into blog (existing files are left untouched)..."

# .md files: copy in, overwriting only a file of the *same name* (i.e.
# re-adding the same writeup refreshes it — other writeups are untouched).
find "$WORK" -maxdepth 1 -type f -name "*.md" -exec cp -a {} "$DEST_DIR/" \;

# pics: merge, never clobbering an existing pic with the same name.
if [[ -d "$WORK/pics" ]]; then
    mkdir -p "$DEST_DIR/pics"
    cp -an "$WORK/pics/." "$DEST_DIR/pics/"
fi

echo "[*] Updating index.markdown files..."

# ensure_index <dir> <permalink> <title>
#   Creates <dir>/index.markdown with the given title/permalink if it
#   doesn't already exist. Never touches an existing index.
ensure_index() {
    local dir="$1" permalink="$2" title="$3" idx
    idx="$dir/index.markdown"
    if [[ ! -f "$idx" ]]; then
        mkdir -p "$dir"
        {
            echo "---"
            echo "layout: page"
            echo "title: \"$title\""
            echo "permalink: $permalink"
            echo "---"
            echo
        } > "$idx"
        echo "[+] Created $idx"
    fi
}

# add_link_if_missing <index-file> <link-text> <permalink>
#   Appends a bullet linking to <permalink> unless a link to that exact
#   permalink is already present (safe to re-run — no duplicates).
add_link_if_missing() {
    local idx="$1" text="$2" permalink="$3" bare pattern
    [[ -f "$idx" ]] || return
    # Match with or without a trailing slash (older hand-written links in
    # this repo sometimes omit it), but anchor on the closing quote so
    # e.g. ".../bandit/" doesn't spuriously match ".../bandit10/".
    bare="${permalink%/}"
    pattern="${bare}/?'"
    if ! grep -qE "$pattern" "$idx"; then
        echo "- [$text]({{ '$permalink' | relative_url }})" >> "$idx"
        echo "[+] Linked '$text' -> $permalink in $idx"
    fi
}

# Capitalize just the first character (portable — no bash-4-only ${x^}).
cap_first() {
    local s="$1"
    printf '%s%s' "$(printf '%s' "${s:0:1}" | tr '[:lower:]' '[:upper:]')" "${s:1}"
}

# Walk down from blog/ctf/ to the leaf category dir, e.g. for
# REL_DIR="OverTheWire/Bandit": ensures ctf/overthewire/index.markdown
# and ctf/overthewire/bandit/index.markdown exist, and links each one
# from its parent's index — using the vault's own capitalization
# (OverTheWire, Bandit) as the link text.
IFS='/' read -ra COMPONENTS <<< "$REL_DIR"

CUR_DIR="$BLOG_ROOT/ctf"
CUR_PERMALINK="/ctf/"

for comp in "${COMPONENTS[@]}"; do
    lower_comp="$(echo "$comp" | tr '[:upper:]' '[:lower:]')"
    NEXT_DIR="$CUR_DIR/$lower_comp"
    NEXT_PERMALINK="${CUR_PERMALINK}${lower_comp}/"

    ensure_index "$NEXT_DIR" "$NEXT_PERMALINK" "$comp"
    add_link_if_missing "$CUR_DIR/index.markdown" "$comp" "$NEXT_PERMALINK"

    CUR_DIR="$NEXT_DIR"
    CUR_PERMALINK="$NEXT_PERMALINK"
done

# CUR_DIR / CUR_PERMALINK now point at the leaf category dir (e.g.
# .../ctf/overthewire/bandit, /ctf/overthewire/bandit/). Link every
# writeup we just converted — harmless to re-list ones already there.
while read -r f; do
    fname="$(basename "$f" .md)"
    entry_text="$(cap_first "$fname")"           # bandit10 -> Bandit10
    entry_permalink="${CUR_PERMALINK}${fname}/"
    add_link_if_missing "$CUR_DIR/index.markdown" "$entry_text" "$entry_permalink"
done < <(find "$WORK" -maxdepth 1 -type f -name "*.md")

echo
echo "[✓] Done."
echo "    Added/updated: $DEST_DIR"
[[ -d "$WORK/pics" ]] && echo "    Pics merged into: $DEST_DIR/pics (existing pics untouched)"
