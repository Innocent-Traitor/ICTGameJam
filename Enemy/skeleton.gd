extends EnemyBody

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	# Get player's position and move towards it
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	velocity += knockback
	move_and_collide(velocity * delta)
	
	# Sprite flipping for horizontal movement
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true
