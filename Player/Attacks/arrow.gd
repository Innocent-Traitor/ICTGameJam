extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

var level = 1
var hp = 1
var speed = 150
var damage = 2
var knockback_amount = 200

var target = Vector2.ZERO
var angle = Vector2.ZERO


func _ready() -> void:
	# Set the angle towards the target, and set rotation
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	
	# Compare the level to set the correct stats
	match level:
		1:
			damage = 2
		2:
			damage = 4
		3:
			damage = 4
		4:
			damage = 7
	
	# Tweening
	#self.scale = Vector2(0.25, 0.25)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()


func _physics_process(delta):
	position += angle * speed * delta


func enemy_hit(_int):
	emit_signal("remove_from_array", self)
	queue_free()


func _on_timer_timeout(): # Despawns the Ice Spear after the timer ends
	emit_signal("remove_from_array", self)
	queue_free()