extends RigidBody3D
@export var speed := 45.0
@export var damage := 15.0
@export var life_time := 6.0
var owner:Node = null

func _ready():
	yield(get_tree().create_timer(life_time), "timeout")
	if is_instance_valid(self):
		queue_free()

func _physics_process(delta):
	linear_velocity = transform.basis.z * -speed

func _on_body_entered(body:Node) -> void:
	if body == owner:
		return
	if body.has_method("receive_damage"):
		CombatManager.apply_damage(body, damage, owner)
	queue_free()
