extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("pause"):
		var pause = preload("res://scenes/UI/PauseMenu.tscn").instantiate()
		add_child(pause)
		get_tree().paused = true
