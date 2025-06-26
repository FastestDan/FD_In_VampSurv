extends Area2D


var level = 1
var hp = 1
var speed = 200
var damage = 5
var knockback = 50
var size = 1.0

var last_move = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")


signal remove_from_array(object)

func _ready():
	match level:
		1:
			hp = 1
			speed = 200
			damage = 5
			knockback = 50
			size = 1.0 * (1 + player.add_size)
		2:
			hp = 1
			speed = 200
			damage = 5
			knockback = 50
			size = 1.0 * (1 + player.add_size)
		3:
			hp = 2
			speed = 200
			damage = 8
			knockback = 100
			size = 1.0 * (1 + player.add_size)
		4:
			hp = 2
			speed = 200
			damage = 8
			knockback = 100
			size = 1.2 * (1 + player.add_size)
	
	angle = global_position.direction_to(global_position + last_move * 500)
	rotation = angle.angle() + deg_to_rad(135)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
func _physics_process(delta: float) -> void:
	position += angle*speed*delta
	
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()


func _on_timer_timeout() -> void:
	emit_signal("remove_from_array", self)
	queue_free()
