extends Node

const SAVE_PATH := "user://settings.json"
var settings = {
	"graphics": {
		"fullscreen": false,
		"render_scale": 1.0,
		"vfx_enabled": true
	},
	"audio": {
		"master": 1.0,
		"sfx": 1.0,
		"music": 1.0
	},
	"controls": {
		"sensitivity": 1.0,
		"invert_y": false
	},
	"gameplay": {
		"language": "English",
		"difficulty": "Normal"
	}
}

func _ready():
	load_settings()

func save_settings():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(settings))
	file.close()

func load_settings():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	if data is Dictionary:
		settings = data
	file.close()
