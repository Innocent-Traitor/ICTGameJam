extends Panel

@onready var restart_button = $HBoxContainer/RestartButton
@onready var menu_button = $HBoxContainer/MenuButton

func show_game_over() -> void:
	modulate = Color(1, 1, 1, 0)
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 2)
	tween.tween_property(restart_button, 'disabled', false, 0)
	tween.tween_property(menu_button, 'disabled', false, 0)
	tween.play()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
