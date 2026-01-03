#!/bin/bash

# Claude Code Art Gallery - Artwork Switcher
# Easily switch between different ASCII artworks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARTWORK_DIR="$SCRIPT_DIR/artwork"
CLAUDE_DIR="$HOME/.claude"
ART_FILE="$CLAUDE_DIR/custom-art.txt"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════╗"
echo "║  Claude Code Art Gallery - Switcher      ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# Check current artwork
if [ -f "$ART_FILE" ]; then
    echo -e "${GREEN}Current artwork installed ✓${NC}"
    echo ""
fi

# Function to list available artwork with previews
list_artwork() {
    echo -e "${BLUE}Available Artwork:${NC}"
    echo ""

    local i=1
    for art in "$ARTWORK_DIR"/*.txt; do
        if [ -f "$art" ]; then
            local name=$(basename "$art" .txt)
            echo -e "${YELLOW}$i) $name${NC}"
            ((i++))
        fi
    done

    # Check for community submissions
    if [ -d "$ARTWORK_DIR/community-submissions" ] && [ "$(ls -A $ARTWORK_DIR/community-submissions/*.txt 2>/dev/null)" ]; then
        echo ""
        echo -e "${CYAN}Community Submissions:${NC}"
        for art in "$ARTWORK_DIR/community-submissions"/*.txt; do
            if [ -f "$art" ]; then
                local name=$(basename "$art" .txt)
                echo -e "${YELLOW}$i) community/$name${NC}"
                ((i++))
            fi
        done
    fi

    echo ""
}

# Function to preview artwork
preview_artwork() {
    local artwork_file="$1"
    echo ""
    echo -e "${BLUE}╔═══ Preview ═══╗${NC}"
    cat "$artwork_file"
    echo -e "${BLUE}╚═══════════════╝${NC}"
    echo ""
}

# Function to switch artwork
switch_artwork() {
    local artwork_file="$1"
    local artwork_name="$2"

    cp "$artwork_file" "$ART_FILE"

    echo -e "${GREEN}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  Artwork Switched!                       ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════╝${NC}"
    echo ""
    echo "Now using: $artwork_name"
    echo "Restart Claude Code to see your new artwork!"
    echo ""
}

# Main logic
list_artwork

echo -e "${YELLOW}Enter artwork name or number (or 'p' to preview):${NC} "
read -r selection

# Preview mode
if [[ "$selection" == "p" ]] || [[ "$selection" == "P" ]]; then
    echo -e "${YELLOW}Enter artwork to preview:${NC} "
    read -r preview_selection

    # Handle number or name
    if [[ "$preview_selection" =~ ^[0-9]+$ ]]; then
        artwork_files=("$ARTWORK_DIR"/*.txt "$ARTWORK_DIR/community-submissions"/*.txt 2>/dev/null)
        index=$((preview_selection - 1))

        if [ $index -lt 0 ] || [ $index -ge ${#artwork_files[@]} ]; then
            echo -e "${YELLOW}Error: Invalid selection!${NC}"
            exit 1
        fi

        ARTWORK_FILE="${artwork_files[$index]}"
    else
        # Check main directory first
        if [ -f "$ARTWORK_DIR/$preview_selection.txt" ]; then
            ARTWORK_FILE="$ARTWORK_DIR/$preview_selection.txt"
        elif [ -f "$ARTWORK_DIR/community-submissions/$preview_selection.txt" ]; then
            ARTWORK_FILE="$ARTWORK_DIR/community-submissions/$preview_selection.txt"
        else
            echo -e "${YELLOW}Error: Artwork not found!${NC}"
            exit 1
        fi
    fi

    preview_artwork "$ARTWORK_FILE"

    echo -e "${YELLOW}Install this artwork? (y/n):${NC} "
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        ARTWORK_NAME=$(basename "$ARTWORK_FILE" .txt)
        switch_artwork "$ARTWORK_FILE" "$ARTWORK_NAME"
    else
        echo "Cancelled."
    fi
else
    # Direct installation mode
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        # Get artwork by number
        artwork_files=("$ARTWORK_DIR"/*.txt)

        # Include community submissions if they exist
        if [ -d "$ARTWORK_DIR/community-submissions" ]; then
            for art in "$ARTWORK_DIR/community-submissions"/*.txt; do
                [ -f "$art" ] && artwork_files+=("$art")
            done
        fi

        index=$((selection - 1))

        if [ $index -lt 0 ] || [ $index -ge ${#artwork_files[@]} ]; then
            echo -e "${YELLOW}Error: Invalid selection!${NC}"
            exit 1
        fi

        ARTWORK_FILE="${artwork_files[$index]}"
        ARTWORK_NAME=$(basename "$ARTWORK_FILE" .txt)
    else
        # Get artwork by name
        if [ -f "$ARTWORK_DIR/$selection.txt" ]; then
            ARTWORK_FILE="$ARTWORK_DIR/$selection.txt"
        elif [ -f "$ARTWORK_DIR/community-submissions/$selection.txt" ]; then
            ARTWORK_FILE="$ARTWORK_DIR/community-submissions/$selection.txt"
        else
            echo -e "${YELLOW}Error: Artwork '$selection' not found!${NC}"
            exit 1
        fi
        ARTWORK_NAME="$selection"
    fi

    preview_artwork "$ARTWORK_FILE"
    switch_artwork "$ARTWORK_FILE" "$ARTWORK_NAME"
fi
