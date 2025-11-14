extends Node

enum WeatherType { CLEAR, RAIN, STORM, FOG }

var current := WeatherType.CLEAR
@export var rain_particles_path := NodePath("World/RainParticles")

func set_weather(w):
	current = w
	_update_weather()

func _update_weather():
	var p = get_node_or_null(rain_particles_path)
	if not p: return
	match current:
		WeatherType.CLEAR:
			p.emitting = false
		WeatherType.RAIN:
			p.emitting = true
			p.scale = Vector3.ONE
		WeatherType.STORM:
			p.emitting = true
			p.scale = Vector3(1.6,1.6,1.6)
		WeatherType.FOG:
			p.emitting = false
