extends CharacterBody2D


@export var speed = 100

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var dir = global_position.direction_to(player.global_position)
	velocity = dir * speed
	move_and_slide()
