extends RigidBody2D

var jump = false
var world = null

@export var jump_velocity = -1000
@export var forward_speed = 500  

func _ready() -> void:
	pass

func _input(event):
	if event is InputEventSingleScreenTouch and event.pressed:
		# Check with world if we can jump
		if world and world.can_jump():
			jump = true
		else:
			print("Can't jump - not on ground!")
		
func _physics_process(delta: float) -> void:
	#apply_central_force(Vector2(forward_speed, 0))
	linear_velocity.x = forward_speed	
	if jump:
		apply_central_impulse(Vector2(0, jump_velocity))
		jump = false
