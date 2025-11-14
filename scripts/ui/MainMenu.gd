extends CanvasLayer

func _on_SettingsBtn_pressed():
	var settings = preload("res://scenes/UI/SettingsMenu.tscn").instantiate()
	get_tree().current_scene.add_child(settings)

func _on_PlayBtn_pressed():
	# start game - change scene or unpause
	get_tree().change_scene_to_file("res://scenes/main.tscn")
