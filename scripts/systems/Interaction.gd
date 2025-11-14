extends Node

signal interacted(obj)

func interact(obj):
	emit_signal("interacted", obj)
	# example: start combat if obj has "is_enemy"
	if obj.has_meta("is_enemy") and obj.get_meta("is_enemy"):
		var combat = get_node("/root/TurnBasedCombat")
		if combat:
			combat.start_combat(obj.get("players"), obj.get("enemies"))
