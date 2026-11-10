extends CharacterBody2D

const BULLET_SCENE= preload("res://Scenes/bullet.tscn")
const SPEED = 150.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()

	update_animation(direction)

func update_animation(dir: Vector2) -> void:
	#This is to flip the sprite left or right
	if dir.x >0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true
	
	#RUN ANIMATIONS
	if dir != Vector2.ZERO:
		
		#Diagonal movement
		if dir.x != 0 and dir.y!= 0:
			if dir.y > 0:
				sprite.play("Front_Diagonal_run")
			else:
				sprite.play("Back_Diagonal_run")
			
		#Horizontal movement
		elif dir.x != 0:
			sprite.play("Side_run")
		
		#Vertical movement
		elif dir.y > 0:
			sprite.play("Front_run")
		else:
			sprite.play("Back_run")
	
	#Idle animations
	else:
		if sprite.animation == "Front_Diagonal_run":
			sprite.play("Front_Diagonal_")
		elif sprite.animation == "Back_Diagonal_run":
			sprite.play("Back_Diagonal_idle")
		elif sprite.animation == "Side_run":
			sprite.play("Side_idle")
		elif sprite.animation == "Front_run":
			sprite.play("Front_idle")
		elif sprite.animation == "Back_run":
			sprite.play("Back_idle")


func _on_shoot_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	if enemies.is_empty():
		return
	
	var nearest_enemy:Node2D = null
	var nearest_distance = INF
	
	for enemy in enemies:
		if enemy is Node2D:
			var distance = global_position.distance_squared_to(enemy.global_position)
			
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_enemy = enemy
	
	if nearest_enemy == null:
		return
	
	var bullet = BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = $BulletSpawn. global_position
	
	var direction = (nearest_enemy.global_position - bullet.global_position).normalized()
	bullet.set("direction", direction)
