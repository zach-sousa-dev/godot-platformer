extends Area2D

var _audio_player

var _collected := false

const WORTH := 1

var _animated_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_audio_player = $AudioStreamPlayer2D
	_animated_sprite = $AnimatedSprite2D
	_animated_sprite.play("spin")
	
# Play the sound and hide the coin when colliding with the player.
func _on_body_entered(body: Node2D) -> void:
	if body.name == GameManager.PLAYER_NAME and not _collected:
		_audio_player.play(0)
		_collected = true
		visible = false
		GameManager._collect_coin(WORTH)
		
# Officially remove the coin after the sound has finished playing.
func _on_audio_stream_player_2d_finished() -> void:
	self.queue_free()
