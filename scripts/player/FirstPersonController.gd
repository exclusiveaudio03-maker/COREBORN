extends CharacterBody3D

@export var speed := 5.0
@export var look_sensitivity := 0.12
@export var jump_speed := 5.0

var yaw := 0.0
var pitch := 0.0

onready var cam:Camera3D = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var dir = Vector3.ZERO
	if Input.is_action_pressed("ui_up"): dir.z -= 1
	if Input.is_action_pressed("ui_down"): dir.z += 1
	if Input.is_action_pressed("ui_left"): dir.x -= 1
	if Input.is_action_pressed("ui_right"): dir.x += 1
	var move = (transform.basis * dir).normalized()
	velocity.x = move.x * speed
	velocity.z = move.z * speed

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed

	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * look_sensitivity
		pitch = clamp(pitch - event.relative.y * look_sensitivity, -80, 80)
		rotation_degrees.y = yaw
		cam.rotation_degrees.x = pitch
