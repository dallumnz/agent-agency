# MCP Decision — Tabled

**Date:** 2026-02-13
**Status:** Deferred

## Original Rationale
- Persistent context across sessions via MCP server
- Tool discovery for agents
- State management

## Current Implementation
- MCP wrapper calls Python scripts → writes files
- Tools misnamed (agents can't discover)
- More complexity, more failure points

## Decision
**Deferred** — Use bash commands directly for now.

- Bash works reliably
- No MCP overhead
- Revisit when there's an actual need for complex tool interactions

## Items to Revisit
- Fix MCP persistent server
- Proper tool naming convention
- Context/state management for handoffs
