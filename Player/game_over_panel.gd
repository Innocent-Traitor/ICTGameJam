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



