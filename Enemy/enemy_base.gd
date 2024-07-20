extends CharacterBody2D

class_name EnemyBody

# Enemy Attributes
@export var movement_speed : float = 20.0
@export var hp : int = 10
@export var knockback_recovery : float = 3.5
@export var experience : int = 1
@export var enemy_damage : int = 1
var knockback = Vector2.ZERO

# Preload Nodes 
@onready var sprite = $EnemyBase/Sprite2D
@onready var anim 	= $AnimationPlayer
@onready var snd_hit 	= $EnemyBase/snd_hit
@onready var hitbox = $EnemyBase/HitBox
@onready var hurtbox = $EnemyBase/HurtBox
@onready var collision = $CollisionShape2D

# Get player for targetting, and loot for dropping
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

# Preload Scenes
var death_anim = preload("res://Enemy/explosion.tscn")
var exp_gem = preload("res://Objects/loot.tscn")

# Signals
signal remove_from_array(object)


func _ready():
#	add_to_group("enemy") # Do we need this?
	anim.play("walk") # Plays walk animation
	hitbox.damage = enemy_damage
	hurtbox.connect("hurt", Callable(self, "_on_hurt_box_hurt"))


func death():
	emit_signal("remove_from_array", self) # Removes themself from targetting area
	# Instance and Create Death Animation
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale
	enemy_death.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	# Instance and Create Experience Gem
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	queue_free()
	


func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()