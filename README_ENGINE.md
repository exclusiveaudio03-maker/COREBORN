# Coreborn Engine Skeleton (Godot 4.2.2)

## What this contains
- 3rd-person controller (Player3P)
- 1st-person controller (PlayerFP)
- Turn-based combat manager
- MMO Manager scaffold (offline-first)
- Interaction system and global GameState

## Quick start
1. Add autoloads in Project -> Project Settings -> AutoLoad:
   - GameState -> res://scripts/autoload/GameState.gd
   - MMOManager -> res://scripts/autoload/MMOManager.gd
   - TurnBasedCombat -> res://scripts/combat/TurnBasedCombat.gd  (optional)
2. Open `scenes/main.tscn`
3. Run the scene in Godot desktop to test movement and camera
4. Use `MMOManager` later to plug real server sync

## Notes
- This is a prototype skeleton — you must flesh out animations, refined physics, UI, and network code.
- Exporting to HTML5 requires Godot export templates and will produce coreborn.js/.wasm/.pck (not included).
