@tool
extends Control

@onready var jump_button = $JumpButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jump_button.shape.size = size
	jump_button.position = size /2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
