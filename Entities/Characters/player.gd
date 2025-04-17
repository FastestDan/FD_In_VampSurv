extends CharacterBody2D


var SPEED = 150.0
var hp = 100
# Тут находятся оружия (смысл этого хардкода, если VampSurv - рогалик - непонятно)
var spear = preload("res://Entities/Weapons/spear.tscn")

@onready var speartimer = get_node("%SpearTimer")
@onready var spearattacktimer = get_node("Attacks/SpearTimer/SpearAttackTimer")

var spear_bullets = 0
var spear_magazine = 1
var spear_speed = 1.5
var spear_level = 1

var enemy_near = []


func _physics_process(delta: float) -> void:
	movement()
	
func movement():
	var vec = Input.get_vector("go_left", "go_right", "go_up", "go_down")
	velocity = vec.normalized() * SPEED
	#if velocity.length() > 0:
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
	move_and_slide()
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.x != 0:
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "FD_OB_Idle_Mirror"
		else:
			$AnimatedSprite2D.animation = "FD_OB_Idle"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	$AnimatedSprite2D.play()


func attack():
	if spear_level>0:
		speartimer.wait_time = spear.speed
		if speartimer.is_stopped():
			speartimer.start()

func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print(hp)


func _on_spear_timer_timeout() -> void:
	spear_bullets += spear_magazine
	spearattacktimer.start()


func _on_spear_attack_timer_timeout() -> void:
	if spear_bullets > 0:
		var spear_attack = spear.instantiate()
		spear_attack.position = position
		spear_attack.target = get_random_target()
		spear_attack.level = spear_level
		add_child(spear_attack)
		spear_bullets -= 1
		if spear_bullets > 0:
			spearattacktimer.start()
		else:
			spearattacktimer.stop()
		
func get_random_target():
	if enemy_near.size() > 0:
		return enemy_near.pick_random().global_position
	else:
		return self.velocitya


func _on_teki_detector_body_entered(body: Node2D) -> void:
	if not enemy_near.has(body):
		enemy_near.append(body)


func _on_teki_detector_body_exited(body: Node2D) -> void:
	if enemy_near.has(body):
		enemy_near.erase(body)
