extends Node
signal choice_applied(id, value)

func apply_choice(id:String, value) -> void:
	GameState.set_choice(id, value)
	match id:
		"act1_cooperate_gov":
			if value == "gov":
				GameState.save_data["reputation"]["government"] += 10
			else:
				GameState.save_data["reputation"]["corebreakers"] += 10
		"act3_cure_or_destroy":
			if value == "cure":
				GameState.save_data["reputation"]["scientists"] += 15
			else:
				GameState.save_data["reputation"]["military"] += 15
	GameState.save()
	emit_signal("choice_applied", id, value)
