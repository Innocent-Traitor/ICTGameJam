extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

var level = 1
var hp = 9999
var damage = 3
var knockback_amount = 200
var animation = "Attack1"


func _ready() -> void:
    # Get the direction the player is aiming
    self.look_at(get_global_mouse_position())
    self.rotation += deg_to_rad(90)

    match level:
        1:
            damage = 2
            animation = "Attack1"
        2:
            damage = 5
            animation = "Attack1"
        3:
            damage = 5
            animation = "Attack2"
        4:
            damage = 10
            animation = "Attack3"
        
    $AnimationPlayer.play(animation)

