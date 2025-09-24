extends Node

signal update_coins(num_coins)

var coins := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _collect_coin(points: int) -> void:
	coins += points
	update_coins.emit(coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
