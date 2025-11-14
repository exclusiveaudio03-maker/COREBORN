extends Node

signal combat_started()
signal combat_ended(winner:String)
signal turn_started(actor_id)
signal turn_ended(actor_id)

var players := []
var enemies := []
var turn_queue := []
var current_index := 0
var in_combat := false

func start_combat(_players:Array, _enemies:Array):
	players = _players.duplicate()
	enemies = _enemies.duplicate()
	_build_queue()
	in_combat = true
	emit_signal("combat_started")
	_next_turn()

func _build_queue():
	turn_queue.clear()
	for p in players:
		turn_queue.append({"id":p["id"], "type":"player", "spd":p.get("spd",10)})
	for e in enemies:
		turn_queue.append({"id":e["id"], "type":"enemy", "spd":e.get("spd",10)})
	turn_queue.sort_custom(self, "_compare_spd")
	current_index = 0

func _compare_spd(a,b):
	return int(b["spd"] - a["spd"])

func _next_turn():
	if current_index >= turn_queue.size():
		current_index = 0
	_build_round()
	var actor = turn_queue[current_index]
	emit_signal("turn_started", actor["id"])
	# If AI enemy, call simple AI
	if actor["type"] == "enemy":
		# simple target player 0
		apply_action(actor["id"], {"action":"attack", "target":players[0]["id"]})
		_end_turn(actor["id"])
	else:
		# wait for player input: UI should call choose_action(actor_id, action)
		pass

func choose_action(actor_id:String, action:Dictionary):
	apply_action(actor_id, action)
	_end_turn(actor_id)

func apply_action(actor_id:String, action:Dictionary):
	# Minimal example: attack reduces HP
	var target_id = action.get("target", null)
	var dmg = action.get("dmg", 5)
	# find target in players/enemies
	for p in players:
		if p["id"] == target_id:
			p["hp"] -= dmg
	for e in enemies:
		if e["id"] == target_id:
			e["hp"] -= dmg

func _end_turn(actor_id:String):
	emit_signal("turn_ended", actor_id)
	# cleanup dead, check winner
	players = players.filter(func(x): return x["hp"] > 0)
	enemies = enemies.filter(func(x): return x["hp"] > 0)
	if enemies.empty():
		in_combat = false
		emit_signal("combat_ended", "players")
		return
	if players.empty():
		in_combat = false
		emit_signal("combat_ended", "enemies")
		return
	current_index += 1
	_next_turn()

func _build_round():
	# placeholder for start-of-round effects
	pass
