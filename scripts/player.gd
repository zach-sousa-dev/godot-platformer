extends CharacterBody2D


const SPEED = 100.0
const RUN_SPEED = 200.0
const JUMP_VELOCITY = -350

var current_speed := 0.0

const AIRBORNE_ACCELERATION = 10.0
const GROUND_ACCELERATION = 15.0

enum states {STAND, WALK, RUN, AIRBORNE}
var state := states.AIRBORNE

var _animated_sprite
var _audio_player

func _ready() -> void:
	_animated_sprite = $AnimatedSprite2D
	_audio_player = $AudioStreamPlayer2D

func _control_animation(direction) -> void:
	# Control the sprite animation.
	match state:
		states.AIRBORNE:
			_animated_sprite.play("jump")
		states.RUN:
			_animated_sprite.play("run")
		states.WALK:
			_animated_sprite.play("walk")
		_:
			if velocity.x == 0:
				_animated_sprite.play("stand")
			elif velocity.x <= SPEED:
				_animated_sprite.play("walk")
			else:
				_animated_sprite.play("run")
			
	# Control the facing direction of the sprite.
	if state == states.RUN or state == states.WALK:
		_animated_sprite.flip_h = direction < 0

func _physics_process(delta: float) -> void:
	# Get the input direction.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Match the speed to state.
	match state:
		states.STAND:
			current_speed = 0
		states.RUN:
			current_speed = RUN_SPEED
		states.AIRBORNE:
			if sign(direction) != sign(velocity.x) and direction != 0:
				current_speed = SPEED
		states.WALK:
			current_speed = SPEED
	
	
	# Handle the movement/deceleration.
	if direction and state == states.AIRBORNE:
		velocity.x = move_toward(velocity.x, direction * current_speed, AIRBORNE_ACCELERATION)
	elif state != states.AIRBORNE:
		velocity.x = move_toward(velocity.x, direction * current_speed, GROUND_ACCELERATION)
	
	# Change state based on input.
	if not is_on_floor():
		state = states.AIRBORNE
	elif direction and Input.is_action_pressed("sprint"):
		state = states.RUN
	elif direction:
		state = states.WALK
	else:
		state = states.STAND
		
	# Update the animation to match the state.
	_control_animation(direction)
		
	# Add the gravity.
	if state == states.AIRBORNE:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and not (state == states.AIRBORNE):
		velocity.y = JUMP_VELOCITY
		_audio_player.play(0)

	move_and_slide()
