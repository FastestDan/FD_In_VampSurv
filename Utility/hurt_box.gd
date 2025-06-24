extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0


@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, angle, knockback)

var hit_once = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0:
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1:
					if hit_once.has(area) == false:
						hit_once.append(area)
						if area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
								area.connect("remove_from_array", Callable(self, "remove_from_list"))
					else:
						return
				2:
					if area.has_method("disable"):
						area.disable()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			
			if not area.get("angle") == null:
				angle = area.angle

			if not area.get("knockback") == null:
				knockback = area.knockback
			
			emit_signal("hurt", damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)


func remove_from_list(object):
	if hit_once.has(object):
		hit_once.erase(object)


func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
