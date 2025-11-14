extends Node

@export var phases := []
var current_phase := 0

signal phase_changed(old_phase, new_phase)
signal boss_defeated()

func start():
	current_phase = 0
	_enter_phase(current_phase)

func next_phase():
	var old = current_phase
	current_phase += 1
	if current_phase >= phases.size():
		emit_signal("boss_defeated")
		return
	_enter_phase(current_phase)
	emit_signal("phase_changed", old, current_phase)

func _enter_phase(idx:int):
	print("Entering boss phase: %s" % str(idx))
	# override this method in boss scripts to change behavior/performance
