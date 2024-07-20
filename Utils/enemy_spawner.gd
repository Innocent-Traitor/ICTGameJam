extends Node2D

@export var spawns : Array[Spawn_info] = []

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0

signal changetime(time)

func _ready():
	connect("changetime", Callable(player, "update_time"))

func _on_timer_timeout():
	time += 1 # Restart the timer
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end: # Check to see if anything is within start or end
			if i.spawn_delay_counter < i.enemy_spawn_delay: # Check to see if there is a delay
				i.spawn_delay_counter += 1 # Increase 1 for next time
			else:
				i.spawn_delay_counter = 0 # Restart the timer
				var new_enemy = load(str(i.enemy.resource_path))
				var counter = 0 
				while counter < i.enemy_num: # Spawn the amount of enemies we need
					var enemy_spawn = new_enemy.instantiate() # Instance the enemy
					enemy_spawn.global_position = get_random_position() # Get random pos
					add_child(enemy_spawn) # Spawn the actual enemy
					counter += 1 # Increment counter
	emit_signal("changetime", time)


func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4) # Gets a range a bit greater than the viewport
	# Set Corners of the spawning "rectange"
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_side = ["up", "down", "right", "left"].pick_random() # Pick a random side
	# Inits the range for the spawn side
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	# Match the randomly picked side, and set the spawn positions based on the corners we previously set
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	# Set the spawn for both X and Y, then return the value
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos2.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
	
