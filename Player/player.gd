extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var hud = $HUD

var max_health : int = 100
var health : int = max_health
var health_regen : float = 2.5
var attack : float = 1.0
var defense : float = 0.0
var speed_mult : float = 1.0

var collected_upgrades = []

var level = 1
var experience = 0
var collected_experience = 0
var speed = 400

var enemy_close = []

signal death()

func _ready() -> void:
	hud.update_health(health, max_health)
	hud.update_expbar(experience, calculate_experiencecap())


func _process(_delta: float) -> void:
	handle_movement()

## Handles the movement logic and animation
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

func level_up():
	pass


## Pick a random target from the enemy_close array, and return the postion
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else: # If there are no enemies, just return up to prevent errors/crashing
		return Vector2.UP


#region Experience
## Calculate the experience we just got and see if we level up
func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: # Level Up
		collected_experience -= exp_required - experience
		level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		level_up()
	else:
		experience += collected_experience
		collected_experience = 0
	
	hud.update_expbar(experience, exp_required)

func calculate_experiencecap():
	var exp_cap = level
	if level < 20:
		exp_cap = level * 5
	elif experience < 40:
		exp_cap = 95 + (level - 19) * 8
	else:
		exp_cap = 255 + (level - 39) * 12
		
	return exp_cap
#endregion

#region Signal Handling
func _on_vision_area_body_entered(body:Node2D) -> void:
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_vision_area_body_exited(body:Node2D) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)

func _on_grab_area_area_entered(area:Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self
		
## Handle player damage
func _on_hurt_box_hurt(damage:Variant, angle:Variant, knockback:Variant) -> void:
	health -= clamp(damage - (damage * defense), 1, 999)
	hud.update_health(health, max_health)
	if health <= 0:
		handle_death()

func _on_collect_area_area_entered(area:Area2D) -> void:
	if area.is_in_group("loot"):
		var gem_exp = area.collect() # Grabs the experience from the collect func
		calculate_experience(gem_exp)
#endregion


func handle_death() -> void:
	pass
