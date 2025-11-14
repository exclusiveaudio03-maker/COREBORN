extends Node
@export var version: String = "0.1.0"
var save_file_path := "user://save_game.json"

var save_data := {
	"chapter": "CH1",
	"completed_missions": [],
	"choices": {},
	"reputation": {"government":0,"corebreakers":0,"scientists":0,"military":0},
	"resources": {"titan_oil":0, "nanite_scrap":0}
}

signal saved()

func _ready():
	# auto-load saved state if present
	load()

func save() -> void:
	var f = FileAccess.open(save_file_path, FileAccess.ModeFlags.WRITE)
	if f:
		f.store_string(JSON.print(save_data))
		f.close()
		emit_signal("saved")

func load() -> bool:
	if not FileAccess.file_exists(save_file_path):
		return false
	var f = FileAccess.open(save_file_path, FileAccess.ModeFlags.READ)
	if not f:
		return false
	var res = JSON.parse_string(f.get_as_text())
	f.close()
	if res.error != OK:
		return false
	save_data = res.result
	return true

func set_choice(id:String, value) -> void:
	save_data["choices"][id] = value
	save()
