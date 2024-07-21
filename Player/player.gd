extends CharacterBody2D

var sword_attack = preload("res://Player/Attacks/sword_attack.tscn")
var arrow_attack = preload("res://Player/Attacks/arrow.tscn")
var bolt_attack = preload("res://Player/Attacks/bolt.tscn")
var fire_attack = preload("res://Player/Attacks/fireball.tscn")
var sludge_attack = preload("res://Player/Attacks/puddle.tscn")

@onready var sprite = $AnimatedSprite2D
@onready var hud = $HUD
@onready var weapon_parent = $WeaponParent

@onready var sword_timer = $Timers/WeaponTimers/SwordTimer
@onready var bow_timer = $Timers/WeaponTimers/ArrowTimer
@onready var crossbow_timer = $Timers/WeaponTimers/BoltTimer
@onready var fire_timer = $Timers/WeaponTimers/FireTimer
@onready var sludge_timer = $Timers/WeaponTimers/SludgeTimer

var non_decay_max_health : int = 100
var non_decay_health : float = 100
var non_decay_health_regen : float = 0
var non_decay_attack : float = 1.0
var non_decay_defense : float = 0.0
var non_decay_speed_mult : float = 1.0

var max_health = non_decay_max_health
var health  = non_decay_health
var health_regen = non_decay_health_regen
var attack = non_decay_attack
var defense = non_decay_defense
var speed_mult = non_decay_speed_mult

var collected_upgrades = []
var sword_level = 0
var bow_level = 0
var crossbow_level = 0
var fire_level = 0
var sludge_level = 0

var active_ability = null
var active_cooldown = false
var secondary_ability = null
var secondary_cooldown = false
var passive_ability = null
var passive_cooldown = false

var level = 1
var experience = 0
var collected_experience = 0
var speed = 100
var decay_percentage = 1
var is_respawning = false

var enemy_close = []

func _ready() -> void:
	hud.update_health(health, max_health)
	hud.update_expbar(experience, calculate_experiencecap())
	upgrade_character('sword1')

## Restart the attack timers
func start_attack() -> void:
	if collected_upgrades.has("sword1"):
		sword_timer.stop()
		sword_timer.wait_time = 2
		sword_timer.start()
	if collected_upgrades.has("bow1"):
		bow_timer.stop()
		bow_timer.wait_time = 1
		bow_timer.start()
	if collected_upgrades.has("crossbow1"):
		crossbow_timer.stop()
		crossbow_timer.wait_time = 1.5
		crossbow_timer.start()
	if collected_upgrades.has("fire1"):
		fire_timer.stop()
		fire_timer.wait_time = 2.5
		fire_timer.start()
	if collected_upgrades.has("sludge1"):
		sludge_timer.stop()
		sludge_timer.wait_time = 5
		sludge_timer.start()


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

	velocity = mov.normalized() * speed * speed_mult
	move_and_slide()

func level_up():
	hud.start_levelup()

func upgrade_character(upgrade): # Called in item_option
	# Match the upgrade 
	match upgrade:
		#region Weapons
		'sword1':
			sword_level = 1
		'sword2':
			sword_level = 2
		'sword3':
			sword_level = 3
		'sword4':
			sword_level = 4
		'bow1':
			bow_level = 1
		'bow2':
			bow_level = 2
		'bow3':
			bow_level = 3
		'bow4':
			bow_level = 4
		'crossbow1':
			crossbow_level = 1
		'crossbow2':
			crossbow_level = 2
		'crossbow3':
			crossbow_level = 3
		'crossbow4':
			crossbow_level = 4
		'fire1':
			fire_level = 1
		'fire2':
			fire_level = 2
		'fire3':
			fire_level = 3
		'fire4':
			fire_level = 4
		'sludge1':
			sludge_level = 1
		'sludge2':
			sludge_level = 2
		'sludge3':
			sludge_level = 3
		'sludge4':
			sludge_level = 4
		#endregion
		#region Upgrade Items
		'food':
			health += 25
			if health > max_health:
				health = max_health
			hud.update_health(health, max_health)
		'boots1':
			non_decay_speed_mult = 1.1 
			speed_mult += 0.1
		'boots2':
			non_decay_speed_mult = 1.2
			speed_mult += 0.1
		'boots3':
			non_decay_speed_mult = 1.3
			speed_mult += 0.1
		'heart1':
			non_decay_max_health = 125
			max_health += 25
			non_decay_health = non_decay_max_health
			health += 25
			hud.update_health(health, max_health)
		'heart2':
			non_decay_max_health = 150
			max_health += 25
			non_decay_health = non_decay_max_health
			health += 25
			hud.update_health(health, max_health)
		'heart3':
			non_decay_max_health = 175
			max_health += 25
			non_decay_health = non_decay_max_health
			health += 25
			hud.update_health(health, max_health)
		'bread1':
			non_decay_health_regen = 2.5
			health_regen += 2.5
		'bread2':
			non_decay_health_regen = 5
			health_regen += 2.5
		'bread3':
			non_decay_health_regen = 7.5
			health_regen += 2.5
		'whetstone1':
			non_decay_attack = 1.1
			attack += 0.1
		'whetstone2':
			non_decay_attack = 1.2
			attack += 0.1
		'whetstone3':
			non_decay_attack = 1.3
			attack += 0.1
		'anvil1':
			non_decay_defense = 0.05
			defense += 0.05
		'anvil2':
			non_decay_defense = 0.1
			defense += 0.05
		'anvil3':
			non_decay_defense = 0.15
			defense += 0.05
		#endregion

		
	collected_upgrades.append(upgrade)
	start_attack() # Sets new upgrade params for attacks
	hud.update_equipment_gui(upgrade)
	get_tree().paused = false
	calculate_experience(0) # Calls the function again to make sure we use all EXP

func gain_ability(ability) -> void:
	max_health = non_decay_max_health
	health  = non_decay_health / 2
	hud.update_health(health, max_health)
	health_regen = non_decay_health_regen
	attack = non_decay_attack
	defense = non_decay_defense
	speed_mult = non_decay_speed_mult
	decay_percentage = 1


	var type = EquipmentDB.ABILITY[ability]["type"]
	match type:
		"Active":
			active_ability = ability
		"Secondary":
			secondary_ability = ability
		"Passive":
			passive_ability = ability
	
	hud.update_ability_gui(ability, type)
	is_respawning = false
	$HurtBox.monitorable = true
	$HurtBox.monitoring = true
	$GrabArea.monitoring = true
	$GrabArea.monitorable = true
	get_tree().paused = false

func handle_death() -> void:
	if (passive_ability == "lastchance1" or passive_ability == "lastchance2") and passive_cooldown == false:
		passive_cooldown = true
		hud.set_ability_cooldown("Passive", 180)
		var mult
		if passive_ability == "lastchance2":
			mult = 1
		else:
			mult = 0.5
		speed_mult += mult
		$HurtBox.monitorable = false
		$HurtBox.monitoring = false
		health = 5
		hud.update_health(health, max_health)
		Engine.time_scale = 0.3	
		await get_tree().create_timer(2.5).timeout
		Engine.time_scale = 1
		speed_mult -= mult
		$HurtBox.monitorable = true
		$HurtBox.monitoring = true
		return

	if hud.can_respawn():
		is_respawning = true
		$HurtBox.monitorable = false
		$HurtBox.monitoring = false
		hud.start_respawn()
	else:
		if is_respawning == true:
			return
		speed_mult = 0
		$GrabArea.monitoring = false
		$GrabArea.monitorable = false
		hud.game_over()

## Pick a random target from the enemy_close array, and return the postion
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else: # If there are no enemies, just return up to prevent errors/crashing
		return Vector2.UP


func _unhandled_key_input(event):
	if event.is_action_pressed('active'):
		if active_cooldown == true:
			return
		match active_ability:
			'freezeblast1':
				hud.set_ability_cooldown("Active", 90)
				active_cooldown = true
				var enemies = get_tree().get_first_node_in_group('enemyspawn').get_children()
				var frozen_enemies = []
				for enemy in enemies:
					if enemy is CharacterBody2D:
						enemy.speed = 0
						enemy.modulate = Color(0, 1, 1, 1)
						frozen_enemies.append(enemy)
				
				await get_tree().create_timer(5).timeout
				for enemy in frozen_enemies:
					if is_instance_valid(enemy):
						enemy.modulate = Color(1, 1, 1, 1)
						enemy.speed = enemy.movement_speed
			
			'freezeblast2':
				hud.set_ability_cooldown("Active", 90)
				active_cooldown = true
				var enemies = get_tree().get_first_node_in_group('enemyspawn').get_children()
				var frozen_enemies = []
				for enemy in enemies:
					if enemy is CharacterBody2D:
						enemy.speed = 0
						enemy.modulate = Color(0, 1, 1, 1)
						frozen_enemies.append(enemy)
				
				await get_tree().create_timer(1).timeout
				for enemy in frozen_enemies:
					if enemy.is_inside_tree():
						enemy.modulate = Color(1, 1, 1, 1)
						enemy.speed = enemy.movement_speed
						enemy._on_hurt_box_hurt(5, Vector2.ZERO, 0)

			'rush1':
				hud.set_ability_cooldown("Active", 60)
				active_cooldown = true
				var non_spd = non_decay_speed_mult
				var spd = speed_mult
				var non_def = non_decay_defense
				var def = defense
				non_decay_speed_mult *= 2
				speed_mult *= 2
				non_decay_defense = 0.5
				defense = 0.5
				await get_tree().create_timer(5).timeout
				non_decay_speed_mult = non_spd
				speed_mult = spd
				non_decay_defense = non_def
				defense = def
				
			'rush2':
				hud.set_ability_cooldown("Active", 60)
				active_cooldown = true
				var non_spd = non_decay_speed_mult
				var spd = speed_mult
				var non_def = non_decay_defense
				var def = defense
				non_decay_speed_mult *= 2
				speed_mult *= 2
				non_decay_defense = 1
				defense = 1
				await get_tree().create_timer(10).timeout
				non_decay_speed_mult = non_spd
				speed_mult = spd
				non_decay_defense = non_def
				defense = def
						
	if event.is_action_pressed('secondary'):
		if secondary_cooldown == true:
			return
		match secondary_ability:
			'dodge1':
				hud.set_ability_cooldown("Secondary", 10)
				secondary_cooldown = true
				speed_mult += 1.5
				$HurtBox.monitorable = false
				$HurtBox.monitoring = false
				$CollisionShape2D.disabled = true
				await get_tree().create_timer(0.25).timeout
				speed_mult -= 1.5
				$HurtBox.monitorable = true
				$HurtBox.monitoring = true
				$CollisionShape2D.disabled = false

			'dodge2':
				hud.set_ability_cooldown("Secondary", 5)
				secondary_cooldown = true
				non_decay_speed_mult += 1.5
				$HurtBox.monitorable = false
				$HurtBox.monitoring = false
				$CollisionShape2D.disabled = true
				await get_tree().create_timer(0.25).timeout
				non_decay_speed_mult -= 1.5
				$HurtBox.monitorable = true
				$HurtBox.monitoring = true
				$CollisionShape2D.disabled = false

			'windblast1':
				hud.set_ability_cooldown("Secondary", 30)
				secondary_cooldown = true
				var enemies = get_tree().get_first_node_in_group('enemyspawn').get_children()
				for enemy in enemies:
					if enemy is CharacterBody2D:
						enemy._on_hurt_box_hurt(0,  -enemy.global_position.direction_to(global_position), 200)
			
			'windblast2':
				hud.set_ability_cooldown("Secondary", 30)
				secondary_cooldown = true
				var enemies = get_tree().get_first_node_in_group('enemyspawn').get_children()
				for enemy in enemies:
					if enemy is CharacterBody2D:
						enemy._on_hurt_box_hurt(3,  -enemy.global_position.direction_to(global_position), 250)


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
	if level < 5:
		exp_cap = level * 5
	elif level < 10:
		exp_cap = 95 + (level - 5) * 8
	else:
		exp_cap = 255 + (level - 10) * 12
		
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
func _on_hurt_box_hurt(damage:Variant, _angle:Variant, _knockback:Variant) -> void:
	health -= clampf(damage + (damage * -defense), 0, 999)
	hud.update_health(health, max_health)
	if health <= 0:
		handle_death()

func _on_collect_area_area_entered(area:Area2D) -> void:
	if area.is_in_group("loot"):
		var gem_exp = area.collect() # Grabs the experience from the collect func
		calculate_experience(gem_exp)

func update_time(time) -> void:
	hud.change_time(time)

func _on_regen_timer_timeout() -> void:
	health += health_regen
	hud.update_health(health, max_health)

func _on_decay_timer_timeout():
	var max_decay
	var decay_rate
	if passive_ability == "holy1" or passive_ability == "holy2":
		decay_rate = 0.005
	else:
		decay_rate = 0.01
		
	if passive_ability == "holy2":
		max_decay = 0.25
	else:
		max_decay = 0.5
	if decay_percentage >= max_decay:
		decay_percentage -= decay_rate
		print(decay_percentage)
		max_health = non_decay_max_health * decay_percentage
		health = health * decay_percentage
		hud.update_health(health, max_health)
		health_regen = non_decay_health_regen * decay_percentage
		attack = non_decay_attack * decay_percentage
		defense = non_decay_defense * decay_percentage
		speed_mult = non_decay_speed_mult * decay_percentage

#endregion

#region Weapon Signals/Timers

func _on_sword_timer_timeout() -> void:
	var sword = sword_attack.instantiate()
	sword.level = sword_level
	weapon_parent.add_child(sword)

func _on_arrow_timer_timeout() -> void:
	var ammo = bow_level
	if bow_level >= 3:
		ammo += 1
	
	for i in range(ammo):
		var arrow = arrow_attack.instantiate()
		arrow.level = bow_level
		arrow.target = get_random_target()
		arrow.position = self.global_position
		get_tree().current_scene.add_child(arrow)
		await get_tree().create_timer(0.1).timeout
	
	bow_timer.wait_time = 1
	bow_timer.start()

func _on_bolt_timer_timeout():
	var bolt = bolt_attack.instantiate()
	bolt.level = crossbow_level
	bolt.target = get_global_mouse_position()
	bolt.position = self.global_position
	get_tree().current_scene.add_child(bolt)

	crossbow_timer.wait_time = 1.5
	crossbow_timer.start()

func _on_fire_timer_timeout():
	var ammo
	match fire_level:
		1:
			ammo = 1
		2:
			ammo = 2
		3:
			ammo = 2
		4:
			ammo = 3
	
	for i in range(ammo):
		var fireball = fire_attack.instantiate()
		fireball.level = fire_level
		var ran_pos = Vector2(global_position.x +randf_range(-75, 75), global_position.y + randf_range(-75, 75))
		fireball.position = ran_pos
		fireball.z_index = -1
		get_tree().current_scene.add_child(fireball)
	
func _on_sludge_timer_timeout():
	var ammo = 1
	if sludge_level >= 3:
		ammo = 2
	
	for i in range(ammo):
		var ran_pos = Vector2(global_position.x +randf_range(-150, 150), global_position.y + randf_range(-150, 150))
		var sludge = sludge_attack.instantiate()
		sludge.level = sludge_level
		sludge.position = ran_pos
		if sludge_level >= 4:
			sludge.scale *= 1.5
		sludge.z_index = -1
		get_tree().current_scene.add_child(sludge)

#endregion
