extends Node
# Simple combat manager: damage routing, hit events, spawn projectiles

signal entity_damaged(target, amount, source)
signal entity_killed(target, source)

func apply_damage(target:Node, amount:float, source:Node = null) -> void:
	if not target: return
	if not target.has_method("receive_damage"):
		return
	target.call("receive_damage", amount, source)
	emit_signal("entity_damaged", target, amount, source)
	if target.has_method("is_dead") and target.call("is_dead"):
		emit_signal("entity_killed", target, source)
