#!/bin/bash

# Kubernetes SRE Agent Installation Script for OpenCode
# This script installs the k8s-sre agent either globally or project-specific

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AGENT_FILE="$SCRIPT_DIR/k8s-sre.md"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║   Kubernetes SRE Agent Installer for OpenCode            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if OpenCode is installed
if ! command -v opencode &> /dev/null; then
    echo -e "${RED}Error: OpenCode is not installed or not in PATH${NC}"
    echo "Please install OpenCode first: https://opencode.ai"
    exit 1
fi

echo -e "${GREEN}✓ OpenCode found${NC}"

# Check if kubectl is installed (warning, not error)
if ! command -v kubectl &> /dev/null; then
    echo -e "${YELLOW}⚠ Warning: kubectl is not installed or not in PATH${NC}"
    echo "The agent requires kubectl to function properly."
    echo "You can continue installation and install kubectl later."
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
else
    echo -e "${GREEN}✓ kubectl found${NC}"
fi

# Check if agent file exists
if [ ! -f "$AGENT_FILE" ]; then
    echo -e "${RED}Error: Agent file not found at $AGENT_FILE${NC}"
    echo "Please ensure you're running this script from the k8s-sre-agent directory"
    exit 1
fi

echo ""
echo "Where would you like to install the k8s-sre agent?"
echo ""
echo "  1) Global installation (~/.config/opencode/agent/)"
echo "     Available in all OpenCode projects on this machine"
echo ""
echo "  2) Project-specific installation (./.opencode/agent/)"
echo "     Available only in the current directory"
echo ""

# Default to global if no input
read -p "Enter choice (1 or 2) [default: 1]: " choice
choice=${choice:-1}

case $choice in
    1)
        INSTALL_DIR="$HOME/.config/opencode/agent"
        INSTALL_TYPE="global"
        ;;
    2)
        INSTALL_DIR="$(pwd)/.opencode/agent"
        INSTALL_TYPE="project-specific"
        ;;
    *)
        echo -e "${RED}Invalid choice. Please enter 1 or 2.${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}Installing to: $INSTALL_DIR${NC}"
echo ""

# Create directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Copy the agent file
cp "$AGENT_FILE" "$INSTALL_DIR/"

# Check if installation was successful
if [ -f "$INSTALL_DIR/k8s-sre.md" ]; then
    echo -e "${GREEN}✓ Agent file copied successfully${NC}"
else
    echo -e "${RED}Error: Failed to copy agent file${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Verifying installation...${NC}"
echo ""

# Verify the agent is listed
if opencode agent list | grep -q "k8s-sre"; then
    echo -e "${GREEN}✓ Agent registered successfully!${NC}"
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║           Installation Completed Successfully!           ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
else
    echo -e "${YELLOW}⚠ Warning: Agent file installed but not showing in list${NC}"
    echo "This might be normal if you're in a different directory."
    echo "Try running: opencode agent list"
fi

echo ""
echo -e "${BLUE}Installation Details:${NC}"
echo -e "  Type: ${YELLOW}$INSTALL_TYPE${NC}"
echo -e "  Location: ${YELLOW}$INSTALL_DIR/k8s-sre.md${NC}"
echo ""

echo -e "${BLUE}Quick Start:${NC}"
echo ""
echo -e "  Launch the agent:"
echo -e "    ${YELLOW}opencode --agent k8s-sre${NC}"
echo ""
echo -e "  Launch with a task:"
echo -e "    ${YELLOW}opencode --agent k8s-sre -p \"Debug my crashing pod\"${NC}"
echo ""
echo -e "  List all agents:"
echo -e "    ${YELLOW}opencode agent list${NC}"
echo ""

echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "  1. Verify kubectl is configured with your cluster:"
echo -e "     ${YELLOW}kubectl config get-contexts${NC}"
echo ""
echo "  2. Launch the agent and start troubleshooting:"
echo -e "     ${YELLOW}opencode --agent k8s-sre${NC}"
echo ""
echo "  3. Read the full documentation:"
echo -e "     ${YELLOW}cat $SCRIPT_DIR/README.md${NC}"
echo ""

if [ "$INSTALL_TYPE" = "project-specific" ]; then
    echo -e "${YELLOW}Note: This is a project-specific installation.${NC}"
    echo "The agent will only be available when running OpenCode from:"
    echo "  $(pwd)"
    echo ""
fi

echo -e "${GREEN}Happy Debugging! 🚀${NC}"
echo ""
