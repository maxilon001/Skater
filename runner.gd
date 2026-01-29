extends CharacterBody2D

@export var speed_multiplier: float = 0.02
@export var SPEED = 1
@export var max_speed: float = 10
@export_range(-2000,-400,100.0) var JUMP_VELOCITY
@export var backflip_speed = 5.0  # How fast the backflip rotates (radians per second)

var backflip = false
var is_backflipping = false
var jump = false

func _input(event):
	if event is InputEventSingleScreenTouch and event.pressed:
		jump = true
	if event is InputEventSingleScreenLongPress:
		backflip = true
	
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta
	if is_on_floor():
		# Reset rotation when landing
		if rotation > 0:
			velocity.x = 0
			
		is_backflipping = false
		backflip = false

	# Handle jump.
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump = false
		
		
	# Handle backflip when holding jump button in the air
	if backflip and not is_on_floor():
		is_backflipping = true
	
	# Perform backflip rotation
	if is_backflipping and not is_on_floor():
		rotation -= backflip_speed * delta  # Negative for backward rotation

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	SPEED += SPEED * speed_multiplier
	if SPEED <= max_speed:
		velocity.x = SPEED
	else:
		velocity.x = max_speed
		
	print(velocity)
		

	move_and_slide()
	
	
	
	
	
	
	
	
	
