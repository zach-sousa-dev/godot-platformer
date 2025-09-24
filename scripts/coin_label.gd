extends Label

var coins := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.update_coins.connect(self._on_update_coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "%02d" % coins


func _on_update_coins(num_coins: int) -> void:
	coins = num_coins
