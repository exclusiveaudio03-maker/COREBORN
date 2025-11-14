extends CanvasLayer

@onready var music_slider := $Panel/VBox/MusicSlider
@onready var sfx_slider := $Panel/VBox/SFXSlider
@onready var sensitivity_slider := $Panel/VBox/SensitivitySlider
@onready var fullscreen_cb := $Panel/VBox/FullscreenToggle

func _ready():
	# load current values from SettingsManager
	music_slider.value = SettingsManager.get_music_volume()
	sfx_slider.value = SettingsManager.get_sfx_volume()
	sensitivity_slider.value = SettingsManager.get_sensitivity()
	fullscreen_cb.pressed = SettingsManager.is_fullscreen()

func _on_SaveBtn_pressed():
	SettingsManager.set_music_volume(music_slider.value)
	SettingsManager.set_sfx_volume(sfx_slider.value)
	SettingsManager.set_sensitivity(sensitivity_slider.value)
	SettingsManager.set_fullscreen(fullscreen_cb.pressed)
	SettingsManager.save()
	# feedback animation (simple)
	$Panel.modulate = Color(0.6,1,0.6)
	yield(get_tree().create_timer(0.15), "timeout")
	$Panel.modulate = Color(1,1,1)

func _on_CloseBtn_pressed():
	queue_free()
