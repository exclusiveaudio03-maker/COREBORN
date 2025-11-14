extends CharacterBody3D

var speed := 6.0
var camera

func _ready():
	camera = $Camera3D_Third

func _physics_process(delta):
	var input = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		input.z -= 1
	if Input.is_action_pressed("move_back"):
		input.z += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1

	input = input.normalized()
	velocity = (global_transform.basis * input) * speed
	move_and_slide()
