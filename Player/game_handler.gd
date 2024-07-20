extends CanvasLayer

@onready var health = $BarContainer/HealthBar
@onready var undead = $BarContainer/UndeadBar
@onready var undead_timer = $BarContainer/UndeadBar/UndeadRefillTimer
@onready var expbar = $ExpBar


func _on_player_health_changed(new_value:int) -> void:
	health.value = new_value

func _on_undead_refill_timer_timeout() -> void:
	undead.value += 1

## Updates health and maxhealth
func update_health(hp:int, max_hp:int) -> void:
	health.max_value = max_hp
	health.value = hp

## Updates exp and maxexp
func update_expbar(xp:int, max_xp:int) -> void:
	expbar.max_value = max_xp
	expbar.value = xp
