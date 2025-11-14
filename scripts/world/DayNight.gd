extends Node

@export var day_length_seconds := 600.0 # full day length
@export var sun_node_path := NodePath("World/Sun") # DirectionalLight3D
var time_of_day := 0.0 # 0..1

func _process(delta):
	if Engine.is_editor_hint(): return
	time_of_day = fmod(time_of_day + delta / day_length_seconds, 1.0)
	_update_sun()

func _update_sun():
	var sun = get_node_or_null(sun_node_path)
	if not sun: return
	# rotate sun around X axis
	var angle = lerp(-90, 270, time_of_day)
	sun.rotation_degrees.x = angle
	# change intensity and color
	if time_of_day < 0.25 or time_of_day > 0.75:
		# night
		sun.light_energy = 0.2
		sun.light_color = Color(0.5, 0.6, 1.0)
	else:
		# day
		sun.light_energy = 1.0
		sun.light_color = Color(1.0, 0.95, 0.9)
	# broadcast for sky shaders
	emit_signal("time_changed", time_of_day)

signal time_changed(t)
