extends Area2D

signal hit_box(body)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_overlapping_bodies().size() > 0:
		for body in get_overlapping_bodies():
			hit_box.emit(body)
	
