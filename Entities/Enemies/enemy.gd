extends CharacterBody2D


@export var speed = 50
@export var hp = 25

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var dir = global_position.direction_to(player.global_position)
	velocity = dir * speed
	move_and_slide()


func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	if hp <= 0:
		queue_free()
