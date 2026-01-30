extends Node

var world = null

@export var num_hills: int = 2
@export var slice: int = 10
@export var hill_range: int = 100
@export var initial_hill_width_multiplier: float = 2.0  

var screensize: Vector2
var terrain: Array = Array()
var start_y: float  


func _ready() -> void:
	randomize()
	screensize = get_viewport().get_visible_rect().size
	start_y = screensize.y * 0.2  
	terrain = Array()
	
	$StaticBody2D.add_to_group("terrain")
	add_hills(true)
	
# Called by world to check if more terrain is needed
func should_add_hills(skater_x_position: float) -> bool:
	return terrain[-1].x < skater_x_position + screensize.x / 2
		
func add_hills(initial: bool = false) -> void:
	# Create the first hill going upward to a peak
	var initial_height = hill_range 
	var hill_width = screensize.x / num_hills
	var hill_slices = hill_width / slice
	var poly = PackedVector2Array()
	var shape = CollisionPolygon2D.new()
	var terrain_skin = Polygon2D.new()
	$StaticBody2D.add_child(shape)
	
	if initial:
		var initial_hill_slices = (hill_width * initial_hill_width_multiplier) / slice
		for j in range(-100, initial_hill_slices):
			var hill_point = Vector2()
			hill_point.x = j * slice
			hill_point.y = start_y + initial_height * (1 + cos(PI + 2 * PI / initial_hill_slices * j)) / 2
			#$Line2D.add_point(hill_point)
			terrain.append(hill_point)

		poly.append(Vector2(terrain[-1].x, screensize.y))

		poly.append(Vector2(0, screensize.y))

		for point in terrain:
			poly.append(point)
	
	var start = terrain[-1]
	for i in range(num_hills):
		var height = randi_range(0, hill_range)
		start.y -= height
		for j in range(0, hill_slices):
			var hill_point = Vector2()
			hill_point.x = start.x + j * slice + hill_width * i
			hill_point.y = start.y + height * cos(2 * PI / hill_slices * j)
			#$Line2D.add_point(hill_point)
			terrain.append(hill_point)
			poly.append(hill_point)
		start.y += height
	
	poly.append(Vector2(terrain[-1].x, screensize.y))
	if not initial:
		poly.append(Vector2(terrain[0].x, screensize.y))
	
	shape.polygon = poly
	terrain_skin.polygon = poly
	terrain_skin.antialiased = true
	#terrain_skin.color = Color()
	add_child(terrain_skin)
	
	
	
	
	
	
	
	
