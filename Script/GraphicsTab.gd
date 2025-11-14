extends Control

func _ready():
	$Fullscreen.button_pressed = SettingsManager.settings.graphics.fullscreen
	$RenderScale.value = SettingsManager.settings.graphics.render_scale
	$VFX.button_pressed = SettingsManager.settings.graphics.vfx_enabled

	$Fullscreen.toggled.connect(_on_fullscreen)
	$RenderScale.value_changed.connect(_on_scale)
	$VFX.toggled.connect(_on_vfx)

func _on_fullscreen(val):
	SettingsManager.settings.graphics.fullscreen = val

func _on_scale(val):
	SettingsManager.settings.graphics.render_scale = val

func _on_vfx(val):
	SettingsManager.settings.graphics.vfx_enabled = val
