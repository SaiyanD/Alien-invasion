extends CharacterBody2D

const SPEED = 150.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

	update_animation(direction)

func update_animation(dir: Vector2) -> void:
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true

	if dir != Vector2.ZERO:
		if abs(dir.x) >= abs(dir.y):
			sprite.play("Side_run")
		else:
			if dir.y > 0:
				sprite.play("Front_run")
			else:
				sprite.play("Back_run")
	else:
		var current_anim = sprite.animation
		if current_anim == "Side_run" or current_anim == "Side_idle":
			sprite.play("Side_idle")
		elif current_anim == "Front_run" or current_anim == "Front_idle":
			sprite.play("Front_idle")
		elif current_anim == "Back_run" or current_anim == "Back_idle":
			sprite.play("Back_idle")
