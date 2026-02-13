#!/bin/bash
# Agent Agency Setup Script
# Copies agents and contexts to ~/.opencode/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCODE_DIR="$HOME/.opencode"

echo "🚀 Agent Agency Setup"
echo "━━━━━━━━━━━━━━━━━━━"

# Copy agents
echo "📋 Copying agents..."
mkdir -p "$OPENCODE_DIR/agents"
cp "$SCRIPT_DIR/.opencode/agents/"*.md "$OPENCODE_DIR/agents/"

# Copy scripts
echo "🔧 Copying scripts..."
mkdir -p "$OPENCODE_DIR/scripts"
cp "$SCRIPT_DIR/.opencode/scripts/"* "$OPENCODE_DIR/scripts/"
chmod +x "$OPENCODE_DIR/scripts/"*.sh 2>/dev/null || true
echo "📚 Copying contexts..."
mkdir -p "$OPENCODE_DIR/contexts"
cp "$SCRIPT_DIR/contexts/"*.md "$OPENCODE_DIR/contexts/"

# Copy subdirectory contexts with structure
for dir in "$SCRIPT_DIR/contexts"/*/; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        mkdir -p "$OPENCODE_DIR/contexts/$dirname"
        cp "$dir"*.md "$OPENCODE_DIR/contexts/$dirname/"
    fi
done

echo ""
echo "✅ Setup complete!"
echo ""
echo "Run with OpenCode:"
echo "  cd ~/projects/[project-name]"
echo "  opencode --agent development-manager"
echo ""
