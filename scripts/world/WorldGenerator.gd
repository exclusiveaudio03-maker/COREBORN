extends Node3D
@export var seed:int = 0
@export var size_x:int = 128
@export var size_z:int = 128
@export var scale:float = 2.0
@export var height_scale:float = 8.0

var noise := OpenSimplexNoise.new()

func _ready():
	noise.seed = seed
	noise.octaves = 4
	noise.period = 64.0
	noise.persistence = 0.6
	generate_terrain()

func generate_terrain() -> void:
	var mesh := ArrayMesh.new()
	var arr := []
	var verts := PackedVector3Array()
	var normals := PackedVector3Array()
	var uvs := PackedVector2Array()
	var indices := PackedInt32Array()
	# build grid of vertices
	for x in size_x:
		for z in size_z:
			var fx = float(x) * scale
			var fz = float(z) * scale
			var h = noise.get_noise_2d(x, z) * height_scale
			verts.append(Vector3(fx, h, fz))
			uvs.append(Vector2(x/float(size_x), z/float(size_z)))
	# compute indices (two tris per quad)
	for x in range(size_x-1):
		for z in range(size_z-1):
			var i = x*size_z + z
			indices.append(i)
			indices.append(i + 1)
			indices.append(i + size_z)
			indices.append(i + 1)
			indices.append(i + size_z + 1)
			indices.append(i + size_z)
	arr.resize(ArrayMesh.ARRAY_MAX)
	arr[ArrayMesh.ARRAY_VERTEX] = verts
	arr[ArrayMesh.ARRAY_TEX_UV] = uvs
	arr[ArrayMesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)
	var mi = MeshInstance3D.new()
	mi.mesh = mesh
	add_child(mi)
