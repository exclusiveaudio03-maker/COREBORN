# Coreborn Engine (Godot 4.2.2) - Mobile-first skeleton

## Quick start
1. Paste files into repo (done).
2. Open the project in Godot 4.2.2 (desktop) to register autoloads and run.
   - Register autoloads: Project -> Project Settings -> AutoLoad:
     - GameState -> res://scripts/autoload/GameState.gd
     - ChoiceManager -> res://scripts/autoload/ChoiceManager.gd
     - ArcManager -> res://scripts/autoload/ArcManager.gd
     - InputManager -> res://scripts/autoload/InputManager.gd
3. Ensure `res_coreborn.json` is at project root.
4. Run `scenes/main.tscn`.

## HTML5 export
- Use Godot 4.2.2 desktop to export to HTML5.
- Make sure export templates are installed.
- Open `Project -> Export` -> select the HTML5 preset (or import `export_presets.cfg`).
- Export to `export/html5/` and upload files to GitHub Pages or a static host.

## Mobile import/export (WPA)
- Use `tools/export_wpa.gd` to prepare an export folder on device.
- For zipping on device use a small ZIP plugin or unzip on desktop and copy files to phone.
