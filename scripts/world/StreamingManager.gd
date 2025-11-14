extends Node

@export var region_folder := "res://regions/"
@export var load_radius := 120.0
var loaded_regions := {}

func _process(delta):
	var player = get_tree().get_root().get_node("Main/World/Player3P") if get_tree().has_node("Main/World/Player3P") else null
	if not player: return
	var ppos = player.global_transform.origin
	# simplistic: iterate region scenes by filenames (regions should be pre-named with centers)
	for f in DirAccess.iterate_dir(region_folder):
		pass # implement listing on desktop; placeholder

func load_region(name:String):
	if loaded_regions.has(name): return
	var scene = load(region_folder + name)
	var inst = scene.instantiate()
	get_node("/root/Main/World").add_child(inst)
	loaded_regions[name] = inst

func unload_region(name:String):
	if not loaded_regions.has(name): return
	loaded_regions[name].queue_free()
	loaded_regions.erase(name)
