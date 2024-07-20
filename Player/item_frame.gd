extends VBoxContainer

@onready var label = $Label
@onready var item_texture = $Texture

var mouse_over = false
var item = null

@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)


func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null: # If no items are avaiable, default to food
		item = "food"
	# Set the option parameters
	label.text = EquipmentDB.UPGRADES[item]["displayname"]
	label.text += EquipmentDB.UPGRADES[item]["details"]
	item_texture.texture = load(EquipmentDB.UPGRADES[item]["icon"])


func new_option(new_item):
	item = new_item
	if item == null: # If no items are avaiable, default to food
		item = "food"
	# Set the option parameters
	label.text = EquipmentDB.UPGRADES[item]["displayname"]
	label.text += EquipmentDB.UPGRADES[item]["details"]
	item_texture.texture = load(EquipmentDB.UPGRADES[item]["icon"])


func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)
			


func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
