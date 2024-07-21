extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

var level = 1
var speed = 10
var damage = 2

var angle = Vector2.ZERO

func _ready() -> void:
	# Compare the level to set the correct stats
	match level:
		1:
			damage = 3
		2:
			damage = 5
		3:
			damage = 8
		4:
			damage = 8
	
	angle = Vector2(randf_range(-5, 5), randf_range(-5, 5))

	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.25)
	tween.play()


func _physics_process(delta):
	rotation += deg_to_rad(5)
	position += angle * speed * delta


func enemy_hit(_int):
	emit_signal("remove_from_array", self)

func _on_timer_timeout(): # Despawns the Ice Spear after the timer ends
	emit_signal("remove_from_array", self)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.tween_callback(queue_free)
	tween.play()