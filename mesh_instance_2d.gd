@tool
extends MeshInstance2D

@export var verts = PackedVector2Array([
  Vector2(0, 0),
  Vector2(0, 1),
  Vector2(1, 0),
  Vector2(1, 1),
 ])
	  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	
	#var verts = PackedVector2Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector2Array()
	var indices = PackedInt32Array()
	
	

	uvs = PackedVector2Array([
		  Vector2(0, 0),
		  Vector2(1, 0),
		  Vector2(0, 1),
		  Vector2(1, 1),
	  ])

	normals = PackedVector2Array([
		  Vector2.UP,
		  Vector2.UP,
		  Vector2.UP,
		  Vector2.UP,
	  ])

	indices = PackedInt32Array([
		  0, 1,
		  1, 0,
	  ])

	
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices
	
	# No blendshapes, lods, or compression used.
	mesh=surface_array
	# Saves mesh to a .tres file with compression enabled.
	ResourceSaver.save(mesh, "res://square.tres", ResourceSaver.FLAG_COMPRESS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
