extends Area2D

@export var speed: float = 400.0
@export var damage: float = 10.0

var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.call("take_damage", damage)
		queue_free()

func _draw() -> void:
	draw_circle(Vector2.ZERO, 5.0, Color.YELLOW)
