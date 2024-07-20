extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var max_health : int = 100
var health : int = max_health
var health_regen : float = 2.5
var attack : float = 1.0
var defense : float = 0.0
var speed_mult : float = 1.0

var level = 1
var speed = 400

signal health_changed(new_value)
signal death()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handle_movement()

func handle_movement() -> void:
	var mov = Input.get_vector("left", "right", "up", "down")
	
	if mov.x > 0:
		sprite.flip_h = false
	elif mov.x < 0:
		sprite.flip_h = true
	
	if (mov != Vector2.ZERO):
		sprite.play("move")
	else:
		sprite.play("idle")

	velocity = mov.normalized() * speed
	move_and_slide()
