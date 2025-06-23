extends Area2D


var level = 1
var hp = 9999
var speed = 300
var damage = 10
var knockback = 100
var size = 1.0
var paths = 1
var boost = 4.0

var target = Vector2.ZERO
var target_array = []
var angle = Vector2.ZERO
var reset = Vector2.ZERO


var eep = preload("res://Graphics/Weapons/SPEAR_TEST.png")
var beat = preload("res://Graphics/Weapons/STICK_TEST.png")


@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var attack_timer = get_node("%AttackTimer")
@onready var direction_timer = get_node("%DirectionTimer")
@onready var reset_timer = get_node("%ResetTimer")
@onready var sound = $Sound

signal remove_from_array(object)

func _ready():
	eep_beat()
	_on_reset_timer_timeout()

func eep_beat():
	level = player.stick_level
	
	match level:
		1:
			var hp = 9999
			var speed = 250
			var damage = 5
			var knockback = 100
			var size = 1.0
			var paths = 3
			var boost = 4.0
	scale = Vector2(0.25, 0.25) * size
	attack_timer.wait_time = boost

func _physics_process(delta: float) -> void:
	if target_array.size() > 0:
		position += angle*speed*delta
	else:
		var player_angle = global_position.direction_to(reset)
		var distance = global_position - player.global_position
		var back_speed = 20
		if abs(distance.x) > 500 or abs(distance.y) > 500:
			back_speed = 100
		position += player_angle * back_speed * delta
		rotation = global_position.direction_to(player.global_position).angle() + deg_to_rad(135)
	
	
#func enemy_hit(charge = 1):
	#hp -= charge
	#if hp <= 0:
		#emit_signal("remove_from_array", self)
		#queue_free()

func add_paths():
	sound.play()
	emit_signal("remove_from_array", self)
	target_array.clear()
	var counter = 0
	while counter < paths:
		var lockon = player.get_random_target()
		target_array.append(lockon)
		counter += 1
		enable_attack(true)
	target = target_array[0]
	process_path() 
	

func enable_attack(go=true):
	if go:
		collision.call_deferred("set", "disabed", false)
		sprite.texture = beat
	else:
		collision.call_deferred("set", "disabled", true)
		sprite.texture = eep

	
func process_path():
	angle = global_position.direction_to(target)
	direction_timer.start()
	var tween = create_tween()
	var rotatio = angle.angle() + deg_to_rad(135)
	tween.tween_property(self, "rotation", rotation, 0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	

func _on_attack_timer_timeout() -> void:
	add_paths()


func _on_direction_timer_timeout() -> void:
	if target_array.size() > 0:
		target_array.remove_at(0)
		if target_array.size() > 0:
			process_path()
			sound.play()
			emit_signal("remove_from_array", self)
		else:
			direction_timer.stop()
			attack_timer.start()
			enable_attack(false)
	else:
		direction_timer.stop()
		attack_timer.start()
		enable_attack(false)
		


func _on_reset_timer_timeout() -> void:
	var direction = randi() % 4
	reset = player.global_position
	match direction:
		0:
			reset.x += 50
		1:
			reset.x -= 50
		2:
			reset.y += 50
		3:
			reset.y -= 50
