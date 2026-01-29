extends Node2D

@onready var skater = $Skater
@onready var terrain = $Terrain

var is_touching_terrain = false

func _ready() -> void:
	skater.body_entered.connect(_on_skater_body_entered)
	skater.body_exited.connect(_on_skater_body_exited)
	
	skater.world = self
	terrain.world = self

func _on_skater_body_entered(body: Node) -> void:
	if body.is_in_group("terrain"):
		is_touching_terrain = true

func _on_skater_body_exited(body: Node) -> void:
	if body.is_in_group("terrain"):
		is_touching_terrain = false
		
func _process(delta: float) -> void:
	# Check if we need to generate more terrain
	if terrain.should_add_hills(skater.position.x):
		terrain.add_hills()
		
func can_jump() -> bool:
	return is_touching_terrain
