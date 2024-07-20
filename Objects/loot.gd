extends Area2D

@export var experience = 1

var spr_1 = preload("res://Sprites/Loot/Loot1.png")
var spr_2 = preload("res://Sprites/Loot/Loot2.png")
var spr_3 = preload("res://Sprites/Loot/Loot3.png")

var target = null
var speed = -1 # Begins in the opposite direction before moving to the player

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	# Texture Handling
	if experience < 5:
		return
	elif experience < 25:
		sprite.texture = spr_2
	else:
		sprite.texture = spr_3


func _physics_process(delta):
	# Moves towards the player if within GrabArea Collision
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta


func collect():
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false # Psuedo delete gem to allow sound to play
	queue_free()
	return experience
