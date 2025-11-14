extends Node

func _load_exoskel() -> Dictionary:
	var path := "res://res_coreborn.json"
	if not FileAccess.file_exists(path):
		push_warning("res_coreborn.json not found in project root.")
		return {}
	var f = FileAccess.open(path, FileAccess.ModeFlags.READ)
	var data = JSON.parse_string(f.get_as_text()).result
	f.close()
	return data.get("story", {})

func get_chapters() -> Array:
	var s = _load_exoskel()
	return s.get("chapters", [])

func get_missions_for(chapter_id:String) -> Array:
	for ch in get_chapters():
		if ch.get("id", "") == chapter_id:
			return ch.get("missions", [])
	return []
