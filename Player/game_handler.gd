extends CanvasLayer

@onready var health = $BarContainer/HealthBar
@onready var undead = $BarContainer/UndeadBar
@onready var undead_timer = $BarContainer/UndeadBar/UndeadRefillTimer
@onready var expbar = $ExpBar
@onready var time_label = $TimeLabel
@onready var levelup = $LevelUpPanel
@onready var loss = $GameOverPanel

var time = 0

var gui_upgrades = ['sword1', 'bow1', 'crossbow1', 'fire1', 'sludge1', 'heart1', 'boots1', 'bread1', 'whetstone1', 'anvil1']
var collected_upgrades = []
var weapon_amount = 0
var item_amount = 0

func _on_undead_refill_timer_timeout() -> void:
	undead.value += 1

## Updates health and maxhealth
func update_health(hp:float, max_hp:int) -> void:
	health.max_value = max_hp
	health.value = hp

## Updates exp and maxexp
func update_expbar(xp:int, max_xp:int) -> void:
	expbar.max_value = max_xp
	expbar.value = xp

## In Charge of updating the timer in-game
func change_time(argtime = 0):
	time = argtime
	@warning_ignore("integer_division")
	var get_m = int(time/60)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	time_label.text = str(get_m,":",get_s)

func start_levelup() -> void:# 170, 105 <- 170, 360
	levelup.handle_levelup()
	levelup.position = Vector2(170, 360)
	levelup.visible = true
	var tween = create_tween()
	tween.tween_property(levelup, "position", Vector2(170, 105), 0.15).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	get_tree().paused = true


func update_equipment_gui(upgrade) -> void:
	levelup.reset_levelup(upgrade)
	if not upgrade in gui_upgrades:
		return
	collected_upgrades.append(upgrade)
	var get_type = EquipmentDB.UPGRADES[upgrade]["type"]
	match get_type:
		"weapon":
			weapon_amount += 1
			get_node("%Weapon" + str(weapon_amount)).texture = load(EquipmentDB.UPGRADES[upgrade]["icon"])
		"item":
			item_amount += 1
			get_node("%Item" + str(item_amount)).texture = load(EquipmentDB.UPGRADES[upgrade]["icon"])


func game_over() -> void:
	get_tree().paused = true
	loss.show_game_over()
