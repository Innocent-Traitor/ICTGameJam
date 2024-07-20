extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
