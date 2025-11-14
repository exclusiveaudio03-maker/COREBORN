extends CharacterBody2D

@export var speed := 280.0
@export var jump_force := -560.0
var velocity := Vector2.ZERO
var on_ground := false

func _ready():
	# connect input signals
	InputManager.connect("tap", Callable(self, "_on_tap"))
	InputManager.connect("hold", Callable(self, "_on_hold"))
	InputManager.connect("swipe_up", Callable(self, "_on_swipe_up"))
	InputManager.connect("swipe_down", Callable(self, "_on_swipe_down"))

func _physics_process(delta):
	# simple horizontal movement via virtual buttons or screen swipes mapped to actions
	var move := 0
	if Input.is_action_pressed("ui_right"):
		move += 1
	if Input.is_action_pressed("ui_left"):
		move -= 1
	velocity.x = move * speed
	# gravity & jump
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	move_and_slide()

func _on_tap():
	# light attack
	print("light attack")

func _on_hold():
	# heavy attack
	print("heavy attack")

func _on_swipe_up():
	# jump
	if is_on_floor():
		velocity.y = jump_force
		move_and_slide()

func _on_swipe_down():
	# dodge (quick downward dash)
	print("dodge")
