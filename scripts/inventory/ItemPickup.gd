extends Area3D
@export var item_id:String = "titan_oil"
@export var amount:int = 1

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body:Node) -> void:
	# check player tag
	if body.name.begins_with("Player"):
		InventoryManager.add_item(item_id, amount)
		queue_free()
