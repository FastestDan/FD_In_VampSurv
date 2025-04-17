extends Node2D


@export var spawns: Array[Spawn_Info] = []

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0




func _on_timer_timeout() -> void:
	time += 1
	var enemy_spawns = spawns
	for teki in enemy_spawns:
		if teki.time_end >= time and time >= teki.time_start:
			if teki.spawn_delay_counter < teki.enemy_spawn_delay:
				teki.spawn_delay_counter += 1
			else:
				teki.spawn_delay_counter = 0
				var new_enemy = teki.enemy
				var counter = 0
				while counter < teki.enemy_num:
					var spawn_enemy = new_enemy.instantiate()
					spawn_enemy.global_position = get_random_position()
					add_child(spawn_enemy)
					counter += 1
					
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y - vpr.y / 2)
	var top_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y - vpr.y / 2)
	var bottom_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y + vpr.y / 2)
	var bottom_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y + vpr.y / 2)
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
