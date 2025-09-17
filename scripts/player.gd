extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500

enum states {DEFAULT, RUNNING, AIRBORNE}
var state := states.AIRBORNE


func _physics_process(delta: float) -> void:
	# Change grounded state based on input
	if is_on_floor() and Input.is_action_pressed("sprint"): # TODO: fix FSM
		state = states.RUNNING
	elif not is_on_floor():
		state = states.AIRBORNE
	else:
		state = states.DEFAULT
		
	# Add the gravity.
	if not state == states.AIRBORNE:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and not (state == states.AIRBORNE):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. # DONE.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
