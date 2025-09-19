extends Label

var coins := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "%02d" % coins


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_coin_coin_collected(num_coins: Variant) -> void:
	coins += num_coins
	text = "%02d" % coins
