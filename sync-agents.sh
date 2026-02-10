#!/bin/bash
# Sync Agent Agency agents to OpenCode
# Usage: ./sync-agents.sh

SOURCE_DIR="/home/dallum/projects/agent-agency/.opencode/agents"
TARGET_DIR="$HOME/.opencode/agents"

echo "Syncing agents from: $SOURCE_DIR"
echo "To: $TARGET_DIR"
echo ""

if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Source directory not found: $SOURCE_DIR"
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Error: Target directory not found: $TARGET_DIR"
    exit 1
fi

# Copy all agent files
cp -r "$SOURCE_DIR"/* "$TARGET_DIR/"

echo "✅ Agents synced successfully!"
echo ""
echo "Installed agents:"
ls -1 "$TARGET_DIR"/*.md 2>/dev/null | while read f; do
    echo "  - $(basename "$f" .md)"
done
