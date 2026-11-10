extends Node2D

const ENEMY_SCENE = preload("res://Scenes/enemy.tscn")


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass



func _on_spawn_timer_timeout() -> void:
	print("SPAWN TIMER FIRED")
	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		print("ERROR: PLAYER NOT FOUND")
		return

	var enemy = ENEMY_SCENE.instantiate()

	var spawn_angle = randf() * TAU
	var spawn_distance = randf_range(100.0, 150.0)

	var spawn_offset = Vector2.RIGHT.rotated(spawn_angle) * spawn_distance

	get_tree().current_scene.add_child(enemy)

	enemy.global_position = player.global_position + spawn_offset
	print("ENEMY SPAWNED AT: ", enemy.global_position)
