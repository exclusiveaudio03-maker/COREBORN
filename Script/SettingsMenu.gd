extends Control

func _ready():
	$Panel/CloseButton.pressed.connect(_on_close)

func _on_close():
	SettingsManager.save_settings()
	visible = false
