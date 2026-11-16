extends Area2D

@export var xp_value: int = 5

func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw() -> void:
	draw_circle(Vector2.ZERO, 8.0, Color.GREEN)
