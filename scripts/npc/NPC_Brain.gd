extends CharacterBody3D
@export var speed := 2.0
@export var patrol_points := []  # array of Vector3 or NodePaths
@export var detection_radius := 10.0

var _agent:NavigationAgent3D
var _state := "idle"
var _target:Node = null
var _point_index := 0

func _ready():
	_agent = NavigationAgent3D.new()
	add_child(_agent)
	_agent.radius = 0.6
	_agent.max_speed = speed
	NPCManager.register_npc(self)

func _process(delta):
	if _state == "idle":
		_patrol(delta)
		_check_for_player()
	elif _state == "chase":
		_chase(delta)

func _patrol(delta):
	if patrol_points.size() == 0:
		return
	var target_pos = patrol_points[_point_index] if typeof(patrol_points[_point_index])==TYPE_VECTOR3 else get_node(patrol_points[_point_index]).global_transform.origin
	if global_transform.origin.distance_to(target_pos) < 1.2:
		_point_index = (_point_index + 1) % patrol_points.size()
	else:
		var dir = (target_pos - global_transform.origin).normalized()
		velocity = dir * speed
		move_and_slide()

func _check_for_player():
	var players = NPCManager.find_nearby(global_transform.origin, detection_radius)
	if players.size() > 0:
		_target = players[0]
		_state = "chase"

func _chase(delta):
	if not is_instance_valid(_target):
		_state = "idle"
		_target = null
		return
	var dir = (_target.global_transform.origin - global_transform.origin).normalized()
	velocity = dir * speed * 1.2
	move_and_slide()
	if global_transform.origin.distance_to(_target.global_transform.origin) < 2.0:
		# attack placeholder
		CombatManager.apply_damage(_target, 5.0, self)
