extends Area2D

@export var damage = 5

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

func disable():
	collision.call_deferred("set", "disable", true)
	disableTimer.start()


func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set", "disable", false)
