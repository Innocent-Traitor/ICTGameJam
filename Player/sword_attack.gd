extends Area2D

@onready var player = get_tree().get_node("%Player")

signal remove_from_array(object)

var level = 1
var hp = 9999
var damage = 3
var knockback_amount = 100
var animation = "Attack1"

var direction = Vector2.ZERO

func _ready() -> void:
    # Get the direction the player is aiming
    direction = player.global_position.directon_to(get_global_mouse_position())

    match level:
        1:
            damage = 2
            animation = "Attack1"
        2:
            damage = 5
        3:
            damage = 5
            animation = "Attack2"
        4:
            damage = 10
            animation = "Attack3"
        
    $AnimationPlayer.play(animation)

