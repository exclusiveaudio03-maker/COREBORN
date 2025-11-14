extends Node

@export var animated_nodes := [] # array of NodePaths
@export var intensity := 1.0

func _process(delta):
	for p in animated_nodes:
		var n = get_node_or_null(p)
		if n and n is Node3D:
			# subtle bob + rotate
			var t = OS.get_ticks_msec() / 1000.0
			var offset = sin(t * 0.7 + p.hash()) * 0.05 * intensity
			n.translation.y = offset
			n.rotation_degrees.y = sin(t * 0.2 + p.hash()) * 2.0 * intensity
