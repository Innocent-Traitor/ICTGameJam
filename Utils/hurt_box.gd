extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0 

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, angle, knockback)

var hit_once_array = [] # This stores objects that have hit us, for use in HitOnce HurtBoxType

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: # Cooldown: Timer based cooldown
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1: # HitOnce: Ensures the enemy only gets hit once
					if hit_once_array.has(area) == false:
						hit_once_array.append(area) # Track what they got hit by
						if area.has_signal("remove_from_array"): # Removes them once the attacking entity is removed
							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
								area.connect("remove_from_array", Callable(self, "remove_from_list"))
					else:
						return # If they have been hit already, return and end
				2: # Disable HitBox: Will disable the hitbox of the opposing entity
					if area.has_method("tempdisable"):
						area.tempdisable()
			# Creates vars in case the attack doesn't have them
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1 
			# Replaces the fill-in's with actual vars
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			emit_signal("hurt", damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)


func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)