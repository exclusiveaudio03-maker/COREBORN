extends Node

@export var version: String = "0.1"
var save_file := "user://save_game.json"

var state := {
	"player_id": "player_001",
	"position": Vector3.ZERO,
	"rotation": Vector3.ZERO,
	"inventory": {},
	"choices": {},
	"reputation": {"gov":0,"core":0,"sci":0}
}

signal saved()
signal loaded()

func _ready():
	# attempt to load
	load()
	
func save() -> void:
	var f = FileAccess.open(save_file, FileAccess.ModeFlags.WRITE)
	if f:
		f.store_string(JSON.print(state))
		f.close()
		emit_signal("saved")

func load() -> bool:
	if not FileAccess.file_exists(save_file):
		return false
	var f = FileAccess.open(save_file, FileAccess.ModeFlags.READ)
	if not f:
		return false
	var res = JSON.parse_string(f.get_as_text())
	f.close()
	if res.error != OK:
		return false
	state = res.result
	emit_signal("loaded")
	return true

func set_choice(key:String, value) -> void:
	state["choices"][key] = value
	save()
