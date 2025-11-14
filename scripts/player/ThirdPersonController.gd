extends CharacterBody3D

@export var speed := 6.0
@export var turn_speed := 6.0
@export var jump_velocity := 6.0
@export var camera_sensitivity := 0.01

var velocity:Vector3 = Vector3.ZERO
onready var cam = $Camera3D setget , _set_cam

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.z += 1
	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
		var basis = global_transform.basis
		var forward = -basis.z
		var right = basis.x
		var move = (right * input_dir.x + forward * input_dir.z).normalized()
		velocity.x = move.x * speed
		velocity.z = move.z * speed
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		velocity.z = lerp(velocity.z, 0, 0.2)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# gravity
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * camera_sensitivity)
		if cam:
			var new_x = clamp(cam.rotation_degrees.x - event.relative.y * camera_sensitivity, -45, 45)
			cam.rotation_degrees.x = new_x

func _set_cam(node):
	cam = node
