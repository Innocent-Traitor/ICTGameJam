extends EnemyBody

var summon_enemy = preload("res://Enemy/revenant.tscn")

func _ready():
	speed = 25
	hurtbox.connect("hurt", Callable(self, "_on_hurt_box_hurt"))

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage * player.attack
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	#else:

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


func _on_summon_timer_timeout() -> void:
	speed = 0
	for i in range(5):
		var enemy = summon_enemy.instantiate()
		enemy.global_position = Vector2(global_position.x + randf_range(-50, 50), global_position.y + randf_range(-50, 50))
		get_parent().add_child(enemy)
		await get_tree().create_timer(0.25).timeout
	speed = 25
	$SummonTimer.wait_time = 15
	$SummonTimer.start()

