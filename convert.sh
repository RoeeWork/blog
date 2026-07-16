#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <obsidian-directory> <output-directory>"
    exit 1
fi

SOURCE="$(realpath "$1")"
DEST="$(realpath -m "$2")"

if [[ ! -d "$SOURCE" ]]; then
    echo "Error: '$SOURCE' is not a directory."
    exit 1
fi

# Never overwrite anything
if [[ -e "$DEST" ]]; then
    echo "Error: '$DEST' already exists."
    echo "Choose another output directory."
    exit 1
fi

echo "[*] Copying directory..."
mkdir -p "$(dirname "$DEST")"
cp -a "$SOURCE" "$DEST"

echo "[*] Converting Markdown files..."

find "$DEST" -type f -name "*.md" | while read -r file; do
    title="$(basename "$file" .md)"
    tmp="$(mktemp)"

    # Add Jekyll front matter if missing
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

        # ![[pics/image.png|alt text]]
        s{!\[\[(pics/[^|\]]+)\|([^\]]+)\]\]}{
            my $img = $1;
            $img =~ s/ /%20/g;
            "![$2]($img)";
        }eg;

        # ![[pics/image.png]]
        s{!\[\[(pics/[^\]]+)\]\]}{
            my $img = $1;
            $img =~ s/ /%20/g;
            "![]($img)";
        }eg;

        # ![[image.png|alt text]]
        s{!\[\[([^/|\]]+)\|([^\]]+)\]\]}{
            my $img = "pics/$1";
            $img =~ s/ /%20/g;
            "![$2]($img)";
        }eg;

        # ![[image.png]]
        s{!\[\[([^/|\]]+)\]\]}{
            my $img = "pics/$1";
            $img =~ s/ /%20/g;
            "![]($img)";
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

echo
echo "[✓] Conversion complete."
echo "Output:"
echo "  $DEST"
