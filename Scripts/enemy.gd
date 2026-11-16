extends CharacterBody2D

@onready var health_bar: ProgressBar = $UI/HealthBar


@export var health: float = 100.0
@export var speed: float = 80.0
@export var damage:float = 10.0
@export var xp_reward: int =5

var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var contact_cooldown: float = 0.0

const KNOCKBACK_FORCE = 350
const KNOCKBACK_DURATION = 0.2

var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	# Reduce contact cooldown
	if contact_cooldown >0:
		contact_cooldown -= delta
	
	# Decide how the enemy moves
	if knockback_timer > 0:
		knockback_timer-= delta
		
		velocity = knockback_velocity
		
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 1200 * delta)
		
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
	# Actually move the enemy
	move_and_slide()
	
	# Check whether movement caused a collision
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider == player and contact_cooldown <= 0:
			player.call("take_damage",damage)
			
			var knockback_direction = (
				global_position - player.global_position
			).normalized()
			
			knockback_velocity = knockback_direction * KNOCKBACK_FORCE
			knockback_timer = KNOCKBACK_DURATION
			contact_cooldown = 0.8
			
			break
			
			
func take_damage(amount: float) -> void:
		if health <= 0:
			die()
		
func die() -> void:
	queue_free()
func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, Color.RED)
