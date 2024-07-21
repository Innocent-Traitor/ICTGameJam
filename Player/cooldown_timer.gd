extends TextureProgressBar

var cooldown = false

func start_cooldown(time) -> void:
	cooldown = true
	$Timer.wait_time = time
	$Timer.start()
	max_value = time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = $Timer.time_left


func _on_timer_timeout():
	cooldown = false
