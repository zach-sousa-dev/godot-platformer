extends StaticBody2D

const BUMP_AMOUNT := 10

const SPRITE_HEIGHT := 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bump_listener_hit_box(body: Node2D) -> void:
	var body_height = SPRITE_HEIGHT * body.scale.y
	var my_height = SPRITE_HEIGHT * scale.y
	
	if body.name == GameManager.PLAYER_NAME and (body.position.y + body_height/2) > (position.y + my_height/2) and int(body.position.y - position.y) <= my_height/2 + body_height/2:
		print("entered")
		position.y -= BUMP_AMOUNT
