extends Area2D

var _audio_player

var collected := false;

signal coin_collected(num_coins)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_audio_player = $AudioStreamPlayer2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
# Play the sound and hide the coin when colliding with the player.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and not collected:
		_audio_player.play(0)
		collected = true
		visible = false
		coin_collected.emit(1)
		
# Officially remove the coin after the sound has finished playing.
func _on_audio_stream_player_2d_finished() -> void:
	print("done")
	self.queue_free()
