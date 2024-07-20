extends Node2D

var tile_x
var monitor_x
var tile_y
var monitor_y
var left_x = 1
var right_x = 3
var top_y = 1
var bottom_y = 3

func handle_world_wrap(dir : String) -> void:
	var children = get_children().filter(func(c): return c is TileMap)
	var moving_tiles = []
	match dir:
		"top":
			moving_tiles = children.filter(func(c): return c.pos_y == bottom_y)
			tile_x = 0
			monitor_x = 0
			tile_y = -1008
			monitor_y = -336
			top_y -= 1
			bottom_y -= 1

		"bottom":
			moving_tiles = children.filter(func(c): return c.pos_y == top_y)
			tile_x = 0
			monitor_x = 0
			tile_y = 1008
			monitor_y = 336
			top_y += 1
			bottom_y += 1

		"left":
			moving_tiles = children.filter(func(c): return c.pos_x == right_x)
			tile_x = -1008
			monitor_x = -336
			tile_y = 0
			monitor_y = 0
			left_x -= 1
			right_x -= 1

		"right":
			moving_tiles = children.filter(func(c): return c.pos_x == left_x)
			tile_x = 1008
			monitor_x = 336
			tile_y = 0
			monitor_y = 0
			left_x += 1
			right_x += 1
	
	for tile in moving_tiles:
		tile.position.x += tile_x
		tile.position.y += tile_y
		match dir:
			"top":
				tile.pos_y = top_y
			"bottom":
				tile.pos_y = bottom_y
			"left":
				tile.pos_x = left_x
			"right":
				tile.pos_x = right_x

	
	for monitor in get_children().filter(func(c): return c is Area2D):
		monitor.position.x += monitor_x
		monitor.position.y += monitor_y

#region Monitor Signals
func _on_top_monitor_body_entered(_body:Node2D) -> void:
	handle_world_wrap("top")

func _on_left_monitor_body_entered(_body: Node2D) -> void:
	handle_world_wrap("left")

func _on_right_monitor_body_entered(_body: Node2D) -> void:
	handle_world_wrap("right")

func _on_bottom_monitor_body_entered(_body: Node2D) -> void:
	handle_world_wrap("bottom")
#endregion
