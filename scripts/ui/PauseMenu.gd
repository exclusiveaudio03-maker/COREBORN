extends CanvasLayer

func _on_Resume_pressed():
	get_tree().paused = false
	queue_free()

func _on_Settings_pressed():
	var s = preload("res://scenes/UI/SettingsMenu.tscn").instantiate()
	add_child(s)
