extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0


@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0:
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1:
					pass
				2:
					if area.has_method("disable"):
						area.disable()
			var damage = area.damage
			emit_signal("hurt", damage)

func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
