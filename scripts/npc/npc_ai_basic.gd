extends Node

var speed := 1.5

func _process(delta):
	var host = get_parent()
	host.velocity.x = sin(Time.get_ticks_msec() * 0.002) * speed
	host.velocity.z = cos(Time.get_ticks_msec() * 0.002) * speed
	host.move_and_slide()
