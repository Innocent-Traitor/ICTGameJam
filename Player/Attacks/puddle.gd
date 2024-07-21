extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

var level = 1
var knockback = 0
var damage = 2

var angle = Vector2.ZERO

func _ready() -> void:
	var my_scale = scale
	# Compare the level to set the correct stats
	match level:
		1:
			damage = 1
		2:
			damage = 2
		3:
			damage = 2
		4:
			damage = 3
	
	damage *= player.attack

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0)
	tween.tween_property(self, "scale", my_scale, 0.25)
	tween.play()


func enemy_hit(_int):
	emit_signal("remove_from_array", self)

func _on_timer_timeout(): # Despawns the Ice Spear after the timer ends
	emit_signal("remove_from_array", self)
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	tween.tween_callback(queue_free)
	tween.play()

func _on_attack_timer_timeout():
	for bodies in get_overlapping_areas():
		if is_instance_valid(bodies):
			if bodies.is_in_group("player"):
				pass
			else:
				bodies.get_parent().get_parent()._on_hurt_box_hurt(damage, angle, knockback)
				bodies.get_parent().get_parent().movement_speed -= 5
				await get_tree().create_timer(0.5).timeout
				if is_instance_valid(bodies):
					bodies.get_parent().get_parent().movement_speed += 5
		
	$AttackTimer.wait_time = 0.5
	$AttackTimer.start()
