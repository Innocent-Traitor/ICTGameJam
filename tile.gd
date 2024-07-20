extends TileMap

@export var pos_x : int
@export var pos_y : int

func _ready() -> void:
	pos_x = int(name.substr(0, 2))
	pos_y = int(name.substr(2, 2))