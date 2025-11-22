#!/bin/bash

# Kubernetes SRE Agent Uninstallation Script for OpenCode
# This script removes the k8s-sre agent from your system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║   Kubernetes SRE Agent Uninstaller for OpenCode          ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check for installations
GLOBAL_AGENT="$HOME/.config/opencode/agent/k8s-sre.md"
LOCAL_AGENT="$(pwd)/.opencode/agent/k8s-sre.md"

FOUND_GLOBAL=false
FOUND_LOCAL=false

if [ -f "$GLOBAL_AGENT" ]; then
    FOUND_GLOBAL=true
fi

if [ -f "$LOCAL_AGENT" ]; then
    FOUND_LOCAL=true
fi

# If no installations found
if [ "$FOUND_GLOBAL" = false ] && [ "$FOUND_LOCAL" = false ]; then
    echo -e "${YELLOW}No k8s-sre agent installations found.${NC}"
    echo ""
    echo "Checked locations:"
    echo "  - Global: $GLOBAL_AGENT"
    echo "  - Local:  $LOCAL_AGENT"
    echo ""
    exit 0
fi

# Show found installations
echo "Found k8s-sre agent installation(s):"
echo ""

if [ "$FOUND_GLOBAL" = true ]; then
    echo -e "  ${GREEN}✓${NC} Global: $GLOBAL_AGENT"
fi

if [ "$FOUND_LOCAL" = true ]; then
    echo -e "  ${GREEN}✓${NC} Local:  $LOCAL_AGENT"
fi

echo ""
echo "What would you like to remove?"
echo ""

# Build menu based on what was found
MENU_OPTION=1
declare -A OPTIONS

if [ "$FOUND_GLOBAL" = true ]; then
    echo "  $MENU_OPTION) Global installation only"
    OPTIONS[$MENU_OPTION]="global"
    ((MENU_OPTION++))
fi

if [ "$FOUND_LOCAL" = true ]; then
    echo "  $MENU_OPTION) Local installation only"
    OPTIONS[$MENU_OPTION]="local"
    ((MENU_OPTION++))
fi

if [ "$FOUND_GLOBAL" = true ] && [ "$FOUND_LOCAL" = true ]; then
    echo "  $MENU_OPTION) Both installations"
    OPTIONS[$MENU_OPTION]="both"
    ((MENU_OPTION++))
fi

echo "  $MENU_OPTION) Cancel"
OPTIONS[$MENU_OPTION]="cancel"

echo ""
read -p "Enter choice: " choice

# Validate choice
if [ -z "${OPTIONS[$choice]}" ]; then
    echo -e "${RED}Invalid choice${NC}"
    exit 1
fi

SELECTED="${OPTIONS[$choice]}"

if [ "$SELECTED" = "cancel" ]; then
    echo "Uninstallation cancelled."
    exit 0
fi

# Confirm deletion
echo ""
echo -e "${YELLOW}⚠  This will permanently remove the k8s-sre agent configuration.${NC}"
read -p "Are you sure? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Uninstallation cancelled."
    exit 0
fi

echo ""
echo -e "${BLUE}Removing agent...${NC}"
echo ""

# Perform removal
REMOVED=false

if [ "$SELECTED" = "global" ] || [ "$SELECTED" = "both" ]; then
    if [ -f "$GLOBAL_AGENT" ]; then
        rm "$GLOBAL_AGENT"
        echo -e "${GREEN}✓ Removed global installation${NC}"
        echo "  Deleted: $GLOBAL_AGENT"
        REMOVED=true
    fi
fi

if [ "$SELECTED" = "local" ] || [ "$SELECTED" = "both" ]; then
    if [ -f "$LOCAL_AGENT" ]; then
        rm "$LOCAL_AGENT"
        echo -e "${GREEN}✓ Removed local installation${NC}"
        echo "  Deleted: $LOCAL_AGENT"
        REMOVED=true

        # Optionally remove the .opencode/agent directory if empty
        if [ -d "$(pwd)/.opencode/agent" ] && [ -z "$(ls -A $(pwd)/.opencode/agent)" ]; then
            rmdir "$(pwd)/.opencode/agent"
            echo -e "${GREEN}✓ Removed empty agent directory${NC}"
        fi
    fi
fi

if [ "$REMOVED" = true ]; then
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║         Uninstallation Completed Successfully!           ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Verify removal
    if ! opencode agent list 2>/dev/null | grep -q "k8s-sre"; then
        echo -e "${GREEN}✓ Agent no longer appears in the agent list${NC}"
    else
        echo -e "${YELLOW}⚠ Agent still appears in list (may need to restart OpenCode)${NC}"
    fi
else
    echo -e "${YELLOW}No files were removed${NC}"
fi

echo ""
echo -e "${BLUE}To reinstall the agent:${NC}"
echo -e "  ${YELLOW}./install.sh${NC}"
echo ""
