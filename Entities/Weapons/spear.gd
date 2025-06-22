extends Area2D


var level = 1
var hp = 1
var speed = 150
var damage = 5
var knockback = 100
var size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 1
			speed = 150
			damage = 5
			knockback = 100
			size = 1.0
			
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
func _physics_process(delta: float) -> void:
	position += angle*speed*delta
	
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
