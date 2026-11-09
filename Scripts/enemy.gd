extends CharacterBody2D


@export var health: float = 30.0
@export var speed: float = 80.0
@export var damage:float = 10.0
@export var xp_reward: int =5

var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	var direction = global_position.direction_to(
		player.global_position
	)
	
	velocity = direction * speed
	move_and_slide()
	
func take_damage(amount: float) -> void:
		health -= amount
		
		if health <= 0:
			die()
		
func die() -> void:
	queue_free()
