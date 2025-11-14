extends Node
const SAVE_PATH := "user://inventory.save"

var items := {} # item_id -> count

signal inventory_changed()

func add_item(item_id:String, amount:int=1) -> void:
	items[item_id] = items.get(item_id,0) + amount
	emit_signal("inventory_changed")
	save()

func remove_item(item_id:String, amount:int=1) -> bool:
	if items.get(item_id,0) < amount:
		return false
	items[item_id] -= amount
	if items[item_id] <= 0:
		items.erase(item_id)
	emit_signal("inventory_changed")
	save()
	return true

func get_count(item_id:String) -> int:
	return items.get(item_id,0)

func save() -> void:
	var f = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.WRITE)
	if f:
		f.store_string(JSON.print(items))
		f.close()

func load() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.READ)
	if f:
		var res = JSON.parse_string(f.get_as_text())
		if res.error == OK:
			items = res.result
		f.close()
