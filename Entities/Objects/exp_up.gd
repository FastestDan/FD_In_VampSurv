extends Area2D


@export var exp = 1

var sprite_small = preload("res://Graphics/Objects/EXP_TEST_SMALL.png")
var sprite_med = preload("res://Graphics/Objects/EXP_TEST_MEDIUM.png")
var sprite_big = preload("res://Graphics/Objects/EXP_TEST_BIG.png")

var target = null
var speed = 0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $Sound


func _ready():
	if exp < 5:
		return
	elif exp < 25:
		sprite.texture = sprite_med
	else:
		sprite.texture = sprite_big
		
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta
		
func picked():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return exp


func _on_sound_finished() -> void:
	queue_free()
