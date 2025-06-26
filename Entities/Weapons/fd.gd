extends Area2D


var level = 1
var hp = 9999
var speed = 150
var damage = 5
var knockback = 100
var size = 1.0
var leri = false

var last_move = Vector2.ZERO
var angle = Vector2.ZERO
var angless = Vector2.ZERO
var anglemore = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var tsuu = preload("res://Graphics/Weapons/FD_FIST_TSUU.png")

signal remove_from_array(object)

func _ready():
	angle = global_position.direction_to(last_move)

	match level:
		1:
			hp = 9999
			speed = 150
			damage = 3
			knockback = 100
			size = 1.0 * (1 + player.add_size)
		2:
			hp = 9999
			speed = 150
			damage = 3
			knockback = 100
			size = 1.0 * (1 + player.add_size)
		3:
			hp = 9999
			speed = 150
			damage = 5
			knockback = 115
			size = 1.2 * (1 + player.add_size)
		4:
			hp = 9999
			speed = 150
			damage = 7
			knockback = 130
			size = 1.5 * (1 + player.add_size)
	modulate = Color.TRANSPARENT
	if leri:
		$Sprite2D.texture = tsuu
			
	var move_to_less = Vector2.ZERO
	var move_to_more = Vector2.ZERO
	match last_move:
		Vector2.UP, Vector2.DOWN:
			move_to_less = player.global_position + Vector2(randf_range(-0.25, -0.05), last_move.y)
			move_to_more = player.global_position + Vector2(randf_range(0.05, 0.25), last_move.y)
		Vector2.RIGHT, Vector2.LEFT:
			move_to_less = player.global_position + Vector2(last_move.x, randf_range(-0.25, -0.05))
			move_to_more = player.global_position + Vector2(last_move.x, randf_range(0.05, 0.25))
		Vector2(1, 1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1):
			move_to_less = player.global_position + Vector2(last_move.x, last_move.y * randf_range(0, 0.5))
			move_to_more = player.global_position + Vector2(last_move.x * randf_range(0, 0.5), last_move.y)
	
	angless = global_position.direction_to(move_to_less)
	anglemore = global_position.direction_to(move_to_more)
	
	var tween_start = create_tween()
	tween_start.tween_property(self, "modulate", Color.WHITE, 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	#var speed_final = speed
	#speed = speed / 5.0
	#tween_start.tween_property(self, "speed", speed_final, 6).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween_start.play()
	
	
	var tween = create_tween()
	var set_angle = randi_range(0, 1)
	if set_angle == 1:
		angle = angless
		tween.tween_property(self, "angle", anglemore, 5)
		#tween.tween_property(self, "angle", angless, 2)
	else:
		angle = anglemore
		tween.tween_property(self, "angle", angless, 5)
		#tween.tween_property(self, "angle", anglemore, 2)
	rotation = angle.angle() + deg_to_rad(135)
	tween.play()
	
func _physics_process(delta: float) -> void:
	position += angle*speed*delta
	
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()


func _on_timer_timeout() -> void:
	var tween_finish = create_tween()
	tween_finish.tween_property(self, "modulate", Color.TRANSPARENT, 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween_finish.play()

func _on_tween_finish_finished():
	emit_signal("remove_from_array", self)
	queue_free()
