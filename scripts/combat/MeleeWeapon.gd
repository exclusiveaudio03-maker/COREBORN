extends Node3D
@export var damage: float = 10.0
@export var reach: float = 2.0
@export var cooldown: float = 0.6

var _can_attack := true

func attack(origin:Node3D) -> void:
	if not _can_attack:
		return
	_can_attack = false
	# simple sphere overlap for hits
	var hits = PhysicsServer3D.body_get_direct_state_array(origin.get_world_3d().space)
	# we'll use a PhysicsDirectSpaceState query
	var space = origin.get_world_3d().direct_space_state
	var from_pos = origin.global_transform.origin
	var res = space.intersect_shape(
		Shape3D.new_sphere( reach ),
		Transform3D(Basis(), from_pos),
		0, [], 0b11111, true, true
	)
	# fallback: iterate nearby bodies using overlap_point is complex; prefer area in scene
	for h in res:
		var node = h.get("collider")
		if node and node.has_method("receive_damage"):
			CombatManager.apply_damage(node, damage, origin)
	yield(get_tree().create_timer(cooldown), "timeout")
	_can_attack = true
