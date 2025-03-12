extends CharacterBody2D


var SPEED = 100.0
var hp = 100


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


func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print(hp)
