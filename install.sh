#!/bin/bash

# Claude Code Art Gallery - Installer
# Install custom ASCII artwork for Claude Code startup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARTWORK_DIR="$SCRIPT_DIR/artwork"
CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
ART_FILE="$CLAUDE_DIR/custom-art.txt"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════╗"
echo "║  Claude Code Art Gallery - Installer     ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# Check if artwork directory exists
if [ ! -d "$ARTWORK_DIR" ]; then
    echo -e "${YELLOW}Error: Artwork directory not found!${NC}"
    exit 1
fi

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Function to list available artwork
list_artwork() {
    echo -e "${GREEN}Available Artwork:${NC}"
    echo ""
    local i=1
    for art in "$ARTWORK_DIR"/*.txt; do
        if [ -f "$art" ]; then
            local name=$(basename "$art" .txt)
            echo "  $i) $name"
            ((i++))
        fi
    done
    echo ""
}

# Function to preview artwork
preview_artwork() {
    local artwork_file="$1"
    echo -e "${BLUE}Preview:${NC}"
    echo ""
    cat "$artwork_file"
    echo ""
}

# Function to install artwork
install_artwork() {
    local artwork_file="$1"
    local artwork_name="$2"

    # Copy artwork to .claude directory
    cp "$artwork_file" "$ART_FILE"
    echo -e "${GREEN}✓ Artwork copied to $ART_FILE${NC}"

    # Configure SessionStart hook
    if [ -f "$SETTINGS_FILE" ]; then
        # Backup existing settings
        cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
        echo -e "${GREEN}✓ Backed up existing settings${NC}"
    fi

    # Create or update settings.json with SessionStart hook
    cat > "$SETTINGS_FILE" << EOF
{
  "hooks": {
    "SessionStart": [
      {
        "type": "command",
        "command": "cat $ART_FILE"
      }
    ]
  }
}
EOF

    echo -e "${GREEN}✓ Configured SessionStart hook${NC}"
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Installation Complete!                  ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════╝${NC}"
    echo ""
    echo "Artwork '$artwork_name' has been installed!"
    echo "It will display when you start Claude Code."
    echo ""
    echo "To change artwork later, run: ./switch-art.sh"
    echo ""
}

# Main installation logic
if [ -n "$1" ]; then
    # Artwork name provided as argument
    ARTWORK_FILE="$ARTWORK_DIR/$1.txt"

    if [ ! -f "$ARTWORK_FILE" ]; then
        echo -e "${YELLOW}Error: Artwork '$1' not found!${NC}"
        list_artwork
        exit 1
    fi

    preview_artwork "$ARTWORK_FILE"
    install_artwork "$ARTWORK_FILE" "$1"
else
    # Interactive mode
    list_artwork

    echo -e "${YELLOW}Enter artwork name (or number):${NC} "
    read -r selection

    # Check if selection is a number
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        # Get artwork by number
        artwork_files=("$ARTWORK_DIR"/*.txt)
        index=$((selection - 1))

        if [ $index -lt 0 ] || [ $index -ge ${#artwork_files[@]} ]; then
            echo -e "${YELLOW}Error: Invalid selection!${NC}"
            exit 1
        fi

        ARTWORK_FILE="${artwork_files[$index]}"
        ARTWORK_NAME=$(basename "$ARTWORK_FILE" .txt)
    else
        # Get artwork by name
        ARTWORK_FILE="$ARTWORK_DIR/$selection.txt"
        ARTWORK_NAME="$selection"

        if [ ! -f "$ARTWORK_FILE" ]; then
            echo -e "${YELLOW}Error: Artwork '$selection' not found!${NC}"
            exit 1
        fi
    fi

    preview_artwork "$ARTWORK_FILE"

    echo -e "${YELLOW}Install this artwork? (y/n):${NC} "
    read -r confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        install_artwork "$ARTWORK_FILE" "$ARTWORK_NAME"
    else
        echo "Installation cancelled."
    fi
fi
